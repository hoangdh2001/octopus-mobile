import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/login_request.dart';
import 'package:octopus/core/data/models/sign_up_request.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/verify_email.dart';
import 'package:octopus/core/data/models/verify_email_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/auth/verify_email")
  Future<VerifyEmail> sendEmail(@Body() VerifyEmailRequest email);

  @POST("/auth/login")
  Future<Token> login(@Body() LoginRequest loginRequest);

  @POST("/auth/signup")
  Future<User> signup(@Body() SignUpRequest signUpRequest);
}
