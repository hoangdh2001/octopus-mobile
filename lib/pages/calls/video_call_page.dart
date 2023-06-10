// import 'dart:math';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
// import 'package:octopus/core/data/client/channel.dart';
// import 'package:octopus/core/theme/oc_theme.dart';
// import 'package:octopus/utils.dart';
// import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
// import 'package:octopus/widgets/screen_header.dart';

// class VideoCallArgs {
//   const VideoCallArgs({this.channel, this.channelID, this.isJoin = false});
//   final Channel? channel;
//   final String? channelID;
//   final bool isJoin;
// }

// class VideoCallPage extends StatefulWidget {
//   const VideoCallPage({super.key, required this.channel, this.isJoin = false});

//   final Channel channel;

//   final bool isJoin;

//   @override
//   State<StatefulWidget> createState() => _VideoCallPageState();
// }

// class _VideoCallPageState extends State<VideoCallPage> {
//   final _users = <int>[];
//   final _infoStrings = <String>[];
//   bool muted = false;
//   late RtcEngine _engine;

//   @override
//   void dispose() async {
//     // clear users
//     _users.clear();
//     await _dispose();
//     super.dispose();
//   }

//   Future<void> _dispose() async {
//     // destroy sdk
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // initialize agora sdk
//     initialize();
//   }

//   Future<void> initialize() async {
//     if (appId.isEmpty) {
//       setState(() {
//         _infoStrings.add(
//           'APP_ID missing, please provide your APP_ID in settings.dart',
//         );
//         _infoStrings.add('Agora Engine is not starting');
//       });
//       return;
//     }

//     await _initAgoraRtcEngine();
//     _addAgoraEventHandlers();
//     VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
//         dimensions: VideoDimensions(width: 1920, height: 1080));
//     // configuration. = VideoDimensions(width: 1920, height: 1080);
//     await _engine.setVideoEncoderConfiguration(configuration);
//     ChannelMediaOptions options = const ChannelMediaOptions(
//       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       channelProfile: ChannelProfileType.channelProfileCommunication,
//     );
//     await _engine.joinChannel(
//       token: token,
//       channelId: 'test',
//       uid: 0,
//       options: options,
//     );
//     if (!widget.isJoin) {
//       await widget.channel.call();
//     }
//   }

//   /// Create agora sdk instance and initialize
//   Future<void> _initAgoraRtcEngine() async {
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(appId: appId));
//     await _engine.enableVideo();
//     await _engine.enableAudio();
//     await _engine
//         .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
//   }

