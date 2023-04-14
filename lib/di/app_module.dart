import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

@module
abstract class AppModule {
  @singleton
  @preResolve
  Future<StreamingSharedPreferences> get shared =>
      StreamingSharedPreferences.instance;

  @singleton
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  @singleton
  IOSOptions getIOSOptions() => const IOSOptions();

  @singleton
  FlutterSecureStorage secureStorage(
          AndroidOptions androidOptions, IOSOptions iosOptions) =>
      FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
}
