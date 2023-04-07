// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logging/logging.dart' as _i3;
import 'package:octopus/blocs/verify_email/bloc/verify_email_bloc.dart' as _i7;
import 'package:octopus/core/data/networks/services/auth_service.dart' as _i5;
import 'package:octopus/core/data/repositories/auth_repository.dart' as _i6;
import 'package:octopus/di/network_module.dart' as _i9;
import 'package:octopus/di/repostory_module.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final repositoryModule = _$RepositoryModule();
    gh.singleton<_i3.Logger>(networkModule.prepareLogger);
    gh.singleton<String>(
      networkModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.singleton<_i4.Interceptor>(
      networkModule.prepareLoggingInterceptor(gh<_i3.Logger>()),
      instanceName: 'logging',
    );
    gh.singleton<_i4.Dio>(networkModule.prepareDio(
      gh<String>(instanceName: 'BaseUrl'),
      gh<_i4.Interceptor>(instanceName: 'logging'),
    ));
    gh.singleton<_i5.AuthService>(
        networkModule.prepareAuthService(gh<_i4.Dio>()));
    gh.singleton<_i6.AuthRepository>(
        repositoryModule.prepareAuthRepository(gh<_i5.AuthService>()));
    gh.singleton<_i7.VerifyEmailBloc>(
        _i7.VerifyEmailBloc(gh<_i6.AuthRepository>()));
    return this;
  }
}

class _$RepositoryModule extends _i8.RepositoryModule {}

class _$NetworkModule extends _i9.NetworkModule {}
