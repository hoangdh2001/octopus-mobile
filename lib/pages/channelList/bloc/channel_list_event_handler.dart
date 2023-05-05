import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/pages/channelList/bloc/channel_list_bloc.dart';

/// Contains handlers that are called from [StreamChannelListController] for
/// certain [Event]s.
///
/// This class can be mixed in or extended to create custom overrides.
class ChannelListEventHandler {
  /// Function which gets called for the event
  /// [EventType.channelDeleted].
  ///
  /// This event is fired when a channel is deleted.
  ///
  /// By default, this removes the channel from the list of channels.
  void onChannelDeleted(Event event, ChannelListBloc controller) {
    final channels = [...controller.currentItems];

    final updatedChannels = channels
      ..removeWhere(
        (it) => it.id == (event.channelID ?? event.channel?.channel!.id),
      );

    controller.channels = updatedChannels;
  }

  /// Function which gets called for the event
  /// [EventType.channelHidden].
  ///
  /// This event is fired when a channel is hidden.
  ///
  /// By default, this removes the channel from the list of channels.
  void onChannelHidden(Event event, ChannelListBloc controller) {
    onChannelDeleted(event, controller);
  }

  /// Function which gets called for the event
  /// [EventType.channelTruncated].
  ///
  /// This event is fired when a channel is truncated.
  ///
  /// By default, this refreshes the whole channel list.
  void onChannelTruncated(Event event, ChannelListBloc controller) {
    controller.add(const Refresh());
  }

  /// Function which gets called for the event
  /// [EventType.channelUpdated].
  ///
  /// This event is fired when a channel is updated.
  ///
  /// By default, this updates the channel received in the event.
  // ignore: no-empty-block
  void onChannelUpdated(Event event, ChannelListBloc controller) {}

  /// Function which gets called for the event
  /// [EventType.channelVisible].
  ///
  /// This event is fired when a channel is made visible.
  ///
  /// By default, this adds the channel to the list of channels.
  void onChannelVisible(
    Event event,
    ChannelListBloc controller,
  ) async {
    final channelId = event.channelID;

    if (channelId == null) return;

    final channel = await controller.getChannel(
      id: channelId,
    );

    final currentChannels = [...controller.currentItems];

    final updatedChannels = [
      channel,
      ...currentChannels..removeWhere((it) => it.id == channel.id),
    ];

    controller.channels = updatedChannels;
  }

  /// Function which gets called for the event
  /// [EventType.connectionRecovered].
  ///
  /// This event is fired when the client web-socket connection recovers.
  ///
  /// By default, this refreshes the whole channel list.
  void onConnectionRecovered(
    Event event,
    ChannelListBloc controller,
  ) {
    controller.add(const Refresh());
  }

  /// Function which gets called for the event [EventType.messageNew].
  ///
  /// This event is fired when a new message is created in one of the channels
  /// we are currently watching.
  ///
  /// By default, this moves the channel to the top of the list.
  void onMessageNew(Event event, ChannelListBloc controller) {
    final channelId = event.channelID;
    if (channelId == null) return;

    final channels = [...controller.currentItems];

    final channelIndex = channels.indexWhere((it) => it.id == channelId);
    if (channelIndex <= 0) return;

    final channel = channels.removeAt(channelIndex);
    channels.insert(0, channel);

    controller.channels = [...channels];
  }

  /// Function which gets called for the event
  /// [EventType.notificationAddedToChannel].
  ///
  /// This event is fired when a channel is added which we are not watching.
  ///
  /// By default, this adds the channel and moves it to the top of list.
  void onNotificationAddedToChannel(
    Event event,
    ChannelListBloc controller,
  ) {
    onChannelVisible(event, controller);
  }

  /// Function which gets called for the event
  /// [EventType.notificationMessageNew].
  ///
  /// This event is fired when a new message is created in a channel
  /// which we are not currently watching.
  ///
  /// By default, this adds the channel and moves it to the top of list.
  void onNotificationMessageNew(
    Event event,
    ChannelListBloc controller,
  ) {
    onChannelVisible(event, controller);
  }

  /// Function which gets called for the event
  /// [EventType.notificationRemovedFromChannel].
  ///
  /// This event is fired when a user is removed from a channel which we are
  /// not currently watching.
  ///
  /// By default, this removes the event channel from the list.
  void onNotificationRemovedFromChannel(
    Event event,
    ChannelListBloc controller,
  ) {
    final channels = [...controller.currentItems];
    final updatedChannels =
        channels.where((it) => it.id != event.channel?.channel!.id);
    final listChanged = channels.length != updatedChannels.length;

    if (!listChanged) return;

    controller.channels = [...updatedChannels];
  }

  /// Function which gets called for the event
  /// 'user.presence.changed' and [EventType.userUpdated].
  ///
  /// This event is fired when a user's presence changes or gets updated.
  ///
  /// By default, this updates the channel member with the event user.
  void onUserPresenceChanged(
    Event event,
    ChannelListBloc controller,
  ) {
    final user = event.user;
    if (user == null) return;

    final channels = [...controller.currentItems];

    final updatedChannels = channels.map((channel) {
      final members = [...channel.state!.members];
      final memberIndex = members.indexWhere(
        (it) => user.id == (it.userID ?? it.user?.id),
      );

      if (memberIndex < 0) return channel;

      members[memberIndex] = members[memberIndex].copyWith(user: user);
      final updatedState = ChannelState(members: [...members]);
      channel.state!.updateChannelState(updatedState);

      return channel;
    });

    controller.channels = [...updatedChannels];
  }
}
