import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/http/interceptors/logging_interceptor.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';

final _levelEmojiMapper = {
  Level.INFO: 'ℹ️',
  Level.WARNING: '⚠️',
  Level.SEVERE: '🚨',
};

@module
abstract class NetworkModule {
  @Named("BaseUrl")
  @singleton
  String get baseUrl => "http://137.184.249.59/api";

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
  Dio prepareDio(@Named('BaseUrl') String url,
      @Named("logging") Interceptor loggingInterceptor) {
    final dio = Dio();
    dio
      ..options.baseUrl = url
      ..options.receiveTimeout = const Duration(seconds: 6)
      ..options.connectTimeout = const Duration(seconds: 6)
      ..options.headers = {
        'Content-Type': 'application/json',
        'Content-Encoding': 'application/gzip',
      }
      ..interceptors.addAll([loggingInterceptor]);
    return dio;
  }

  @singleton
  AuthService prepareAuthService(Dio dio) => AuthService(dio);
}

// const baseUrl = "http://137.184.249.59/api";

// Future<void> registerNetwork() async {
//   Dio provideDio() {
//     final dio = Dio();
//     dio
//       ..options.baseUrl = baseUrl
//       ..options.receiveTimeout = const Duration(seconds: 6)
//       ..options.connectTimeout = const Duration(seconds: 6)
//       ..options.headers = {
//         'Content-Type': 'application/json',
//         'Content-Encoding': 'application/gzip',
//       }
//       ..interceptors.addAll([]);
//     return dio;
//   }

//   if (!GetIt.I.isRegistered<Dio>()) {
//     locator.registerFactory(() => provideDio());
//   }
//   if (!GetIt.I.isRegistered<AuthService>()) {
//     locator.registerFactory(() => AuthService(locator()));
//   }
// }
