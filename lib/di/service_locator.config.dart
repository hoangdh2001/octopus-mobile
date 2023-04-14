// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logging/logging.dart' as _i4;
import 'package:octopus/core/data/networks/services/auth_service.dart' as _i9;
import 'package:octopus/core/data/networks/services/channel_service.dart'
    as _i10;
import 'package:octopus/core/data/repositories/auth_repository.dart' as _i11;
import 'package:octopus/core/data/repositories/channel_repository.dart' as _i12;
import 'package:octopus/di/app_module.dart' as _i18;
import 'package:octopus/di/network_module.dart' as _i19;
import 'package:octopus/di/repostory_module.dart' as _i17;
import 'package:octopus/pages/channelList/bloc/channel_list_bloc.dart' as _i16;
import 'package:octopus/pages/email/bloc/email_bloc.dart' as _i13;
import 'package:octopus/pages/settings/bloc/settings_bloc.dart' as _i8;
import 'package:octopus/pages/settings/section/settings_section_factory.dart'
    as _i5;
import 'package:octopus/pages/sign_up/bloc/sign_up_bloc.dart' as _i15;
import 'package:octopus/pages/verify/bloc/login_bloc.dart' as _i14;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart'
    as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final networkModule = _$NetworkModule();
    final repositoryModule = _$RepositoryModule();
    gh.singleton<_i3.AndroidOptions>(appModule.getAndroidOptions());
    gh.singleton<_i3.IOSOptions>(appModule.getIOSOptions());
    gh.singleton<_i4.Logger>(networkModule.prepareLogger);
    gh.singleton<_i5.SettingsSectionFactory>(_i5.SettingsSectionFactory());
    await gh.singletonAsync<_i6.StreamingSharedPreferences>(
      () => appModule.shared,
      preResolve: true,
    );
    gh.singleton<String>(
      networkModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.singleton<_i3.FlutterSecureStorage>(appModule.secureStorage(
      gh<_i3.AndroidOptions>(),
      gh<_i3.IOSOptions>(),
    ));
    gh.singleton<_i7.Interceptor>(
      networkModule.prepareLoggingInterceptor(gh<_i4.Logger>()),
      instanceName: 'logging',
    );
    gh.singleton<_i7.Interceptor>(
      networkModule
          .prepareTokenManagerInterceptor(gh<_i3.FlutterSecureStorage>()),
      instanceName: 'token_manager',
    );
    gh.singleton<_i8.SettingsBloc>(_i8.SettingsBloc(
      gh<_i5.SettingsSectionFactory>(),
      gh<_i3.FlutterSecureStorage>(),
    ));
    gh.singleton<_i7.Dio>(networkModule.prepareDio(
      gh<String>(instanceName: 'BaseUrl'),
      gh<_i7.Interceptor>(instanceName: 'logging'),
      gh<_i7.Interceptor>(instanceName: 'token_manager'),
    ));
    gh.singleton<_i9.AuthService>(
        networkModule.prepareAuthService(gh<_i7.Dio>()));
    gh.singleton<_i10.ChannelService>(
        networkModule.prepareChannelService(gh<_i7.Dio>()));
    gh.singleton<_i11.AuthRepository>(
        repositoryModule.prepareAuthRepository(gh<_i9.AuthService>()));
    gh.singleton<_i12.ChannelRepository>(
        repositoryModule.prepareChannelRepository(gh<_i10.ChannelService>()));
    gh.singleton<_i13.EmailBloc>(_i13.EmailBloc(gh<_i11.AuthRepository>()));
    gh.singleton<_i14.LoginBloc>(_i14.LoginBloc(
      gh<_i11.AuthRepository>(),
      gh<_i3.FlutterSecureStorage>(),
    ));
    gh.singleton<_i15.SignUpBloc>(_i15.SignUpBloc(gh<_i11.AuthRepository>()));
    gh.singleton<_i16.ChannelListBloc>(
        _i16.ChannelListBloc(gh<_i12.ChannelRepository>()));
    return this;
  }
}

class _$RepositoryModule extends _i17.RepositoryModule {}

class _$AppModule extends _i18.AppModule {}

class _$NetworkModule extends _i19.NetworkModule {}
