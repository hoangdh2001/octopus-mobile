import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/pages/channelList/bloc/channel_list_event_handler.dart';

const defaultChannelPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

class ChannelListBloc extends PagedValueBloc<int, Channel> {
  final Client client;

  final Filter? filter;
  Filter? _activeFilter;

  final List<SortOption<ChannelModel>>? sort;
  List<SortOption<ChannelModel>>? _activeSort;

  final int limit;

  final int? messageLimit;

  final int? memberLimit;

  set filter(Filter? value) => _activeFilter = value;

  set sort(List<SortOption<ChannelModel>>? value) => _activeSort = value;

  ChannelListBloc({
    required this.client,
    ChannelListEventHandler? eventHandler,
    this.filter,
    this.sort,
    this.limit = defaultChannelPagedLimit,
    this.messageLimit,
    this.memberLimit,
  })  : _activeFilter = filter,
        _activeSort = sort,
        _eventHandler = eventHandler ?? ChannelListEventHandler(),
        super(const PagedValueState.loading());

  set channels(List<Channel> channels) {
    if (state.isSuccess) {
      final currentValue = state.asSuccess;
      add(UpdateState(currentValue.copyWith(items: channels)));
    } else {
      add(UpdateState(PagedValueState(items: channels)));
    }
  }

  @override
  Future<void> doInitialLoad(PagedValueState<int, Channel> state,
      Emitter<PagedValueState<int, Channel>> emit) async {
    final limit = min(
      this.limit * defaultInitialPagedLimitMultiplier,
      _kDefaultBackendPaginationLimit,
    );
    emit(const PagedValueState.loading());
    try {
      await for (final channels in client.queryChannels(
        filter: _activeFilter,
        sort: _activeSort,
        memberLimit: memberLimit,
        messageLimit: messageLimit,
        paginationParams: PaginationParams(limit: limit),
      )) {
        final nextKey = channels.length < limit ? null : channels.length;
        emit(PagedValueState(
          items: channels,
          nextPageKey: nextKey,
        ));
      }

      _subscribeToChannelListEvents();
    } on OCError catch (error) {
      emit(PagedValueState.error(error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(PagedValueState.error(chatError));
      rethrow;
    }
  }

  @override
  Future<void> loadMore(int nextPageKey, PagedValueState<int, Channel> state,
      Emitter<PagedValueState<int, Channel>> emit) async {
    final previousState = state.asSuccess;
    const limit = _kDefaultBackendPaginationLimit;
    try {
      await for (final channels in client.queryChannels(
        filter: _activeFilter,
        sort: _activeSort,
        memberLimit: memberLimit,
        messageLimit: messageLimit,
        paginationParams: PaginationParams(limit: limit, offset: nextPageKey),
      )) {
        final previousItems = previousState.items;
        final newItems = previousItems + channels;
        final nextKey = channels.length < limit ? null : newItems.length;
        emit(PagedValueState(
          items: newItems,
          nextPageKey: nextKey,
        ));
      }
    } on OCError catch (error) {
      emit(previousState.copyWith(error: error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(previousState.copyWith(error: chatError));
    }
  }

  Future<Channel> getChannel({
    required String id,
  }) async {
    final channel = client.channel(id: id);
    await channel.watch();
    return channel;
  }

  final ChannelListEventHandler _eventHandler;

  bool Function(Event event)? eventListener;

  StreamSubscription<Event>? _channelEventSubscription;

  // Subscribes to the channel list events.
  void _subscribeToChannelListEvents() {
    if (_channelEventSubscription != null) {
      _unsubscribeFromChannelListEvents();
    }

    _channelEventSubscription = client
        .on()
        .skip(1) // Skipping the last emitted event.
        // We only need to handle the latest events.
        .listen((event) {
      // Only handle the event if the value is in success state.
      if (state.isNotSuccess) return;

      // Returns early if the event is already handled by the listener.
      if (eventListener?.call(event) ?? false) return;

      final eventType = event.type;
      if (eventType == EventType.channelDeleted) {
        _eventHandler.onChannelDeleted(event, this);
      } else if (eventType == EventType.channelHidden) {
        _eventHandler.onChannelHidden(event, this);
      } else if (eventType == EventType.channelTruncated) {
        _eventHandler.onChannelTruncated(event, this);
      } else if (eventType == EventType.channelUpdated) {
        _eventHandler.onChannelUpdated(event, this);
      } else if (eventType == EventType.channelVisible) {
        _eventHandler.onChannelVisible(event, this);
      } else if (eventType == EventType.connectionRecovered) {
        _eventHandler.onConnectionRecovered(event, this);
      } else if (eventType == EventType.messageNew) {
        _eventHandler.onMessageNew(event, this);
      } else if (eventType == EventType.notificationAddedToChannel) {
        _eventHandler.onNotificationAddedToChannel(event, this);
      } else if (eventType == EventType.notificationMessageNew) {
        _eventHandler.onNotificationMessageNew(event, this);
      } else if (eventType == EventType.notificationRemovedFromChannel) {
        _eventHandler.onNotificationRemovedFromChannel(event, this);
      } else if (eventType == 'user.presence.changed' ||
          eventType == EventType.userUpdated) {
        _eventHandler.onUserPresenceChanged(event, this);
      }
    });
  }

  // Unsubscribes from all channel list events.
  void _unsubscribeFromChannelListEvents() {
    if (_channelEventSubscription != null) {
      _channelEventSubscription!.cancel();
      _channelEventSubscription = null;
    }
  }

  /// Pauses all subscriptions added to this composite.
  void pauseEventsSubscription([Future<void>? resumeSignal]) {
    _channelEventSubscription?.pause(resumeSignal);
  }

  /// Resumes all subscriptions added to this composite.
  void resumeEventsSubscription() {
    _channelEventSubscription?.resume();
  }

  @override
  Future<void> close() {
    _unsubscribeFromChannelListEvents();
    return super.close();
  }
}
