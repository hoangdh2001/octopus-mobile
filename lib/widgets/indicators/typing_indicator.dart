import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus_channel.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({
    super.key,
    this.channel,
    this.alternativeWidget,
    this.style,
    this.padding = EdgeInsets.zero,
    this.parentId,
  });

  final TextStyle? style;

  final Channel? channel;

  final Widget? alternativeWidget;

  final EdgeInsets padding;

  final String? parentId;

  @override
  Widget build(BuildContext context) {
    final channelState =
        channel?.state ?? OctopusChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const Offstage();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream.map((typings) => typings.entries
          // .where((element) => element.value.parentId == parentId)
          .map((e) => e.key)),
      builder: (context, users) => AnimatedSwitcher(
        layoutBuilder: (currentChild, previousChildren) => Stack(
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        duration: const Duration(milliseconds: 300),
        child: users.isNotEmpty
            ? Padding(
                padding: padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lottie.network(
                    //   'https://assets2.lottiefiles.com/packages/lf20_M3al0h.json',
                    //   width: 200,
                    //   height: 4,
                    //   frameRate: FrameRate.max,
                    //   animate: true,
                    //   fit: BoxFit.fill,
                    //   repeat: true,
                    // ),
                    Text(
                      _userTypingText(users),
                      maxLines: 1,
                      style: style,
                    ),
                  ],
                ),
              )
            : altWidget,
      ),
    );
  }

  String _userTypingText(Iterable<User> users) {
    if (users.isEmpty) return '';
    final first = users.first;
    if (users.length == 1) {
      return '${first.name} is typing...';
    }
    return '${first.name} and ${users.length - 1} more are typing...';
  }
}
