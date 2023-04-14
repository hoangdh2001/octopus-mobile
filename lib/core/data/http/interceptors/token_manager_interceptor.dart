import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:octopus/utils/constants.dart';
import 'package:octopus/core/data/models/token.dart';

class TokenManagerInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final String ignoreToken = "/auth";

  TokenManagerInterceptor(this.secureStorage);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      await _initConnection(options);
      super.onRequest(options, handler);
    } catch (e) {
      handler.reject(DioError.connectionError(
          requestOptions: options, reason: e.toString()));
    }
  }

  Future<void> _initConnection(RequestOptions options) async {
    if (!options.path.startsWith(ignoreToken)) {
      final value = await secureStorage.read(key: octopusToken);
      final token = Token.fromJson(jsonDecode(value!));
      options.headers['Authorization'] =
          '${token.tokenType} ${token.accessToken}';
      options.queryParameters['userID'] = token.user.id;
    }
  }
}
