import 'dart:async';

import 'package:logging/logging.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/http/interceptors/token_manager.dart';
import 'package:octopus/core/data/http/interceptors/token_raw.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/own_user.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/data/socketio/connection_status.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/data/socketio/socketio_manager.dart';
import 'package:rxdart/rxdart.dart';

class Client {
  late final SocketIOManager _io;
  late ClientState state;
  final Logger logger;

  final _ioConnectionStatusController =
      BehaviorSubject.seeded(ConnectionStatus.disconnected);

  set _ioConnectionStatus(ConnectionStatus status) =>
      _ioConnectionStatusController.add(status);

  ConnectionStatus get ioConnectionStatus =>
      _ioConnectionStatusController.value;

  Stream<ConnectionStatus> get wsConnectionStatusStream =>
      _ioConnectionStatusController.stream.distinct();

  StreamSubscription<ConnectionStatus>? _connectionStatusSubscription;

  final _eventController = BehaviorSubject<Event>();

  Stream<Event> get eventStream => _eventController.stream;

  final ChannelRepository _channelRepository;

  final _tokenManager = TokenManager();

  final UserRepository _userRepository;

  Client({
    required ChannelRepository channelRepository,
    required UserRepository userRepository,
    required String baseUrl,
    required this.logger,
    required Logger socketLogger,
  })  : _channelRepository = channelRepository,
        _userRepository = userRepository {
    _io = SocketIOManager(
        baseUrl: baseUrl,
        logger: socketLogger,
        handler: handleEvent,
        tokenManager: _tokenManager);
    state = ClientState(this);
  }

  Future<void> connectUser(
    Token token, {
    bool connectWebSocket = true,
  }) =>
      _connectUser(
        token.user,
        token: TokenRaw.fromRawValue(token.accessToken),
        connectWebSocket: connectWebSocket,
      );

  Future<void> _connectUser(
    User user, {
    TokenRaw? token,
    TokenProvider? provider,
    bool connectWebSocket = true,
  }) async {
    if (_io.connectionCompleter?.isCompleted == false) {
      throw const OCError(
        'User already getting connected, try calling `disconnectUser` '
        'before trying to connect again',
      );
    }
    logger.info('setting user : ${user.id}');

    await _tokenManager.setTokenOrProvider(
      user.id,
      token: token,
      provider: provider,
    );

    final ownUser = OwnUser.fromUser(user);
    state.currentUser = ownUser;

    try {
      final connectedUser = await openConnection();
    } catch (e, stk) {
      // if (e is SocketError && e.isRetriable) {
      //   final event = await _chatPersistenceClient?.getConnectionInfo();
      //   if (event != null) return ownUser.merge(event.me);
      // }
      logger.severe('error connecting user : ${user.id}', e, stk);
      rethrow;
    }
  }

  Future<void> openConnection() async {
    assert(
      state.currentUser != null,
      'User is not set on client, '
      'use `connectUser` or `connectAnonymousUser` instead',
    );

    final user = state.currentUser!;

    logger.info('Opening web-socket connection for ${user.id}');

    if (ioConnectionStatus == ConnectionStatus.connecting) {
      throw OCError('Connection already in progress for ${user.id}');
    }

    if (ioConnectionStatus == ConnectionStatus.connected) {
      throw OCError('Connection already available for ${user.id}');
    }

    _ioConnectionStatus = ConnectionStatus.connecting;

    _connectionStatusSubscription =
        _io.connectionStatusStream.skip(1).listen(_connectionStatusHandler);

    try {
      final event = await _io.connect(user);

      state.subscribeToEvents();

      user.merge(event.me);
    } catch (e, stk) {
      logger.severe('error connecting ws', e, stk);
      rethrow;
    }
  }

  Future<void> disconnectUser({bool flushChatPersistence = false}) async {
    logger.info('Disconnecting user : ${state.currentUser?.id}');

    // resetting state
    state.dispose();
    state = ClientState(this);
    // _lastSyncedAt = null;

    // resetting credentials
    _tokenManager.reset();
    // _connectionIdManager.reset();

    // disconnecting persistence client
    // await _chatPersistenceClient?.disconnect(flush: flushChatPersistence);
    // _chatPersistenceClient = null;

    // closing web-socket connection
    closeConnection();
  }

  void closeConnection() {
    if (ioConnectionStatus == ConnectionStatus.disconnected) return;

    logger.info('Closing web-socket connection for ${state.currentUser?.id}');
    _ioConnectionStatus = ConnectionStatus.disconnected;

    _connectionStatusSubscription?.cancel();
    _connectionStatusSubscription = null;

    // // Stop listening to events
    state.cancelEventSubscription();

    _io.disconnect();
  }

  void _connectionStatusHandler(ConnectionStatus status) async {
    final previousState = ioConnectionStatus;
    final currentState = _ioConnectionStatus = status;

    handleEvent(Event(
      type: EventType.connectionChanged,
      // online: status == ConnectionStatus.connected,
    ));

    if (currentState == ConnectionStatus.connected &&
        previousState != ConnectionStatus.connected) {
      handleEvent(Event(
        type: EventType.connectionRecovered,
      ));
    }
  }

  List<Channel> addChannel(List<ChannelState> channels) {
    final updateData = _mapChannelStateToChannel(channels);
    state.addChannels(updateData.key);

    return updateData.value;
  }

  MapEntry<Map<String, Channel>, List<Channel>> _mapChannelStateToChannel(
    List<ChannelState> channelStates,
  ) {
    final channels = {...state.channels};
    final newChannels = <Channel>[];
    for (final channelState in channelStates) {
      final channel = channels[channelState.channel!.id];
      if (channel != null) {
        channel.state?.updateChannelState(channelState);
        newChannels.add(channel);
      } else {
        final newChannel =
            Channel.fromState(this, channelState, _channelRepository);
        if (newChannel.id != null) {
          channels[newChannel.id!] = newChannel;
        }
        newChannels.add(newChannel);
      }
    }
    return MapEntry(channels, newChannels);
  }

