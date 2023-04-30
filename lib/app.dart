import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/core/ui/notification_service.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channelList/channel_list_page.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/pages/email/email_page.dart';
import 'package:octopus/pages/home_page.dart';
import 'package:octopus/pages/new_group_page/new_group_page.dart';
import 'package:octopus/pages/new_message_page/new_message_page.dart';
import 'package:octopus/pages/notification_list_screen.dart';
import 'package:octopus/pages/options_signin_screen.dart';
import 'package:octopus/pages/sign_up/sign_up_page.dart';
import 'package:octopus/pages/splash_page.dart';
import 'package:octopus/pages/verify/login_page.dart';
import 'package:octopus/pages/verify/login_with_pass_screen.dart';
import 'package:octopus/pages/welcome_page.dart';
import 'package:octopus/utils/constants.dart';
import 'package:octopus/widgets/octopus_scaffold.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
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
    final channelRepository = getIt<ChannelRepository>();
    final userRepository = getIt<UserRepository>();
    final baseUrl = getIt<String>(instanceName: 'BaseUrl');
    final logger = getIt<Logger>(instanceName: 'app-logger');
    final socketLogger = getIt<Logger>(instanceName: 'socket-logger');
    final client = Client(
        channelRepository: channelRepository,
        userRepository: userRepository,
        baseUrl: baseUrl,
        logger: logger,
        socketLogger: socketLogger);

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
                  return MaterialApp.router(
                    routerConfig:
                        _router(_initData!.client.state.currentUser != null),
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
                  );
                },
              ),
            if (!animationCompleted) buildAnimation(),
          ],
        );
      },
    );
  }

  GoRouter _router(bool isHomeInit) {
    return GoRouter(
      initialLocation: isHomeInit ? '/home' : '/welcome',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              var client = state.extra as Client?;
              if (client == null) {
                client = _initData?.client;
              }
              return NoTransitionPage(
                name: state.fullpath,
                child: Octopus(
                  routeObserver: routeObserver,
                  client: client!,
                  firebaseMessaging: getIt<FirebaseMessaging>(),
                  child: OctopusScaffold(body: child),
                ),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: '/home',
                pageBuilder: (context, state) => NoTransitionPage(
                    child: const HomeScreen(), name: state.fullpath),
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: '/notifications',
                pageBuilder: (context, state) => NoTransitionPage(
                    child: const NotificationListScreen(),
                    name: state.fullpath),
              ),
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: '/messages',
                  pageBuilder: (context, state) => NoTransitionPage(
                      child: const ChannelListPage(), name: state.fullpath),
                  routes: [
                    GoRoute(
                      path: 'newMessage',
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) => MaterialPage(
                          child: const NewMessagePage(), name: state.fullpath),
                    ),
                    GoRoute(
                      path: 'newGroup',
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) => MaterialPage(
                          child: const NewGroupPage(), name: state.fullpath),
                    ),
                    GoRoute(
                      path: 'channel',
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) {
                        var channel = state.extra as Channel?;
                        var channelID = state.queryParams['channelID'];
                        if (channel == null) {
                          final client = Octopus.of(context).client;
                          if (client == null) debugPrint('error client');
                        }
                        return MaterialPage(
                          arguments: channel,
                          child: OctopusChannel(
                            channel: channel!,
                            child: ChannelPage(
                              channel: channel,
                            ),
                          ),
                          name: state.fullpath,
                        );
                      },
                    ),
                  ]),
            ],
            observers: [
              routeObserver
            ]),
        GoRoute(
          path: '/login',
          builder: (context, state) => const EmailPage(),
          routes: [
            GoRoute(
              path: 'verify',
              builder: (context, state) {
                final email = state.queryParams['email'];
                final type =
                    VerificationType.rawValue(state.queryParams['type']);
                return LoginPage(email: email!, verificationType: type!);
              },
            ),
            GoRoute(
              path: 'options',
              builder: (context, state) => const OptionsSignInScreen(),
              routes: [
                GoRoute(
                  path: 'pass',
                  builder: (context, state) => const LoginWithPassScreen(),
                ),
              ],
            )
          ],
        ),
        GoRoute(
          path: '/sign_up',
          builder: (context, state) {
            final token = state.extra as Token;
            return SignUpPage(
              token: token,
            );
          },
        ),
        GoRoute(
          path: '/welcome',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: WelcomePage()),
        ),
      ],
    );
  }
}

class InitData {
  final Client client;
  final StreamingSharedPreferences preferences;

  InitData(this.client, this.preferences);
}
