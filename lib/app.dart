import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/screens/home_screen.dart';
import 'package:octopus/screens/login_screen.dart';
import 'package:octopus/screens/notification_email_screen.dart';
import 'package:octopus/screens/welcome_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'verify',
              builder: (context, state) => const NotificationEmailScreen(),
            )
          ]),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => MaterialApp.router(
        routerConfig: _router,
        builder: (context, widget) {
          //add this line
          ScreenUtil.init(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: OctopusTheme(
              data: OctopusThemeData(brightness: Brightness.light),
              child: widget!,
            ),
          );
        },
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
