import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/channel_name.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
import 'package:octopus/widgets/screen_header.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage(
      {super.key, this.channel, this.channelID, this.isJoin = false});

  final Channel? channel;

  final String? channelID;

  final bool isJoin;

  @override
  State<StatefulWidget> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late String _currentUuid;
  late CallKitParams _calling;

  late Channel? _channel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channel = widget.channel;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: ChannelAvatar(channel: channel!)),
        Positioned(
          child: Container(
            color: OctopusTheme.of(context).colorTheme.overlayDark,
          ),
        ),
        Column(
          children: [
            ScreenHeader(
              title: channel.name!,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              titleStyle:
                  OctopusTheme.of(context).textTheme.navigationTitle.copyWith(
                        color: Colors.white,
                      ),
              iconBackColor: Colors.white,
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChannelAvatar(
                        channel: channel,
                        constraints: const BoxConstraints.tightFor(
                            width: 80, height: 80),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      ChannelName(
                        channel: channel,
                        textStyle: OctopusTheme.of(context)
                            .channelHeaderTheme
                            .titleStyle
                            ?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
