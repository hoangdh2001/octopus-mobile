import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/widgets/avatars/space_avatar.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPageArgs {
  final Channel channel;

  const CallPageArgs(this.channel);
}

class CallPage extends StatefulWidget {
  const CallPage(
      {super.key,
      this.channel,
      this.callID,
      this.isJoin = false,
      this.isVideo = false,
      this.isGroup = false});

  final Channel? channel;

  final String? callID;

  final bool isJoin;

  final bool isVideo;

  final bool isGroup;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late String callID;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    callID = widget.callID ?? widget.channel!.id!;
    if (!widget.isJoin) {
      await widget.channel!
          .call(isVideo: widget.isVideo, isGroup: widget.isGroup);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Octopus.of(context).currentUser;
    ZegoScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ZegoUIKitPrebuiltCall(
                appID:
                    500571709, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign:
                    '7dc1e22fb13c89ff89aa56a395943136a39ad7abcc349ce2bb804b78a1bbd35a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: currentUser!.id,
                userName: currentUser.name,
                callID: callID,
                // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
                config: !widget.isGroup
                    ? (ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                      ..avatarBuilder = (BuildContext context, Size size,
                          ZegoUIKitUser? user, Map extraInfo) {
                        return user != null
                            ? UserAvatar(user: currentUser)
                            : const SizedBox();
                      }
                      ..turnOnCameraWhenJoining = widget.isVideo
                      ..onOnlySelfInRoom = (context) {
                        Navigator.of(context).pop();
                      })
                    : ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                  ..avatarBuilder = (context, size, user, extraInfo) {
                    return user != null
                        ? SpaceAvatar(
                            name: user.name,
                            constraints: BoxConstraints.tight(size),
                            borderRadius: BorderRadius.circular(size.width / 2),
                            showOnlineStatus: false,
                          )
                        : const SizedBox();
                  }
                  ..turnOnCameraWhenJoining = widget.isVideo
                  ..topMenuBarConfig.buttons = [
                    ZegoMenuBarButtonName.minimizingButton,
                    ZegoMenuBarButtonName.showMemberListButton,
                    ZegoMenuBarButtonName.toggleScreenSharingButton,
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
