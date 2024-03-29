import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
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

    if (message.isSystem) {
      return _buildSystemMessage(context);
    }

    final messageTextParts = [
      ...messageAttachments.map((it) {
        if (it.type == 'image') {
          return 'sent ${messageAttachments.length > 1 ? messageAttachments.length : 'a'} photo 📷';
        } else if (it.type == 'video') {
          return 'sent ${messageAttachments.length > 1 ? messageAttachments.length : 'a'} video 🎬';
        } else if (it.type == 'giphy') {
          return '[GIF]';
        }
        return ('sent ${messageAttachments.length > 1 ? messageAttachments.length : 'a'} file${' ${it.title ?? ''}'}');
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

  Widget _buildSystemMessage(BuildContext context) {
    return Text(
      _buildActionText(context),
      softWrap: true,
      style: textStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  String _buildActionText(BuildContext context) {
    final message = this.message;
    final currentUser = Octopus.of(context).currentUser;

    final isMyMessage = currentUser!.id == message.sender!.id;
    switch (message.type) {
      case MessageType.systemAddMember:
        return 'system_add_member'.tr(args: [
          isMyMessage ? 'you'.tr() : message.sender!.name,
          message.text ?? ''
        ]);
      case MessageType.systemMemberLeft:
        return 'system_member_left'
            .tr(args: [isMyMessage ? 'you'.tr() : message.sender!.name]);
      case MessageType.systemRemovedMember:
        return 'system_removed_member'.tr(args: [
          isMyMessage ? 'you'.tr() : message.sender!.name,
          message.text ?? ''
        ]);
      case MessageType.systemCreatedChannel:
        return 'system_created_channel'
            .tr(args: [isMyMessage ? 'you'.tr() : message.sender!.name]);
      case MessageType.systemChangedAvatar:
        return 'system_changed_avatar'
            .tr(args: [isMyMessage ? 'you'.tr() : message.sender!.name]);
      case MessageType.systemChangedName:
        return 'system_changed_channel_name'.tr(args: [
          isMyMessage ? 'you'.tr() : message.sender!.name,
          message.text ?? ''
        ]);
      default:
        return '${message.text}';
    }
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
