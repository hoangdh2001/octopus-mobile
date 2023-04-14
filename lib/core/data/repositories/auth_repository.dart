import 'package:dartz/dartz.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/sign_up_request.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/verify_email.dart';

abstract class AuthRepository {
  Future<Either<VerifyEmail, Error>> sendEmail(String email);
  Future<Either<Token, Error>> loginWithOTP(String email, String otp);
  Future<Either<Token, Error>> loginWithPass(String email, String password);
  Future<Either<User, Error>> signUp(SignUpRequest signUp);
}
