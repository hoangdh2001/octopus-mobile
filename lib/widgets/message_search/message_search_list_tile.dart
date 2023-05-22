import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/models/get_message_response.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/channel/message_preview_text.dart';

class MessageSearchListTile extends StatelessWidget {
  const MessageSearchListTile({
    super.key,
    required this.messageResponse,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.tileColor,
    this.visualDensity = VisualDensity.compact,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
  });

  final GetMessageResponse messageResponse;

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? trailing;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final Color? tileColor;

  final VisualDensity visualDensity;

  final EdgeInsetsGeometry contentPadding;

  MessageSearchListTile copyWith({
    Key? key,
    GetMessageResponse? messageResponse,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    Color? tileColor,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      MessageSearchListTile(
        key: key ?? this.key,
        messageResponse: messageResponse ?? this.messageResponse,
        leading: leading ?? this.leading,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        trailing: trailing ?? this.trailing,
        onTap: onTap ?? this.onTap,
        onLongPress: onLongPress ?? this.onLongPress,
        tileColor: tileColor ?? this.tileColor,
        visualDensity: visualDensity ?? this.visualDensity,
        contentPadding: contentPadding ?? this.contentPadding,
      );

  @override
  Widget build(BuildContext context) {
    final message = messageResponse.message;
    final user = message.sender!;
    final channelPreviewTheme =
        OctopusTheme.of(context).channelPreviewThemeData;

    final leading = this.leading ??
        UserAvatar(
          user: user,
          constraints: const BoxConstraints.tightFor(
            height: 40,
            width: 40,
          ),
        );

    final title = this.title ??
        MessageSearchListTileTitle(
          messageResponse: messageResponse,
          textStyle: channelPreviewTheme.titleStyle,
        );

    final subtitle = this.subtitle ??
        Row(
          children: [
            Expanded(
              child: MessagePreviewText(
                message: message,
                textStyle: channelPreviewTheme.subtitleStyle,
              ),
            ),
            const SizedBox(width: 16),
            MessageSearchTileMessageDate(
              message: message,
              textStyle: channelPreviewTheme.lastMessageAtStyle,
            ),
          ],
        );

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      visualDensity: visualDensity,
      contentPadding: contentPadding,
      tileColor: tileColor,
      leading: leading,
      trailing: trailing,
      title: title,
      subtitle: subtitle,
    );
  }
}

class MessageSearchListTileTitle extends StatelessWidget {
  const MessageSearchListTileTitle({
    super.key,
    required this.messageResponse,
    this.textStyle,
  });

  final GetMessageResponse messageResponse;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final user = messageResponse.message.sender!;
    final channel = messageResponse.channel;
    final channelName = channel?.name;

    return Row(
      children: [
        Text(
          user.id == Octopus.of(context).currentUser?.id ? 'You' : user.name,
          style: textStyle,
        ),
        if (channelName != null) ...[
          Text(
            ' in ',
            style: textStyle?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            channelName,
            style: textStyle,
          ),
        ],
      ],
    );
  }
}

class MessageSearchTileMessageDate extends StatelessWidget {
  const MessageSearchTileMessageDate({
    super.key,
    required this.message,
    this.textStyle,
  });

  final Message message;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final createdAt = message.createdAt;
    String stringDate;
    final now = DateTime.now();
    if (now.year != createdAt.year ||
        now.month != createdAt.month ||
        now.day != createdAt.day) {
      stringDate = Jiffy(createdAt.toLocal()).yMd;
    } else {
      stringDate = Jiffy(createdAt.toLocal()).jm;
    }

    return Text(
      stringDate,
      style: textStyle,
    );
  }
}