  void handleEvent(Event event) {
    // state.updateUser(event.user);
    return _eventController.add(event);
  }

  Channel channel({
    String? id,
    Map<String, Object?>? extraData,
  }) {
    if (id != null && state.channels.containsKey(id)) {
      return state.channels[id]!;
    }
    return Channel(
      this,
      _channelRepository,
      id,
    );
  }

  Future<void> addDevice(String token, String pushProvider) async {
    await _userRepository.addDevice(state.currentUser!.id,
        Device(deviceID: token, pushProvider: pushProvider));
  }

  Future<void> removeDevice(String deviceID) async {
    await _userRepository.removeDevice(state.currentUser!.id, deviceID);
  }

  Stream<Event> on([
    String? eventType,
    String? eventType2,
    String? eventType3,
    String? eventType4,
  ]) {
    if (eventType == null) return eventStream;
    return eventStream.where((event) =>
        event.type == eventType ||
        event.type == eventType2 ||
        event.type == eventType3 ||
        event.type == eventType4);
  }

  Future<void> dispose() async {
    logger.info('Disposing new StreamChatClient');

    // disposing state
    state.dispose();

    closeConnection();

    await _eventController.close();
    await _ioConnectionStatusController.close();
  }
}

class ClientState {
  final Client _client;

  ClientState(this._client);

  CompositeSubscription? _eventsSubscription;

  void subscribeToEvents() {
    if (_eventsSubscription != null) {
      cancelEventSubscription();
    }

    _eventsSubscription = CompositeSubscription();
    // _eventsSubscription!
    //   ..add(_client
    //       .on()
    //       .where((event) =>
    //           event.me != null && event.type != EventType.healthCheck)
    //       .map((e) => e.me!)
    //       .listen((user) {
    //     currentUser = currentUser?.merge(user) ?? user;
    //   }))
    //   ..add(_client
    //       .on()
    //       .map((event) => event.unreadChannels)
    //       .whereType<int>()
    //       .listen((count) {
    //     currentUser = currentUser?.copyWith(unreadChannels: count);
    //   }))
    //   ..add(_client
    //       .on()
    //       .map((event) => event.totalUnreadCount)
    //       .whereType<int>()
    //       .listen((count) {
    //     currentUser = currentUser?.copyWith(totalUnreadCount: count);
    //   }));

    _listenChannelDeleted();

    _listenChannelHidden();

    // _listenUserUpdated();

    // _listenAllChannelsRead();
  }

  // void updateUser(User? user) => updateUsers([user]);

  void cancelEventSubscription() {
    if (_eventsSubscription != null) {
      _eventsSubscription!.cancel();
      _eventsSubscription = null;
    }
  }

  /// Pauses listening to the client events.
  void pauseEventSubscription([Future<void>? resumeSignal]) {
    _eventsSubscription?.pause(resumeSignal);
  }

  /// Resumes listening to the client events.
  void resumeEventSubscription() {
    _eventsSubscription?.resume();
  }

  void _listenChannelHidden() {
    _eventsSubscription?.add(
      _client.on(EventType.channelHidden).listen((event) async {
        final eventChannel = event.channel!.channel;
        channels[eventChannel!.id]?.dispose();
      }),
    );
  }

  // void _listenUserUpdated() {
  //   _eventsSubscription?.add(
  //     _client.on(EventType.userUpdated).listen((event) {
  //       if (event.user!.id == currentUser!.id) {
  //         currentUser = OwnUser.fromJson(event.user!.toJson());
  //       }
  //       updateUser(event.user);
  //     }),
  //   );
  // }

  // void _listenAllChannelsRead() {
  //   _eventsSubscription?.add(
  //     _client.on(EventType.notificationMarkRead).listen((event) {
  //       if (event.cid == null) {
  //         channels.forEach((key, value) {
  //           value.state?.unreadCount = 0;
  //         });
  //       }
  //     }),
  //   );
  // }

  void _listenChannelDeleted() {
    _eventsSubscription?.add(
      _client
          .on(
        EventType.channelDeleted,
        EventType.notificationRemovedFromChannel,
        EventType.notificationChannelDeleted,
      )
          .listen((Event event) async {
        final eventChannel = event.channel!.channel!;
        channels[eventChannel.id]?.dispose();
      }),
    );
  }

  set currentUser(OwnUser? user) {
    _currentUserController.add(user);
  }

  OwnUser? get currentUser => _currentUserController.valueOrNull;

  /// The current user as a stream
  Stream<OwnUser?> get currentUserStream => _currentUserController.stream;

  Stream<Map<String, Channel>> get channelsStream => _channelsController.stream;

  Map<String, Channel> get channels => _channelsController.value;

  set channels(Map<String, Channel> newChannels) {
    _channelsController.add(newChannels);
  }

  void addChannels(Map<String, Channel> channelMap) {
    final newChannels = {
      ...channels,
      ...channelMap,
    };
    channels = newChannels;
  }

  void removeChannel(String channelCid) {
    channels = channels..remove(channelCid);
  }

  final _channelsController = BehaviorSubject<Map<String, Channel>>.seeded({});
  final _currentUserController = BehaviorSubject<OwnUser?>();

  void dispose() {
    cancelEventSubscription();
    _currentUserController.close();
    // _unreadChannelsController.close();
    // _totalUnreadCountController.close();

    final channels = this.channels.values.toList();
    for (final channel in channels) {
      channel.dispose();
    }
    _channelsController.close();
  }
}
