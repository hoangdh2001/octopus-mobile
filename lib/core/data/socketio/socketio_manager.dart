import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:octopus/core/data/http/interceptors/token_manager.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/chat_error_code.dart';
import 'package:octopus/core/data/socketio/connection_status.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/data/socketio/timer_helper.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:logging/logging.dart';

typedef EventHandler = void Function(Event);

class SocketIOManager with TimerHelper {
  final String baseUrl;
  final Logger? _logger;

  final EventHandler? handler;

  final TokenManager tokenManager;

  User? _user;

  DateTime? _lastEventAt;
  Socket? _socketio;

  Completer<Event>? connectionCompleter;

  final _connectionStatusController =
      BehaviorSubject.seeded(ConnectionStatus.disconnected);

  set _connectionStatus(ConnectionStatus status) =>
      _connectionStatusController.add(status);

  ConnectionStatus get connectionStatus => _connectionStatusController.value;

  Stream<ConnectionStatus> get connectionStatusStream =>
      _connectionStatusController.stream.distinct();

  String? _connectionId;

  String? get connectionId => _connectionId;

  SocketIOManager({
    required this.baseUrl,
    required this.tokenManager,
    Logger? logger,
    this.handler,
  }) : _logger = logger;

  void _initWebSocketChannel(Uri uri) {
    _logger?.info('Initiating connection with $baseUrl');
    _socketio = io(
        uri.toString(),
        OptionBuilder()
            .setTransports(['websocket'])
            .setTimeout(10000)
            .disableAutoConnect()
            .enableReconnection()
            .build());
    _socketio?.connect();
    _subscribeToWebSocketChannel();
  }

  void _closeWebSocketChannel() {
    _logger?.info('Closing connection with $baseUrl');
    if (_socketio != null) {
      _socketio?.dispose();
      _socketio = null;
    }
  }

  void _subscribeToWebSocketChannel() {
    _logger?.info('Started listening to $baseUrl');
    _socketio?.on('messages', _onDataReceived);
    _socketio?.onError(_onConnectionError);
    _socketio?.onDisconnect(_onConnectionClosed);
    _socketio?.onConnect((data) {
      _logger?.info(data);
    });
    _socketio?.onConnecting((data) {
      _logger?.info('connecting');
    });
    _socketio?.onConnectTimeout(_onConnectionClosed);
    // _socketio?.onclose(_onConnectionClosed);
  }

  void _onConnectionClosed(dynamic data) {
    _logger?.warning('Connection closed');

    // resetting connect, reconnect request flag
    _resetRequestFlags();

    // resetting connection
    _connectionId = null;

    // check if we manually closed the connection
    if (_manuallyClosed) return;
    _reconnect();
  }

  void _onDataReceived(dynamic data) {
    final jsonData = data as Map<String, dynamic>;
    final error = jsonData['error'] as Map<String, Object?>?;
    if (error != null) return _handleStreamError(error);

    // resetting connect, reconnect request flag
    _resetRequestFlags(resetAttempts: true);

    Event? event;
    try {
      event = Event.fromJson(jsonData);
    } catch (e, stk) {
      _logger?.warning('Error parsing an event: $e');
      _logger?.warning('Stack trace: $stk');
    }

    if (event == null) return;

    _lastEventAt = DateTime.now();
    _logger?.info('Event received: ${event.type}');

    if (event.type == EventType.healthCheck) {
      // if (event.me != null) {
      _handleConnectedEvent(event);
      // } else {
      //   _handleHealthCheckEvent(event);
      // }
    }

    return handler?.call(event);
  }

