import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/reaction.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/message/reactions/reaction_bubble.dart';
import 'package:octopus/widgets/message/reactions/reaction_picker.dart';

class MessageReactionsModal extends StatelessWidget {
  const MessageReactionsModal({
    super.key,
    required this.message,
    required this.messageWidget,
    required this.messageTheme,
    this.showReactions,
    this.reverse = false,
    this.onUserAvatarTap,
  });

  final Widget messageWidget;

  final Message message;

  final OCMessageThemeData messageTheme;

  final bool reverse;

  final bool? showReactions;

  final void Function(User)? onUserAvatarTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = OctopusChannel.of(context).channel.client.state.currentUser;
    // final _userPermissions = OctopusChannel.of(context).channel.ownCapabilities;

    // final hasReactionPermission =
    //     _userPermissions.contains(PermissionType.sendReaction);

    final roughMaxSize = size.width * 2 / 3;
    var messageTextLength = message.text!.length;
    if (message.quotedMessage != null) {
      var quotedMessageLength = message.quotedMessage!.text!.length + 40;
      if (message.quotedMessage!.attachments.isNotEmpty) {
        quotedMessageLength += 40;
      }
      if (quotedMessageLength > messageTextLength) {
        messageTextLength = quotedMessageLength;
      }
    }
    final roughSentenceSize = messageTextLength *
        (messageTheme.messageTextStyle?.fontSize ?? 1) *
        1.2;
    final divFactor = message.attachments.isNotEmpty
        ? 1
        : (roughSentenceSize == 0 ? 1 : (roughSentenceSize / roughMaxSize));

    final numberOfReactions = OctopusTheme.of(context).reactionIcons.length;
    final shiftFactor =
        numberOfReactions < 5 ? (5 - numberOfReactions) * 0.1 : 0.0;

    final child = Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (showReactions ?? (message.status == MessageStatus.ready))
                Align(
                  alignment: Alignment(
                    user!.id == message.sender!.id
                        ? (divFactor >= 1.0
                            ? -0.2 - shiftFactor
                            : (1.2 - divFactor))
                        : (divFactor >= 1.0
                            ? shiftFactor + 0.2
                            : -(1.2 - divFactor)),
                    0,
                  ),
                  child: ReactionPicker(
                    message: message,
                  ),
                ),
              const SizedBox(height: 8),
              IgnorePointer(
                child: messageWidget,
              ),
              if (message.reactions?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                _buildReactionCard(
                  context,
                  user,
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.maybePop(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: OctopusTheme.of(context).colorTheme.overlay,
                ),
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            builder: (context, val, widget) => Transform.scale(
              scale: val,
              child: widget,
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildReactionCard(BuildContext context, User? user) {
    final chatThemeData = OctopusTheme.of(context);
    return Card(
      color: chatThemeData.colorTheme.contentView,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Message Reactions',
              style: chatThemeData.textTheme.primaryGreyH1,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: message.reactions!
                      .map((e) => _buildReaction(
                            e,
                            user!,
                            context,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReaction(
    Reaction reaction,
    User currentUser,
    BuildContext context,
  ) {
    final isCurrentUser = reaction.reacter?.id == currentUser.id;
    final chatThemeData = OctopusTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(
        64,
        98,
      )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              UserAvatar(
                onTap: onUserAvatarTap,
                user: reaction.reacter!,
                constraints:
                    const BoxConstraints.tightFor(width: 64, height: 64),
                onlineIndicatorConstraints: const BoxConstraints.tightFor(
                  height: 12,
                  width: 12,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              Positioned(
                bottom: 6,
                left: isCurrentUser ? -3 : null,
                right: isCurrentUser ? -3 : null,
                child: Align(
                  alignment:
                      reverse ? Alignment.centerRight : Alignment.centerLeft,
                  child: ReactionBubble(
                    reactions: [reaction],
                    flipTail: !reverse,
                    borderColor:
                        messageTheme.reactionsBorderColor ?? Colors.transparent,
                    backgroundColor: messageTheme.reactionsBackgroundColor ??
                        Colors.transparent,
                    maskColor: chatThemeData.colorTheme.contentView,
                    tailCirclesSpacing: 1,
                    highlightOwnReactions: false,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reaction.reacter!.name.split(' ')[0],
            style: chatThemeData.textTheme.primaryGreyFootnote,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
