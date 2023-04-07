import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/core/data/repositories/impl/auth_repository_impl.dart';

@module
abstract class RepositoryModule {
  @singleton
  AuthRepository prepareAuthRepository(AuthService authService) =>
      AuthRepositoryImpl(authService);
}
