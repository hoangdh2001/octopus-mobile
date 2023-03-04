import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/config/routes/app_routes.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => MaterialApp(
        builder: (context, widget) {
          //add this line
          ScreenUtil.init(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: OctopusTheme(
              data: OctopusThemeData(brightness: Brightness.dark),
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
        initialRoute: Routes.WELCOME,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
