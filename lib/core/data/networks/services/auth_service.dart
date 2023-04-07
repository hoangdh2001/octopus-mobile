import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/verify_email.dart';
import 'package:octopus/core/data/models/verify_email_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/auth/verify_email")
  Future<VerifyEmail> verifyEmail(@Body() VerifyEmailRequest email);
}
