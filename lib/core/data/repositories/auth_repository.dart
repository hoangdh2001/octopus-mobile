import 'package:octopus/core/data/models/verify_email.dart';

abstract class AuthRepository {
  Future<VerifyEmail> verifyEmail(String email);
}
