import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/octopus.dart';

class MessagePreviewText extends StatelessWidget {
  const MessagePreviewText({
    super.key,
    required this.message,
    this.textStyle,
    this.isGroup = false,
  });

  final Message message;

  final TextStyle? textStyle;

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final currentUser = Octopus.of(context).client.state.currentUser;
    final isMyMessage = message.sender!.id == currentUser!.id;
    final messageText = message.text;
    final messageAttachments = message.attachments;
    // final messageMentionedUsers = message.mentionedUsers;

    // final mentionedUsersRegex = RegExp(
    //   messageMentionedUsers.map((it) => '@${it.name}').join('|'),
    //   caseSensitive: false,
    // );

    final messageTextParts = [
      ...messageAttachments.map((it) {
        if (it.type == 'image') {
          return 'sent ${messageAttachments.length > 1 ? messageAttachments.length : 'a'} photo 📷';
        } else if (it.type == 'video') {
          return 'sent ${messageAttachments.length > 1 ? messageAttachments.length : 'a'} video 🎬';
        } else if (it.type == 'giphy') {
          return '[GIF]';
        }
        return it == message.attachments.last
            ? (it.title ?? 'File')
            : '${it.title ?? 'File'} , ';
      }),
      if (messageText != null)
        // if (messageMentionedUsers.isNotEmpty)
        //   ...mentionedUsersRegex.allMatchesWithSep(messageText)
        // else
        messageText,
    ];

    final fontStyle = (message.isSystem || message.isDeleted)
        ? FontStyle.italic
        : FontStyle.normal;

    final regularTextStyle = textStyle?.copyWith(fontStyle: fontStyle);

    final mentionsTextStyle = textStyle?.copyWith(
      fontStyle: fontStyle,
      fontWeight: FontWeight.bold,
    );

    final spans = [
      // for (final part in messageTextParts)
      // if (messageMentionedUsers.isNotEmpty &&
      //     messageMentionedUsers.any((it) => '@${it.name}' == part))
      //   TextSpan(
      //     text: part,
      //     style: mentionsTextStyle,
      //   )
      // else
      if (messageAttachments.isNotEmpty)
        TextSpan(
          text:
              "${isMyMessage ? 'You' : message.sender?.name} ${messageTextParts[0]}",
          style: regularTextStyle?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        )
      else
        TextSpan(
          text:
              "${isMyMessage ? 'You' : message.sender?.name}: ${messageTextParts[0]}",
          style: regularTextStyle,
        ),
    ];

    return Text.rich(
      TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}

extension _RegExpX on RegExp {
  List<String> allMatchesWithSep(String input, [int start = 0]) {
    final result = <String>[];
    for (final match in allMatches(input, start)) {
      result.add(input.substring(start, match.start));
      // ignore: cascade_invocations
      result.add(match[0]!);
      // ignore: parameter_assignments
      start = match.end;
    }
    result.add(input.substring(start));
    return result;
  }
}
