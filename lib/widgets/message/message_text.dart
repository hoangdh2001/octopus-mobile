import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/octopus_channel.dart';

class MessageText extends StatelessWidget {
  /// Constructor for creating a [MessageText] widget
  const MessageText({
    super.key,
    required this.message,
    required this.messageTheme,
    this.onMentionTap,
    this.onLinkTap,
  });

  /// Message whose text is to be displayed
  final Message message;

  /// Callback for when mention is tapped
  final void Function(User)? onMentionTap;

  /// Callback for when link is tapped
  final void Function(String)? onLinkTap;

  final OCMessageThemeData messageTheme;

  @override
  Widget build(BuildContext context) {
    final streamChat = OctopusChannel.of(context).channel.client.state;
    assert(streamChat.currentUser != null, '');
    final messageText = message.text;
    final themeData = Theme.of(context);
    return MarkdownBody(
      data: messageText ?? '',
      onTapLink: (
        String link,
        String? href,
        String title,
      ) {
        // if (link.startsWith('@')) {
        //   final mentionedUser = message.mentionedUsers.firstWhereOrNull(
        //     (u) => '@${u.name}' == link,
        //   );

        //   if (mentionedUser == null) return;

        //   onMentionTap?.call(mentionedUser);
        // } else {
        //   if (onLinkTap != null) {
        //     onLinkTap!(link);
        //   } else {
        //     launchURL(context, link);
        //   }
        // }
      },
      styleSheet: MarkdownStyleSheet.fromTheme(
        themeData.copyWith(
          textTheme: themeData.textTheme.apply(
            bodyColor: messageTheme.messageTextStyle?.color,
            decoration: messageTheme.messageTextStyle?.decoration,
            decorationColor: messageTheme.messageTextStyle?.decorationColor,
            decorationStyle: messageTheme.messageTextStyle?.decorationStyle,
            fontFamily: messageTheme.messageTextStyle?.fontFamily,
          ),
        ),
      ).copyWith(
        a: messageTheme.messageLinksStyle,
        p: messageTheme.messageTextStyle,
      ),
    );
  }
}
