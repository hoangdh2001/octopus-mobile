import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/pages/channelList/bloc/channel_list_bloc.dart';

class ChannelListEventHandler {
  void onChannelDeleted(Event event, ChannelListBloc controller) {
    final channels = [...controller.currentItems];

    final updatedChannels = channels
      ..removeWhere(
        (it) => it.id == (event.channelID ?? event.channel?.channel!.id),
      );

    controller.channels = updatedChannels;
  }

  void onChannelHidden(Event event, ChannelListBloc controller) {
    onChannelDeleted(event, controller);
  }

  void onChannelTruncated(Event event, ChannelListBloc controller) {
    controller.add(const Refresh());
  }

  void onChannelUpdated(Event event, ChannelListBloc controller) {}

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

  void onConnectionRecovered(
    Event event,
    ChannelListBloc controller,
  ) {
    controller.add(const Refresh());
  }

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

  void onNotificationAddedToChannel(
    Event event,
    ChannelListBloc controller,
  ) {
    onChannelVisible(event, controller);
  }

  void onNotificationMessageNew(
    Event event,
    ChannelListBloc controller,
  ) {
    onChannelVisible(event, controller);
  }

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