  void _handleConnectedEvent(Event event) {
    _connectionId = event.connectionID;
    _connectionStatus = ConnectionStatus.connected;

    _logger?.info('Connection successful: $_connectionId');

    // notify user that connection is completed
    final completer = connectionCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.complete(event);
    }
  }

  void _handleStreamError(Map<String, Object?> errorResponse) {
    // resetting connect, reconnect request flag
    _resetRequestFlags();

    final error = SocketError.fromStreamError(errorResponse);
    final isTokenExpired = error.errorCode == ChatErrorCode.tokenExpired;
    if (isTokenExpired) {
      _logger?.warning('Connection failed, token expired');
      return _reconnect(refreshToken: true);
    }

    _logger?.severe('Connection failed', error);

    final completer = connectionCompleter;
    // complete with error if not yet completed
    if (completer != null && !completer.isCompleted) {
      // complete the connection with error
      completer.completeError(error);
      // disconnect the web-socket connection
      return disconnect();
    }

    return _reconnect();
  }

  bool _connectRequestInProgress = false;

  bool _manuallyClosed = false;

  Future<Event> connect(
    User user, {
    bool includeUserDetails = false,
  }) async {
    if (_connectRequestInProgress) {
      throw const SocketError(
          '''
        You've called connect twice,
        can only attempt 1 connection at the time,
        ''');
    }
    _connectRequestInProgress = true;
    _manuallyClosed = false;

    _user = user;
    _connectionStatus = ConnectionStatus.connecting;
    connectionCompleter = Completer<Event>();

    try {
      final uri = await _buildUri();
      _initWebSocketChannel(uri);
    } catch (e, stk) {
      _onConnectionError(e, stk);
    }

    return connectionCompleter!.future;
  }

  Future<Uri> _buildUri({
    bool refreshToken = false,
    bool includeUserDetails = true,
  }) async {
    final user = _user!;
    final token = await tokenManager.loadToken(refresh: refreshToken);
    final params = {
      'user_id': user.id,
      'user_details': includeUserDetails ? user : {'id': user.id},
      'user_token': token.rawValue,
      'server_determines_connection_id': true,
    };
    final qs = {
      'data': jsonEncode(params),
      'authorization': token.rawValue,
    };
    final local = baseUrl.contains('localhost:80') ||
        baseUrl.contains('192.168.20.102:80') ||
        baseUrl.contains('192.168.20.103:80') ||
        baseUrl.contains('192.168.20.104:80') ||
        baseUrl.contains('10.0.2.2:80');
    final scheme = baseUrl.startsWith('https') ? 'https' : 'http';
    final host =
        local ? 'localhost' : baseUrl.replaceAll(RegExp(r'(^\w+:|^)\/\/'), '');
    return Uri(
      scheme: scheme,
      host: host,
      port: local ? 80 : null,
      queryParameters: qs,
    );
  }

  void _onConnectionError(error, [stacktrace]) {
    _logger?.warning('Error occurred', error, stacktrace);

    SocketError wsError;
    if (error is SocketError) {
      wsError = SocketError.fromWebSocketChannelError(error);
    } else {
      wsError = SocketError(error.toString());
    }

    final completer = connectionCompleter;
    // complete with error if not yet completed
    if (completer != null && !completer.isCompleted) {
      // complete the connection with error
      completer.completeError(wsError);
    }

    // resetting connect, reconnect request flag
    _resetRequestFlags();

    _reconnect();
  }

  int _reconnectAttempt = 0;
  bool _reconnectRequestInProgress = false;

  void _reconnect({bool refreshToken = false}) async {
    _logger?.info('Retrying connection : $_reconnectAttempt');
    if (_reconnectRequestInProgress) return;
    _reconnectRequestInProgress = true;

    // Closing any previously opened web-socket
    _closeWebSocketChannel();

    _reconnectAttempt += 1;
    _connectionStatus = ConnectionStatus.connecting;

    final delay = _getReconnectInterval(_reconnectAttempt);
    setTimer(
      Duration(milliseconds: delay),
      () async {
        try {
          final uri = await _buildUri();
          _initWebSocketChannel(uri);
        } catch (e, stk) {
          _onConnectionError(e, stk);
        }
      },
    );
  }

  int _getReconnectInterval(int reconnectAttempt) {
    // try to reconnect in 0.25-25 seconds
    // (random to spread out the load from failures)
    final max = math.min(500 + reconnectAttempt * 2000, 25000);
    final min = math.min(
      math.max(250, (reconnectAttempt - 1) * 2000),
      25000,
    );
    return (math.Random().nextDouble() * (max - min) + min).floor();
  }

  void _resetRequestFlags({bool resetAttempts = false}) {
    _connectRequestInProgress = false;
    _reconnectRequestInProgress = false;
    if (resetAttempts) _reconnectAttempt = 0;
  }

  void disconnect() {
    if (connectionStatus == ConnectionStatus.disconnected) return;

    _resetRequestFlags(resetAttempts: true);

    _connectionStatus = ConnectionStatus.disconnected;

    _logger?.info('Disconnecting web-socket connection');
    _user = null;
    // resetting user
    connectionCompleter = null;

    _manuallyClosed = true;

    _closeWebSocketChannel();
  }
}
