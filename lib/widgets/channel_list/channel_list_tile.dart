import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/widgets/channel/channel_name.dart';
import 'package:octopus/widgets/channel/message_preview_text.dart';
import 'package:octopus/widgets/channel/sending_indicator.dart';
import 'package:octopus/widgets/channel/unread_indicator_outside.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
import 'package:octopus/widgets/indicators/typing_indicator.dart';

class ChannelListTile extends StatelessWidget {
  const ChannelListTile(
      {super.key,
      this.onTap,
      this.visualDensity = VisualDensity.compact,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
      this.tileColor,
      required this.channel,
      this.onLongPress,
      this.unreadIndicatorBuilder});

  final Channel channel;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final VisualDensity visualDensity;

  final EdgeInsetsGeometry contentPadding;

  final Color? tileColor;

  final WidgetBuilder? unreadIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    final channelState = channel.state!;
    final currentUser = channel.client.state.currentUser!;

    final channelPreviewTheme =
        OctopusTheme.of(context).channelPreviewThemeData;

    final leading = ChannelAvatar(
      channel: channel,
    );
    final title = ChannelName(
      channel: channel,
      textStyle: channelPreviewTheme.titleStyle,
    );
    final subtitle = ChannelListTileSubtitle(
      channel: channel,
      textStyle: channelPreviewTheme.subtitleStyle,
    );

    final trailing = ChannelLastMessageDate(
      channel: channel,
      textStyle: channelPreviewTheme.lastMessageAtStyle,
    );
    return BetterStreamBuilder<bool>(
      stream: channel.isActiveNotifyStream,
      initialData: channel.isActiveNotify,
      builder: (context, isActiveNotify) => AnimatedOpacity(
        opacity: isActiveNotify ? 1 : 0.5,
        duration: const Duration(milliseconds: 3000),
        child: ListTile(
          onTap: onTap,
          visualDensity: visualDensity,
          contentPadding: contentPadding,
          leading: leading,
          tileColor: tileColor,
          dense: true,
          title: Row(
            children: [
              Expanded(child: title),
              BetterStreamBuilder<List<Member>>(
                stream: channelState.membersStream,
                initialData: channelState.members,
                comparator: const ListEquality().equals,
                builder: (context, members) {
                  if (members.isEmpty ||
                      !members.any((it) => it.user!.id == currentUser.id)) {
                    return const Offstage();
                  }
                  return unreadIndicatorBuilder?.call(context) ??
                      UnreadIndicatorOutside(id: channel.id);
                },
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: subtitle,
                ),
              ),
              BetterStreamBuilder<List<Message>>(
                stream: channelState.messagesStream,
                initialData: channelState.messages,
                comparator: const ListEquality().equals,
                builder: (context, messages) {
                  final lastMessage = messages.lastWhereOrNull(
                    (m) => !m.isDeleted,
                  );

                  if (lastMessage == null ||
                      (lastMessage.sender?.id != currentUser.id)) {
                    return const Offstage();
                  }

                  final memberReadCount = channelState.read.where((it) {
                    return it.user.id != currentUser.id &&
                        (it.lastRead.isAfter(lastMessage.createdAt) ||
                            it.lastRead.isAtSameMomentAs(
                              lastMessage.createdAt,
                            ));
                  }).length;

                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child:
                        // sendingIndicatorBuilder?.call(context, lastMessage) ??
                        SendingIndicator(
                      message: lastMessage,
                      size: channelPreviewTheme.indicatorIconSize,
                      isMessageRead: memberReadCount >=
                          // Subtract one for the current user.
                          (channel.memberCount ?? 0) - 1,
                    ),
                  );
                },
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

/// A widget that displays the channel last message date.
class ChannelLastMessageDate extends StatelessWidget {
  /// Creates a new instance of the [ChannelLastMessageDate] widget.
  ChannelLastMessageDate({
    super.key,
    required this.channel,
    this.textStyle,
  }) : assert(
          channel.state != null,
          'Channel ${channel.id} is not initialized',
        );

  /// The channel to display the last message date for.
  final Channel channel;

  /// The style of the text displayed
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => BetterStreamBuilder<DateTime>(
        stream: channel.lastMessageAtStream,
        initialData: channel.lastMessageAt,
        builder: (context, data) {
          final lastMessageAt = data.toLocal();

          String stringDate;
          final now = DateTime.now();

          final startOfDay = DateTime(now.year, now.month, now.day);

          if (lastMessageAt.millisecondsSinceEpoch >=
              startOfDay.millisecondsSinceEpoch) {
            stringDate = Jiffy(lastMessageAt.toLocal()).jm;
          } else if (lastMessageAt.millisecondsSinceEpoch >=
              startOfDay
                  .subtract(const Duration(days: 1))
                  .millisecondsSinceEpoch) {
            stringDate = "Yesterday";
          } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
            stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
          } else {
            stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
          }

          return Text(
            stringDate,
            style: textStyle,
          );
        },
      );
}

/// A widget that displays the subtitle for [StreamChannelListTile].
class ChannelListTileSubtitle extends StatelessWidget {
  /// Creates a new instance of [StreamChannelListTileSubtitle] widget.
  ChannelListTileSubtitle({
    super.key,
    required this.channel,
    this.textStyle,
  }) : assert(
          channel.state != null,
          'Channel ${channel.id} is not initialized',
        );

  final Channel channel;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (!channel.isActiveNotify) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/mute.svg',
            width: 16,
            height: 16,
          ),
          Text(
            '  Muted',
            style: textStyle,
          ),
        ],
      );
    }
    return TypingIndicator(
      channel: channel,
      style: textStyle,
      alternativeWidget: ChannelLastMessageText(
        channel: channel,
        textStyle: textStyle,
      ),
    );
  }
}

/// A widget that displays the last message of a channel.
class ChannelLastMessageText extends StatelessWidget {
  /// Creates a new instance of [ChannelLastMessageText] widget.
  ChannelLastMessageText({
    super.key,
    required this.channel,
    this.textStyle,
  }) : assert(
          channel.state != null,
          'Channel ${channel.id} is not initialized',
        );

  /// The channel to display the last message of.
  final Channel channel;

  /// The style of the text displayed
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => BetterStreamBuilder<List<Message>>(
        stream: channel.state!.messagesStream,
        initialData: channel.state!.messages,
        builder: (context, messages) {
          final lastMessage = messages.lastWhereOrNull(
            (m) => !m.isDeleted,
          );

          if (lastMessage == null) {
            return Text(
              'Empty',
              style: textStyle,
            );
          }

          return MessagePreviewText(
            message: lastMessage,
            textStyle: textStyle,
            isGroup: channel.isGroup,
          );
        },
      );
}
