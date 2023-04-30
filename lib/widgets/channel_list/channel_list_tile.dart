import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/widgets/channel/channel_name.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';

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
    final leading = ChannelAvatar(
      channel: channel,
    );
    final title = ChannelName(
      channel: channel,
    );
    final subTitle = Container();
    final trailing = Container();
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 3000),
      child: ListTile(
        onTap: onTap,
        visualDensity: visualDensity,
        contentPadding: contentPadding,
        leading: leading,
        tileColor: tileColor,
        title: Row(
          children: [
            Expanded(child: title),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: subTitle,
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
