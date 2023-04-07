import 'package:octopus/core/data/models/verify_email.dart';
import 'package:octopus/core/data/models/verify_email_request.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<VerifyEmail> verifyEmail(String email) async {
    return await _authService.verifyEmail(VerifyEmailRequest(email));
  }
}
