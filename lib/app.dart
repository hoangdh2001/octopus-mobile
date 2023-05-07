import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:octopus/core/config/app_routes.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/navigator_service.dart';
import 'package:octopus/pages/calls/video_call_page.dart';
import 'package:octopus/pages/home_page.dart';
import 'package:octopus/pages/splash_page.dart';
import 'package:octopus/utils/constants.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

late StreamSubscription<CallEvent?>? _callKitSubcription;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  final type = message.data['type'] as String?;
  if (type == 'pushCall') {
    showCallkitIncoming(message);
    _listenerEvent(message);
  }
}

Future<void> showCallkitIncoming(RemoteMessage message) async {
  var uuid = message.data["uuid"] as String;
  var hasVideo = message.data["has_video"] == "true";
  var callerName = message.data['callerName'] as String;

  final params = CallKitParams(
    id: uuid,
    nameCaller: callerName,
    appName: 'Octopus',
    type: 0,
    duration: 30000,
    textAccept: 'Accept',
    textDecline: 'Decline',
    textMissedCall: 'Missed call',
    textCallback: 'Call back',
    extra: <String, dynamic>{'userId': '1a2b3c4d'},
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    android: const AndroidParams(
      isCustomNotification: true,
      isShowLogo: false,
      isShowCallback: true,
      isShowMissedCallNotification: true,
      ringtonePath: 'system_ringtone_default',
      backgroundColor: '#0955fa',
      backgroundUrl: 'assets/test.png',
      actionColor: '#4CAF50',
    ),
    ios: IOSParams(
      iconName: 'CallKitLogo',
      handleType: '',
      supportsVideo: hasVideo,
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
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}

Future<void> _listenerEvent(RemoteMessage message) async {
  var uuid = message.data["uuid"] as String;
  var callerName = message.data['callerName'] as String;
  try {
    _callKitSubcription = FlutterCallkitIncoming.onEvent.listen((event) async {
      print('HOME: $event');
      switch (event!.event) {
        case Event.ACTION_CALL_INCOMING:
          // TODO: received an incoming call
          break;
        case Event.ACTION_CALL_START:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case Event.ACTION_CALL_ACCEPT:
          NavigationService.instance.pushNamed(Routes.CALL_PAGE,
              args: VideoCallArgs(channelID: uuid, isJoin: true));
          break;
        case Event.ACTION_CALL_DECLINE:
          // TODO: declined an incoming call
          print("Decline");
          _callKitSubcription?.cancel();
          break;
        case Event.ACTION_CALL_ENDED:
          // TODO: ended an incoming/outgoing call
          _callKitSubcription?.cancel();
          break;
        case Event.ACTION_CALL_TIMEOUT:
          // TODO: missed an incoming call
          _callKitSubcription?.cancel();
          break;
        case Event.ACTION_CALL_CALLBACK:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.ACTION_CALL_TOGGLE_HOLD:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_MUTE:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_DMTF:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_GROUP:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: only iOS
          break;
        case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: only iOS
          break;
      }
    });
  } on Exception catch (e) {
    print(e);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  InitData? _initData;

  Future<void> requestPermission() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((message) {
      print(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      final type = message.data['type'] as String?;
      if (type == 'pushCall') {
        showCallkitIncoming(message);
        _listenerEvent(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    final channelID = message.data['channelID'];
    if (channelID != null) {
      Navigator.pushNamed(context, '/channel?channelID=$channelID');
      return;
    }
  }

  Future<InitData> _initConnection() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await requestPermission();
    final secureStorage = getIt<FlutterSecureStorage>();
    final rs = await secureStorage.read(key: octopusToken);
    final client = getIt<Client>();

    if (rs != null) {
      final token = Token.fromJson(jsonDecode(rs));
      if (token.user.enabled ?? false) {
        await client.connectUser(
          token,
        );
      } else {
        await secureStorage.delete(key: octopusToken);
      }
    }
    final prefs = getIt<StreamingSharedPreferences>();
    return InitData(client, prefs);
  }

  @override
  void initState() {
    final timeOfStartMs = DateTime.now().millisecondsSinceEpoch;
    _initConnection().then((initData) {
      setState(() {
        _initData = initData;
      });
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now - timeOfStartMs > 3000) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          forwardAnimations();
        });
      } else {
        Future.delayed(const Duration(milliseconds: 3000)).then((value) {
          forwardAnimations();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (_initData != null)
              PreferenceBuilder(
                preference: _initData!.preferences.getInt(
                  'theme',
                  defaultValue: 0,
                ),
                builder: (context, snap) {
                  return MaterialApp(
                    builder: (context, widget) {
                      //add this line
                      ScreenUtil.init(context);
                      return MediaQuery(
                        //Setting font does not change with system font size
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: OctopusTheme(
                          data: OctopusThemeData(
                            brightness: Theme.of(context).brightness,
                          ),
                          child: widget!,
                        ),
                      );
                    },
                    theme: ThemeData.light(),
                    darkTheme: ThemeData.dark(),
                    themeMode: {
                      -1: ThemeMode.dark,
                      0: ThemeMode.system,
                      1: ThemeMode.light,
                    }[snap],
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: AppRoutes.generateRoute,
                    navigatorKey: NavigationService.instance.navigationKey,
                    navigatorObservers: [
                      NavigationService.instance.routeObserver
                    ],
                    onGenerateInitialRoutes: (initialRouteName) {
                      if (initialRouteName == Routes.HOME) {
                        return [
                          AppRoutes.generateRoute(
                            RouteSettings(
                              name: Routes.HOME,
                              arguments: HomePageArgs(_initData!.client),
                            ),
                          )!
                        ];
                      }
                      return [
                        AppRoutes.generateRoute(
                          const RouteSettings(
                            name: Routes.WELCOME,
                          ),
                        )!
                      ];
                    },
                    initialRoute: _initData!.client.state.currentUser == null
                        ? Routes.WELCOME
                        : Routes.HOME,
                  );
                },
              ),
            if (!animationCompleted) buildAnimation(),
          ],
        );
      },
    );
  }
}

class InitData {
  final Client client;
  final StreamingSharedPreferences preferences;

  InitData(this.client, this.preferences);
}
