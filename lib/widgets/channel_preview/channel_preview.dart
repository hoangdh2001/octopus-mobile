import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
import 'package:octopus/widgets/channel_preview/channel_preview_status.dart';

class ChannelPreview extends StatelessWidget {
  const ChannelPreview({super.key, this.onChannelTap, required this.channel});

  final void Function()? onChannelTap;

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final onTap = onChannelTap;

    return ListTile(
      onTap: onTap == null ? null : () => onTap(),
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8).r,
      leading: ChannelAvatar(
        channel: channel,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Hoang Do",
              style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "hello",
                style: OctopusTheme.of(context).textTheme.secondaryGreyCaption2,
              ),
            ),
          ),
          const ChannelPreviewStatus(),
        ],
      ),
    );
  }
}
