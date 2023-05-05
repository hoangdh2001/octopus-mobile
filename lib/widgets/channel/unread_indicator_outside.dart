import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';

class UnreadIndicatorOutside extends StatelessWidget {
  const UnreadIndicatorOutside({
    super.key,
    this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    final client = Octopus.of(context).client;
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: id != null
            ? client.state.channels[id]?.state?.unreadCountStream
            : client.state.totalUnreadCountStream,
        initialData: id != null
            ? client.state.channels[id]?.state?.unreadCount
            : client.state.totalUnreadCount,
        builder: (context, data) {
          // if (data == 0) {
          //   return const Offstage();
          // }
          return Material(
            borderRadius: BorderRadius.circular(8),
            color: OctopusTheme.of(context)
                .channelPreviewThemeData
                .unreadCounterColor,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 2,
                bottom: 1,
              ),
              child: Center(
                child: Text(
                  '${data > 99 ? '99+' : 2}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