//   /// Add agora event handlers
//   void _addAgoraEventHandlers() {
//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onError: (err, msg) {
//         setState(() {
//           final info = 'onError: $err $msg';
//           _infoStrings.add(info);
//         });
//       },
//       onJoinChannelSuccess: (connection, elapsed) {
//         setState(() {
//           final info = 'onJoinChannel: $connection, uid: $elapsed';
//           _infoStrings.add(info);
//         });
//       },
//       onLeaveChannel: (connection, stats) {
//         setState(() {
//           _infoStrings.add('onLeaveChannel');
//           _users.clear();
//         });
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         setState(() {
//           final info = 'userJoined: $connection $remoteUid $elapsed';
//           _infoStrings.add(info);
//           _users.add(remoteUid);
//         });
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         setState(() {
//           final info = 'userOffline: $connection $remoteUid $reason';
//           _infoStrings.add(info);
//           _users.remove(remoteUid);
//         });
//       },
//       onFirstRemoteVideoFrame: (connection, remoteUid, width, height, elapsed) {
//         setState(() {
//           final info =
//               'firstRemoteVideo: $connection $remoteUid ${width}x $height';
//           _infoStrings.add(info);
//         });
//       },
//     ));
//   }

//   /// Helper function to get list of native views
//   List<Widget> _getRenderViews() {
//     final List<StatefulWidget> list = [];
//     list.add(
//       AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: _engine,
//           canvas: const VideoCanvas(uid: 0),
//           useAndroidSurfaceView: true,
//           useFlutterTexture: true,
//         ),
//         onAgoraVideoViewCreated: (viewId) {
//           _engine.startPreview();
//         },
//       ),
//     );
//     _users.forEach(
//       (uid) => list.add(
//         AgoraVideoView(
//           controller: VideoViewController.remote(
//             rtcEngine: _engine,
//             canvas: VideoCanvas(uid: uid),
//             connection: const RtcConnection(channelId: 'octopus'),
//             useAndroidSurfaceView: true,
//             useFlutterTexture: true,
//           ),
//         ),
//       ),
//     );
//     return list;
//   }

//   /// Video view wrapper
//   Widget _videoView(view) {
//     return Expanded(child: Container(child: view));
//   }

//   /// Video view row wrapper
//   Widget _expandedVideoRow(List<Widget> views) {
//     final wrappedViews = views.map<Widget>(_videoView).toList();
//     return Expanded(
//       child: Row(
//         children: wrappedViews,
//       ),
//     );
//   }

//   /// Video layout wrapper
//   Widget _viewRows() {
//     final views = _getRenderViews();
//     switch (views.length) {
//       case 1:
//         return Container(
//             child: Column(
//           children: <Widget>[_videoView(views[0])],
//         ));
//       case 2:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow([views[0]]),
//             _expandedVideoRow([views[1]])
//           ],
//         ));
//       case 3:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow(views.sublist(0, 2)),
//             _expandedVideoRow(views.sublist(2, 3))
//           ],
//         ));
//       case 4:
//         return Container(
//             child: Column(
//           children: <Widget>[
//             _expandedVideoRow(views.sublist(0, 2)),
//             _expandedVideoRow(views.sublist(2, 4))
//           ],
//         ));
//       default:
//     }
//     return Container();
//   }

//   /// Toolbar layout
//   Widget _toolbar() {
//     // if (widget.role == ClientRole.Audience) return Container();
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//           RawMaterialButton(
//             onPressed: () => _onCallEnd(context),
//             child: Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//           ),
//           RawMaterialButton(
//             onPressed: _onSwitchCamera,
//             child: Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           )
//         ],
//       ),
//     );
//   }

//   // /// Info panel to show logs
//   Widget _panel() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       alignment: Alignment.bottomCenter,
//       child: FractionallySizedBox(
//         heightFactor: 0.5,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 48),
//           child: ListView.builder(
//             reverse: true,
//             itemCount: _infoStrings.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (_infoStrings.isEmpty) {
//                 return Text(
//                     "null"); // return type can't be null, a widget was required
//               }
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 3,
//                   horizontal: 10,
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2,
//                           horizontal: 5,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.yellowAccent,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Text(
//                           _infoStrings[index],
//                           style: TextStyle(color: Colors.blueGrey),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void _onCallEnd(BuildContext context) {
//     Navigator.pop(context);
//   }

//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }

//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agora Flutter QuickStart'),
//       ),
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           children: <Widget>[
//             _viewRows(),
//             _panel(),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//   // Channel get channel => widget.channel;

//   // bool get isJoin => widget.isJoin;

//   // late AgoraClient _client;

//   // Future<void> initialize() async {
//   //   _client = AgoraClient(
//   //     agoraConnectionData: AgoraConnectionData(
//   //       appId: appId,
//   //       channelName: 'test',
//   //       tempToken: token,
//   //       uid: 0,
//   //     ),
//   //     agoraChannelData: AgoraChannelData(
//   //       channelProfileType: ChannelProfileType.channelProfileLiveBroadcasting,
//   //       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//   //     ),
//   //     agoraEventHandlers: AgoraRtcEventHandlers(
//   //       onError: (err, msg) {
//   //         setState(() {
//   //           final info = 'onError: $err $msg';
//   //           _infoStrings.add(info);
//   //         });
//   //       },
//   //       onJoinChannelSuccess: (connection, elapsed) {
//   //         setState(() {
//   //           final info = 'onJoinChannel: $connection, uid: $elapsed';
//   //           _infoStrings.add(info);
//   //         });
//   //       },
//   //       onLeaveChannel: (connection, stats) {
//   //         setState(() {
//   //           _infoStrings.add('onLeaveChannel');
//   //           _users.clear();
//   //         });
//   //       },
//   //       onUserJoined: (connection, remoteUid, elapsed) {
//   //         setState(() {
//   //           final info = 'userJoined: $connection $remoteUid $elapsed';
//   //           _infoStrings.add(info);
//   //           _users.add(remoteUid);
//   //         });
//   //       },
//   //       onUserOffline: (connection, remoteUid, reason) {
//   //         setState(() {
//   //           final info = 'userOffline: $connection $remoteUid $reason';
//   //           _infoStrings.add(info);
//   //           _users.remove(remoteUid);
//   //         });
//   //       },
//   //       onFirstRemoteVideoFrame:
//   //           (connection, remoteUid, width, height, elapsed) {
//   //         setState(() {
//   //           final info =
//   //               'firstRemoteVideo: $connection $remoteUid ${width}x $height';
//   //           _infoStrings.add(info);
//   //         });
//   //       },
//   //     ),
//   //   );
//   //   await _client.initialize();
//   //   if (!isJoin) {
//   //     await channel.call();
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   initialize();

//   //   super.initState();
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Stack(
//   //       children: [
//   //         // Positioned.fill(child: ChannelAvatar(channel: channel)),
//   //         // Positioned(
//   //         //   child: Container(
//   //         //     color: OctopusTheme.of(context).colorTheme.overlayDark,
//   //         //   ),
//   //         // ),
//   //         // Column(
//   //         //   children: [
//   //         //     ScreenHeader(
//   //         //       title: channel.name ?? "",
//   //         //       centerTitle: false,
//   //         //       backgroundColor: Colors.transparent,
//   //         //       titleSpacing: 0,
//   //         //       titleStyle:
//   //         //           OctopusTheme.of(context).textTheme.navigationTitle.copyWith(
//   //         //                 color: Colors.white,
//   //         //               ),
//   //         //       iconBackColor: Colors.white,
//   //         //     ),
//   //         //     SizedBox(
//   //         //       height: 50,
//   //         //     ),
//   //         //     Expanded(
//   //         //       child: Stack(
//   //         //         children: [
//   //         // Column(
//   //         //   crossAxisAlignment: CrossAxisAlignment.center,
//   //         //   children: [
//   //         //     ChannelAvatar(
//   //         //       channel: channel,
//   //         //       constraints: const BoxConstraints.tightFor(
//   //         //           width: 80, height: 80),
//   //         //       borderRadius: BorderRadius.circular(50),
//   //         //     ),
//   //         //     const SizedBox(
//   //         //       height: 9,
//   //         //     ),
//   //         //     ChannelName(
//   //         //       channel: channel,
//   //         //       textStyle: OctopusTheme.of(context)
//   //         //           .channelHeaderTheme
//   //         //           .titleStyle
//   //         //           ?.copyWith(
//   //         //             color: Colors.white,
//   //         //           ),
//   //         //     ),
//   //         //   ],
//   //         // ),
//   //         AgoraVideoViewer(
//   //           client: _client,
//   //           layoutType: Layout.floating,
//   //         ),
//   //         _panel(),
//   //         _buildCallButton(),
//   //       ],
//   //       // ),
//   //       // ),
//   //       // ],
//   //       // ),
//   //       // ],
//   //     ),
//   //   );
//   // }

//   // Widget _buildCallButton() {
//   //   return AgoraVideoButtons(
//   //     client: _client,
//   //     enabledButtons: const [
//   //       BuiltInButtons.toggleCamera,
//   //       BuiltInButtons.callEnd,
//   //       BuiltInButtons.switchCamera,
//   //     ],
//   //     addScreenSharing: false,
//   //   );
//   // }

//   // @override
//   // void dispose() async {
//   //   // clear users
//   //   _users.clear();
//   //   await _dispose();
//   //   super.dispose();
//   // }

//   // Future<void> _dispose() async {
//   //   // destroy sdk
//   //   await _client.engine.leaveChannel();
//   //   await _client.release();
//   // }
// }
