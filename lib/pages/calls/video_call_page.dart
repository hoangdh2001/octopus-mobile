import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/channel_name.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:uuid/uuid.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.channel});

  final Channel channel;

  @override
  State<StatefulWidget> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late String _currentUuid;
  late CallKitParams _calling;

  void _startCall() async {
    _currentUuid = const Uuid().v4();
    _calling = CallKitParams(
      id: _currentUuid,
      nameCaller: 'Hien Nguyen',
      appName: 'Callkit',
      avatar: 'https://i.pravatar.cc/100',
      handle: '0123456789',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: 'Call back',
      duration: 30000,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          isShowCallback: false,
          isShowMissedCallNotification: true,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#0955fa',
          backgroundUrl: 'https://i.pravatar.cc/500',
          actionColor: '#4CAF50',
          incomingCallNotificationChannelName: "Incoming Call",
          missedCallNotificationChannelName: "Missed Call"),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(_calling);
  }

  @override
  void initState() {
    _startCall();
    super.initState();
  }

  @override
  void dispose() {
    FlutterCallkitIncoming.endCall(_calling.id!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final channel = widget.channel;
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: ChannelAvatar(channel: channel)),
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
              width: 1.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChannelAvatar(
                    channel: channel,
                    constraints:
                        const BoxConstraints.tightFor(width: 80, height: 80),
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
            ),
          ],
        ),
      ],
    ));
  }
}
