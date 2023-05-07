import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
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

  @singleton
  FirebaseMessaging get prepareFirebaseMessaging => FirebaseMessaging.instance;

  @singleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  @singleton
  Client client(
          ChannelRepository channelRepository,
          UserRepository userRepository,
          @Named('BaseUrl') String baseUrl,
          @Named('app-logger') Logger logger,
          @Named('socket-logger') Logger socketLogger) =>
      Client(
          channelRepository: channelRepository,
          userRepository: userRepository,
          baseUrl: baseUrl,
          logger: logger,
          socketLogger: socketLogger);
}
