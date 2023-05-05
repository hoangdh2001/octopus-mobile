import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/reaction.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';

class ReactionPicker extends StatefulWidget {
  const ReactionPicker({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  _ReactionPickerState createState() => _ReactionPickerState();
}

class _ReactionPickerState extends State<ReactionPicker>
    with TickerProviderStateMixin {
  List<EzAnimation> animations = [];

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);
    final reactionIcons = chatThemeData.reactionIcons;

    if (animations.isEmpty && reactionIcons.isNotEmpty) {
      reactionIcons.forEach((element) {
        animations.add(
          EzAnimation.tween(
            Tween(begin: 0.0, end: 1.0),
            const Duration(milliseconds: 500),
            curve: Curves.easeInOutBack,
          ),
        );
      });

      triggerAnimations();
    }

    final child = Material(
      borderRadius: BorderRadius.circular(24),
      color: chatThemeData.colorTheme.contentView,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: reactionIcons
              .map<Widget>((reactionIcon) {
                final ownReactionIndex =
                    widget.message.ownReactions?.indexWhere(
                          (reaction) => reaction.type == reactionIcon.type,
                        ) ??
                        -1;
                final index = reactionIcons.indexOf(reactionIcon);

                final child = reactionIcon.builder(
                  context,
                  ownReactionIndex != -1,
                  24,
                );

                return ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 24,
                    width: 24,
                  ),
                  child: RawMaterialButton(
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: const BoxConstraints.tightFor(
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      if (ownReactionIndex != -1) {
                        removeReaction(
                          context,
                          widget.message.ownReactions![ownReactionIndex],
                        );
                      } else {
                        sendReaction(
                          context,
                          reactionIcon.type,
                        );
                      }
                    },
                    child: AnimatedBuilder(
                      animation: animations[index],
                      builder: (context, child) => Transform.scale(
                        scale: animations[index].value,
                        child: child,
                      ),
                      child: child,
                    ),
                  ),
                );
              })
              .insertBetween(const SizedBox(
                width: 16,
              ))
              .toList(),
        ),
      ),
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 500),
      builder: (context, val, widget) => Transform.scale(
        scale: val,
        child: widget,
      ),
      child: child,
    );
  }

  void triggerAnimations() async {
    for (final a in animations) {
      a.start();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void pop() async {
    for (final a in animations) {
      a.stop();
    }
    Navigator.of(context).pop();
  }

  void sendReaction(BuildContext context, String reactionType) {
    OctopusChannel.of(context).channel.sendReaction(
          widget.message,
          reactionType,
        );
    pop();
  }

  void removeReaction(BuildContext context, Reaction reaction) {
    OctopusChannel.of(context).channel.deleteReaction(widget.message, reaction);
    pop();
  }

  @override
  void dispose() {
    for (final a in animations) {
      a.dispose();
    }
    super.dispose();
  }
}
