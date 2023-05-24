import 'dart:async';

import 'package:logging/logging.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/client/connection_id_manager.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/http/interceptors/token_manager.dart';
import 'package:octopus/core/data/http/interceptors/token_raw.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/own_user.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/search_message_response.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/data/repositories/workspace_repository.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/data/socketio/connection_status.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/data/socketio/socketio_manager.dart';
import 'package:octopus/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

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

  final WorkspaceRepository _workspaceRepository;

  final _connectionIdManager = ConnectionIdManager();

  Client({
    required ChannelRepository channelRepository,
    required UserRepository userRepository,
    required WorkspaceRepository workspaceRepository,
    required String baseUrl,
    required this.logger,
    required Logger socketLogger,
    WorkspaceState? currentWorkspace,
  })  : _channelRepository = channelRepository,
        _userRepository = userRepository,
        _workspaceRepository = workspaceRepository {
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
    _connectionIdManager.reset();

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
      active: status == ConnectionStatus.connected,
    ));

    if (currentState == ConnectionStatus.connected &&
        previousState != ConnectionStatus.connected) {
      handleEvent(Event(
        type: EventType.connectionRecovered,
        active: true,
      ));
    }
  }

  Future<List<Workspace>> searchWorkspaces(
    Filter? filter, {
    String? query,
    List<SortOption>? sort,
    PaginationParams pagination = const PaginationParams(),
  }) async {
    final workspace = await _workspaceRepository.searchWorkspace(
      filter,
      query: query,
      sort: sort,
      pagination: pagination,
    );

    final updateData = _mapWorkspaceStateToWorkspace(workspace);

    state.workspaces = updateData.key;
    return updateData.value;
  }

  MapEntry<Map<String, Workspace>, List<Workspace>>
      _mapWorkspaceStateToWorkspace(
    List<WorkspaceState> workspaceStates,
  ) {
    final workspaces = {...state.workspaces};
    final newWorkspaces = <Workspace>[];
    for (final workspaceState in workspaceStates) {
      final workspace = workspaces[workspaceState.id];
      if (workspace != null) {
        workspace.state?.updateWorkspaceState(workspaceState);
        newWorkspaces.add(workspace);
      } else {
        final newWorkspace =
            Workspace.fromState(this, workspaceState, _workspaceRepository);
        if (newWorkspace.id != null) {
          workspaces[newWorkspace.id!] = newWorkspace;
        }
        newWorkspaces.add(newWorkspace);
      }
    }
    return MapEntry(workspaces, newWorkspaces);
  }

  Future<List<Workspace>> getWorkspace() async {
    final workspace = await _workspaceRepository.getWorkspaceByUser();
    final updateData = _mapWorkspaceStateToWorkspace(workspace);
    state.workspaces = updateData.key;

    return updateData.value;
  }

  // Future<List<Workspace>> queryWorkspace() async {
  //   final workspace = await getWorkspace();

  //   final updateData = _mapWorkspaceStateToWorkspace(workspace);
  //   state.workspaces = updateData.key;

  //   return updateData.value;
  // }

  Future<Workspace> createWorkspace({
    required String name,
  }) async {
    final workspace = await _workspaceRepository
        .createWorkspace(name, members: [state.currentUser!.id]);
    final updateData = _mapWorkspaceStateToWorkspace([workspace]);

    state.workspaces = updateData.key;
    return updateData.value.first;
  }

  final _queryChannelsStreams = <String, Future<List<Channel>>>{};

  Stream<List<Channel>> queryChannels({
    Filter? filter,
    List<SortOption<ChannelModel>>? sort,
    int? memberLimit,
    int? messageLimit,
    PaginationParams paginationParams = const PaginationParams(),
    bool waitForConnect = true,
  }) async* {
    final hash = generateHash([
      filter,
      sort,
      memberLimit,
      messageLimit,
      paginationParams,
    ]);

    if (_queryChannelsStreams.containsKey(hash)) {
      yield await _queryChannelsStreams[hash]!;
    } else {
      // final channels = await queryChannelsOffline(
      //   filter: filter,
      //   sort: sort,
      //   paginationParams: paginationParams,
      // );
      // if (channels.isNotEmpty) yield channels;

      try {
        final newQueryChannelsFuture = queryChannelsOnline(
          filter: filter,
          sort: sort,
          memberLimit: memberLimit,
          messageLimit: messageLimit,
          paginationParams: paginationParams,
          waitForConnect: waitForConnect,
        ).whenComplete(() {
          _queryChannelsStreams.remove(hash);
        });

        _queryChannelsStreams[hash] = newQueryChannelsFuture;

        yield await newQueryChannelsFuture;
      } catch (_) {
        rethrow;
      }
    }
  }

  Future<List<Channel>> queryChannelsOnline({
    Filter? filter,
    List<SortOption<ChannelModel>>? sort,
    int? memberLimit,
    int? messageLimit,
    bool waitForConnect = true,
    PaginationParams paginationParams = const PaginationParams(),
  }) async {
    if (waitForConnect) {
      if (_io.connectionCompleter?.isCompleted == false) {
        logger.info('awaiting connection completer');
        await _io.connectionCompleter?.future;
      }
      if (ioConnectionStatus != ConnectionStatus.connected) {
        throw const OCError(
          'You cannot use queryChannels without an active connection. '
          'Please call `connectUser` to connect the client.',
        );
      }
    }

    logger.info('Query channel start');
    final page = await _channelRepository.getChannels(
      filter: filter,
      sort: sort,
      memberLimit: memberLimit,
      messageLimit: memberLimit,
      pagination: paginationParams,
    );

    if (page.data.isEmpty && paginationParams.offset == 0) {
      logger.warning('''
        We could not find any channel for this query.
        Please make sure to take a look at the Flutter tutorial: https://getstream.io/chat/flutter/tutorial
        If your application already has users and channels, you might need to adjust your query channel as explained in the docs https://getstream.io/chat/docs/query_channels/?language=dart
        ''');
      return <Channel>[];
    }

    final channels = page.data;

    // final users = channels
    //     .expand((it) => it.members ?? <Member>[])
    //     .map((it) => it.user)
    //     .toList(growable: false);

    // this.state.updateUsers(users);

    logger.info('Got ${page.data.length} channels from api');

    final updateData = _mapChannelStateToChannel(channels);

    // await _chatPersistenceClient?.updateChannelQueries(
    //   filter,
    //   channels.map((c) => c.channel!.cid).toList(),
    //   clearQueryCache: paginationParams.offset == 0,
    // );

    state.channels = updateData.key;
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

  Future<List<User>> queryUser({
    Filter? filter,
    List<SortOption>? sort,
    PaginationParams? pagination,
  }) async {
    final users = await _userRepository.getUsers(
        filter: filter, sort: sort, pagination: pagination);
    return users;
  }

  Future<EmptyResponse> leaveChannel(Channel channel, String userID) async {
    final response =
        await _channelRepository.removeMembers(channel.id!, userID, 'leave');
    state.removeChannel(channel.id!);
    return response;
  }

  void _handleHealthCheckEvent(Event event) {
    final user = event.me;
    if (user != null) state.currentUser = user;

    final connectionId = event.connectionID;
    if (connectionId != null) {
      _connectionIdManager.setConnectionId(connectionId);
    }
  }

  void handleEvent(Event event) {
    if (event.type == EventType.healthCheck) {
      return _handleHealthCheckEvent(event);
    }
    // state.updateUser(event.user);
    return _eventController.add(event);
  }

  Channel channel({
    String? id,
    String? name,
    List<String>? members,
  }) {
    if (id != null && state.channels.containsKey(id)) {
      return state.channels[id]!;
    }
    return Channel(
      this,
      _channelRepository,
      id,
      name: name,
      members: members,
    );
  }

  Future<Channel> createChannel({
    String? name,
    required List<String> members,
  }) async {
    final channel = await _channelRepository.createChannel(
      name: name,
      newMembers: members,
    );
    final updateData = _mapChannelStateToChannel([channel]);

    state.channels = updateData.key;
    return updateData.value.first;
  }

  Future<void> addDevice(String token, String pushProvider) async {
    await _userRepository.addDevice(state.currentUser!.id,
        Device(deviceID: token, pushProvider: pushProvider));
  }

  Future<void> removeDevice(String deviceID) async {
    await _userRepository.removeDevice(state.currentUser!.id, deviceID);
  }

  Future<ChannelState> updateChannel(
          String id, Map<String, Object?> channelData,
          [Message? updateMessage]) =>
      _channelRepository.udpateChannel(id, channelData);

  Future<EmptyResponse> muteChannel(
    String channelID, {
    Duration? expiration,
  }) =>
      _channelRepository.muteChannel(
        channelID,
      );

  /// Unmutes the channel
  Future<EmptyResponse> unmuteChannel(String channelID) =>
      _channelRepository.unmuteChannel(channelID);

  Future<SearchMessagesResponse> search(
    Filter filter, {
    String? query,
    List<SortOption>? sort,
    PaginationParams? paginationParams,
    Filter? messageFilters,
    Filter? attachmentFilters,
  }) =>
      _channelRepository.search(
        filter,
        query: query,
        sort: sort,
        pagination: paginationParams,
        messageFilters: messageFilters,
        attachmentFilters: attachmentFilters,
      );

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
    _eventsSubscription!.add(_client
            .on()
            .where((event) =>
                event.me != null && event.type != EventType.healthCheck)
            .map((e) => e.me!)
            .listen((user) {
      currentUser = currentUser?.merge(user) ?? user;
    }))
        // ..add(_client
        //     .on()
        //     .map((event) => event.unreadChannels)
        //     .whereType<int>()
        //     .listen((count) {
        //   currentUser = currentUser?.copyWith(unreadChannels: count);
        // }))
        // ..add(_client
        //     .on()
        //     .map((event) => event.totalUnreadCount)
        //     .whereType<int>()
        //     .listen((count) {
        //   currentUser = currentUser?.copyWith(totalUnreadCount: count);
        // }))
        ;

    // _listenerChannelCreated();

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

  // void _listenerChannelCreated() {
  //   _eventsSubscription?.add(
  //     _client.on(EventType.channelCreated).listen((event) {
  //       final eventChannel = event.channel;
  //       if (eventChannel != null) {
  //         final channel = Channel.fromState(
  //           _client,
  //           eventChannel,
  //           _client._channelRepository,
  //         );
  //         addChannels({
  //           ...channels,
  //           channel.id!: channel,
  //         });
  //       }
  //     }),
  //   );
  // }

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

  void _listenAllChannelsRead() {
    _eventsSubscription?.add(
      _client.on(EventType.notificationMarkRead).listen((event) {
        if (event.channelID == null) {
          channels.forEach((key, value) {
            value.state?.unreadCount = 0;
          });
        }
      }),
    );
  }

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

  Stream<OwnUser?> get currentUserStream => _currentUserController.stream;

  int get unreadChannels => _unreadChannelsController.value;

  Stream<int> get unreadChannelsStream => _unreadChannelsController.stream;

  int get totalUnreadCount => _totalUnreadCountController.value;

  Stream<int> get totalUnreadCountStream => _totalUnreadCountController.stream;

  Stream<Map<String, Workspace>> get workspacesStream =>
      _workspacesController.stream;

  Map<String, Workspace> get workspaces => _workspacesController.value;

  Stream<Map<String, Channel>> get channelsStream => _channelsController.stream;

  Map<String, Channel> get channels => _channelsController.value;

  Stream<Workspace?> get currentWorkspaceStream =>
      _currentWorkspaceController.stream;

  Workspace? get currentWorkspace => _currentWorkspaceController.valueOrNull;

  set totalUnreadCount(int unreadCount) {
    _totalUnreadCountController.add(unreadCount);
  }

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

  set workspaces(Map<String, Workspace> newWorkspaces) {
    _workspacesController.add(newWorkspaces);
  }

  set currentWorkspace(Workspace? workspace) {
    _currentWorkspaceController.add(workspace);
  }

  final _workspacesController =
      BehaviorSubject<Map<String, Workspace>>.seeded({});
  final _channelsController = BehaviorSubject<Map<String, Channel>>.seeded({});
  final _currentUserController = BehaviorSubject<OwnUser?>();
  final _unreadChannelsController = BehaviorSubject<int>.seeded(0);
  final _totalUnreadCountController = BehaviorSubject<int>.seeded(0);
  final _currentWorkspaceController = BehaviorSubject<Workspace?>();

  void dispose() {
    cancelEventSubscription();
    _currentUserController.close();
    // _unreadChannelsController.close();
    // _totalUnreadCountController.close();
    final cs = <Channel>[];
    channels.values.forEach((c) => cs.add(c));
    cs.forEach((c) => c.dispose());
    _channelsController.close();
    _workspacesController.close();
  }
}
