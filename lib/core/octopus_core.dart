import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/connection_status.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/ui/notification_service.dart';
import 'package:octopus/core/ui/typedef.dart';

class OctopusCore extends StatefulWidget {
  const OctopusCore({
    super.key,
    required this.client,
    required this.child,
    this.onBackgroundEventReceived,
    this.backgroundKeepAlive = const Duration(minutes: 1),
    this.connectivityStream,
    this.tokenRefreshStream,
  });

  final Client client;

  final Widget child;

  final Duration backgroundKeepAlive;

  final EventHandler? onBackgroundEventReceived;

  @visibleForTesting
  final Stream<ConnectivityResult>? connectivityStream;

  final Stream<String?>? tokenRefreshStream;

  @override
  OctopusCoreState createState() => OctopusCoreState();

  static OctopusCoreState of(BuildContext context) {
    OctopusCoreState? octopusCoreState;

    octopusCoreState = context.findAncestorStateOfType<OctopusCoreState>();

    assert(
      octopusCoreState != null,
      'You must have a StreamChat widget at the top of your widget tree',
    );

    return octopusCoreState!;
  }
}

class OctopusCoreState extends State<OctopusCore> with WidgetsBindingObserver {
  Client get client => widget.client;

  Timer? _disconnectTimer;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  User? get currentUser => client.state.currentUser;

  Stream<User?> get currentUserStream => client.state.currentUserStream;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  StreamSubscription<String?>? _tokenRefreshSubscription;

  StreamSubscription? _subscription;

  var _isInForeground = true;
  var _isConnectionAvailable = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscribeToConnectivityChange(widget.connectivityStream);
    _subscribeTokenRefreshStream(widget.tokenRefreshStream);
    _subscribeObserver();
  }

  void _subscribeObserver() {
    _subscription = client
        .on(
      EventType.messageNew,
      EventType.notificationMessageNew,
    )
        .listen((event) {
      if (event.message?.sender?.id == client.state.currentUser?.id) {
        return;
      }
      final channelId = event.channelID;
      final location = GoRouter.of(context).location;
      if (location.startsWith('/messages/channel')) {
        final uri = Uri.parse(location);
        final channelID = uri.queryParameters['channelID'];
        if (channelID == channelId) {
          return;
        }
      }

      showLocalNotification(
        event,
        client.state.currentUser!.id,
        context,
      );
    });
  }

  void _subscribeToConnectivityChange(
      [Stream<ConnectivityResult>? connectivityStream]) {
    if (_connectivitySubscription == null) {
      connectivityStream ??= Connectivity().onConnectivityChanged;
      _connectivitySubscription =
          connectivityStream.distinct().listen((result) {
        _isConnectionAvailable = result != ConnectivityResult.none;
        if (!_isInForeground) return;
        if (_isConnectionAvailable) {
          if (client.ioConnectionStatus == ConnectionStatus.disconnected &&
              currentUser != null) {
            client.openConnection();
          }
        } else {
          if (client.ioConnectionStatus == ConnectionStatus.connected) {
            client.closeConnection();
          }
        }
      });
    }
  }

  void _subscribeTokenRefreshStream(Stream<String?>? tokenRefreshStream) {
    _tokenRefreshSubscription = tokenRefreshStream?.listen((newToken) async {
      client.addDevice(newToken!, 'firebase');
    });
  }

  void _unsubscribeFromConnectivityChange() {
    if (_connectivitySubscription != null) {
      _connectivitySubscription?.cancel();
      _connectivitySubscription = null;
    }
  }

  void _unsubcribeFromTokenRefresh() {
    if (_tokenRefreshSubscription != null) {
      _tokenRefreshSubscription?.cancel();
      _tokenRefreshSubscription = null;
    }
  }

  @override
  void didUpdateWidget(OctopusCore oldWidget) {
    super.didUpdateWidget(oldWidget);
    final connectivityStream = widget.connectivityStream;
    final tokenRefreshStream = widget.tokenRefreshStream;
    if (connectivityStream != oldWidget.connectivityStream) {
      _unsubscribeFromConnectivityChange();
      _subscribeToConnectivityChange(connectivityStream);
    }
    if (tokenRefreshStream != oldWidget.tokenRefreshStream) {
      _unsubcribeFromTokenRefresh();
      _subscribeTokenRefreshStream(tokenRefreshStream);
    }
  }

  StreamSubscription? _eventSubscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInForeground = [
      AppLifecycleState.resumed,
      AppLifecycleState.inactive,
    ].contains(state);
    if (currentUser != null) {
      if (_isInForeground) {
        _onForeground();
      } else {
        _onBackground();
      }
    }
  }

  void _onForeground() {
    if (_disconnectTimer?.isActive == true) {
      _eventSubscription?.cancel();
      _disconnectTimer?.cancel();
    } else if (client.ioConnectionStatus == ConnectionStatus.disconnected &&
        _isConnectionAvailable) {
      client.openConnection();
    }
  }

  void _onBackground() {
    if (widget.onBackgroundEventReceived == null) {
      if (client.ioConnectionStatus != ConnectionStatus.disconnected) {
        client.closeConnection();
      }
      return;
    }

    _eventSubscription = client.on().listen(widget.onBackgroundEventReceived);

    void onTimerComplete() {
      _eventSubscription?.cancel();
      client.closeConnection();
    }

    _disconnectTimer = Timer(widget.backgroundKeepAlive, onTimerComplete);
    return;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _unsubscribeFromConnectivityChange();
    _unsubcribeFromTokenRefresh();
    _eventSubscription?.cancel();
    _disconnectTimer?.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}
