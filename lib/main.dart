import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:octopus/app.dart';
import 'package:flutter/services.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
  runApp(const MyApp());
}
