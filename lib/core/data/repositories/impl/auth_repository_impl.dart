import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/sign_up_request.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/models/login_request.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/verify_email.dart';
import 'package:octopus/core/data/models/verify_email_request.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Either<VerifyEmail, Error>> sendEmail(String email) async {
    try {
      final verifyEmail =
          await _authService.sendEmail(VerifyEmailRequest(email));
      return left(verifyEmail);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }

  @override
  Future<Either<Token, Error>> loginWithOTP(String email, String otp) async {
    try {
      final token = await _authService
          .login(LoginRequest(email: email, type: "login_with_otp", otp: otp));
      return left(token);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }

  @override
  Future<Either<Token, Error>> loginWithPass(
      String email, String password) async {
    try {
      final token = await _authService.login(LoginRequest(
          email: email, type: "login_with_password", password: password));
      return left(token);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }

  @override
  Future<Either<User, Error>> signUp(SignUpRequest signUpRequest) async {
    try {
      final user = await _authService.signup(signUpRequest);
      return left(user);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }
}
