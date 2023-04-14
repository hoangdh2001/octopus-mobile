import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/email/email_page.dart';
import 'package:octopus/pages/home_screen.dart';
import 'package:octopus/pages/options_signin_screen.dart';
import 'package:octopus/pages/sign_up/sign_up_page.dart';
import 'package:octopus/pages/splash_page.dart';
import 'package:octopus/pages/verify/login_page.dart';
import 'package:octopus/pages/verify/login_with_pass_screen.dart';
import 'package:octopus/pages/welcome_page.dart';
import 'package:octopus/utils/constants.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  bool _isHomeInit = true;

  Future<bool> _initConnection() async {
    final secureStorage = getIt<FlutterSecureStorage>();
    final rs = await secureStorage.read(key: octopusToken);

    if (rs != null) {
      final token = Token.fromJson(jsonDecode(rs));
      if (token.user.enabled ?? false) {
        return true;
      }
      await secureStorage.delete(key: octopusToken);
    }
    return false;
  }

  @override
  void initState() {
    final timeOfStartMs = DateTime.now().millisecondsSinceEpoch;
    _initConnection().then((isHomeInit) {
      setState(() {
        _isHomeInit = isHomeInit;
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
        return PreferenceBuilder(
          preference: getIt<StreamingSharedPreferences>().getInt(
            'theme',
            defaultValue: 0,
          ),
          builder: (context, snap) {
            return MaterialApp.router(
              routerConfig: _router(_isHomeInit),
              builder: (context, widget) {
                //add this line
                ScreenUtil.init(context);
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: OctopusTheme(
                    data: OctopusThemeData(
                      brightness: Theme.of(context).brightness,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        widget!,
                        if (!animationCompleted) buildAnimation(),
                      ],
                    ),
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
        );
      },
    );
  }

  GoRouter _router(bool isHomeInit) {
    return GoRouter(
      initialLocation: isHomeInit ? '/' : '/welcome',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
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
            final email = state.queryParams['email'];
            return SignUpPage(email: email!);
          },
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => const WelcomePage(),
        ),
      ],
    );
  }
}
