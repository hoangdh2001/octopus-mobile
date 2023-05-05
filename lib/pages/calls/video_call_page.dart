import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<StatefulWidget> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
    appId: '509316ca45954759bbbc95c5a7186933',
    channelName: 'flutterring',
    tempToken:
        '007eJxTYMicmC9Q2vHuXtvRRUxHbjWvEzPPW/PuqkBKQ/aqvXtM2I8rMJgaWBobmiUnmphampqYm1omJSUlW5ommyaaG1qYWRobP+0LSWkIZGSomdbBzMgAgSA+N0NaTmlJSWpRUWZeOgMDAIJGIzE=',
  ));

  @override
  void initState() {
    _client.initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Video call"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: _client,
              enabledButtons: const [
                BuiltInButtons.toggleCamera,
                BuiltInButtons.callEnd,
                BuiltInButtons.toggleMic
              ],
            )
          ],
        ),
      ));
}
