import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:octopus/config/routes/app_routes.dart';
import 'package:octopus/config/routes/routers.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.WELCOME,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
