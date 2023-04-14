import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/http/interceptors/logging_interceptor.dart';
import 'package:octopus/core/data/http/interceptors/token_manager_interceptor.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:octopus/core/data/networks/services/channel_service.dart';

final _levelEmojiMapper = {
  Level.INFO: 'ℹ️',
  Level.WARNING: '⚠️',
  Level.SEVERE: '🚨',
};

@module
abstract class NetworkModule {
  @Named("BaseUrl")
  @singleton
  String get baseUrl => "http://188.166.196.105/api";

  @singleton
  Logger get prepareLogger => Logger.detached("🕸️")
    ..level = Level.WARNING
    ..onRecord.listen((event) {
      print(
        '${event.time} '
        '${_levelEmojiMapper[event.level] ?? event.level.name} '
        '${event.loggerName} ${event.message} ',
      );
      if (event.error != null) print(event.error);
      if (event.stackTrace != null) print(event.stackTrace);
    });

  @singleton
  @Named("logging")
  Interceptor prepareLoggingInterceptor(Logger logger) {
    return LoggingInterceptor(
      requestHeader: true,
      logPrint: (step, message) {
        switch (step) {
          case InterceptStep.request:
            return logger.info(message);
          case InterceptStep.response:
            return logger.info(message);
          case InterceptStep.error:
            return logger.severe(message);
        }
      },
    );
  }

  @singleton
  @Named("token_manager")
  Interceptor prepareTokenManagerInterceptor(
      FlutterSecureStorage secureStorage) {
    return TokenManagerInterceptor(secureStorage);
  }

  @singleton
  Dio prepareDio(
      @Named('BaseUrl') String url,
      @Named("logging") Interceptor loggingInterceptor,
      @Named("token_manager") Interceptor tokenManagerInterceptor) {
    final dio = Dio();
    dio
      ..options.baseUrl = url
      ..options.receiveTimeout = const Duration(seconds: 6)
      ..options.connectTimeout = const Duration(seconds: 6)
      ..options.headers = {
        'Content-Type': 'application/json',
      }
      ..interceptors.addAll([loggingInterceptor, tokenManagerInterceptor]);
    return dio;
  }

  @singleton
  AuthService prepareAuthService(Dio dio) => AuthService(dio);

  @singleton
  ChannelService prepareChannelService(Dio dio) => ChannelService(dio);
}
