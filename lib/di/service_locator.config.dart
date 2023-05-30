// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i4;
import 'package:dio/dio.dart' as _i10;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logging/logging.dart' as _i6;
import 'package:octopus/core/data/client/client.dart' as _i20;
import 'package:octopus/core/data/networks/services/auth_service.dart' as _i14;
import 'package:octopus/core/data/networks/services/channel_service.dart'
    as _i15;
import 'package:octopus/core/data/networks/services/user_service.dart' as _i12;
import 'package:octopus/core/data/networks/services/workspace_service.dart'
    as _i13;
import 'package:octopus/core/data/repositories/auth_repository.dart' as _i18;
import 'package:octopus/core/data/repositories/channel_repository.dart' as _i19;
import 'package:octopus/core/data/repositories/user_repository.dart' as _i16;
import 'package:octopus/core/data/repositories/workspace_repository.dart'
    as _i17;
import 'package:octopus/di/app_module.dart' as _i25;
import 'package:octopus/di/network_module.dart' as _i26;
import 'package:octopus/di/repostory_module.dart' as _i24;
import 'package:octopus/pages/email/bloc/email_bloc.dart' as _i21;
import 'package:octopus/pages/settings/bloc/settings_bloc.dart' as _i11;
import 'package:octopus/pages/settings/section/settings_section_factory.dart'
    as _i7;
import 'package:octopus/pages/sign_up/bloc/sign_up_bloc.dart' as _i23;
import 'package:octopus/pages/verify/bloc/login_bloc.dart' as _i22;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart'
    as _i9;

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
    gh.singleton<_i4.DeviceInfoPlugin>(appModule.deviceInfoPlugin);
    gh.singleton<_i5.FirebaseMessaging>(appModule.prepareFirebaseMessaging);
    gh.singleton<_i3.IOSOptions>(appModule.getIOSOptions());
    gh.singleton<_i6.Logger>(
      networkModule.prepareAppLogger,
      instanceName: 'app-logger',
    );
    gh.singleton<_i6.Logger>(
      networkModule.prepareLogger,
      instanceName: 'api-logger',
    );
    gh.singleton<_i6.Logger>(
      networkModule.prepareSocketLogger,
      instanceName: 'socket-logger',
    );
    gh.singleton<_i7.SettingsSectionFactory>(_i7.SettingsSectionFactory());
    await gh.singletonAsync<_i8.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    await gh.singletonAsync<_i9.StreamingSharedPreferences>(
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
    gh.singleton<_i10.Interceptor>(
      networkModule
          .prepareTokenManagerInterceptor(gh<_i3.FlutterSecureStorage>()),
      instanceName: 'token_manager',
    );
    gh.singleton<_i10.Interceptor>(
      networkModule.prepareLoggingInterceptor(
          gh<_i6.Logger>(instanceName: 'api-logger')),
      instanceName: 'logging',
    );
    gh.singleton<_i11.SettingsBloc>(_i11.SettingsBloc(
      gh<_i7.SettingsSectionFactory>(),
      gh<_i3.FlutterSecureStorage>(),
    ));
    gh.singleton<_i10.Dio>(networkModule.prepareDio(
      gh<String>(instanceName: 'BaseUrl'),
      gh<_i10.Interceptor>(instanceName: 'logging'),
      gh<_i10.Interceptor>(instanceName: 'token_manager'),
    ));
    gh.singleton<_i12.UserService>(
        networkModule.prepareUserService(gh<_i10.Dio>()));
    gh.singleton<_i13.WorkspaceService>(
        networkModule.prepareWorkspaceService(gh<_i10.Dio>()));
    gh.singleton<_i14.AuthService>(
        networkModule.prepareAuthService(gh<_i10.Dio>()));
    gh.singleton<_i15.ChannelService>(
        networkModule.prepareChannelService(gh<_i10.Dio>()));
    gh.singleton<_i16.UserRepository>(
        repositoryModule.prepareUserRepostiry(gh<_i12.UserService>()));
    gh.singleton<_i17.WorkspaceRepository>(
        repositoryModule.prepareWorkspace(gh<_i13.WorkspaceService>()));
    gh.singleton<_i18.AuthRepository>(
        repositoryModule.prepareAuthRepository(gh<_i14.AuthService>()));
    gh.singleton<_i19.ChannelRepository>(
        repositoryModule.prepareChannelRepository(gh<_i15.ChannelService>()));
    gh.singleton<_i20.Client>(appModule.client(
      gh<_i19.ChannelRepository>(),
      gh<_i16.UserRepository>(),
      gh<_i17.WorkspaceRepository>(),
      gh<String>(instanceName: 'BaseUrl'),
      gh<_i6.Logger>(instanceName: 'app-logger'),
      gh<_i6.Logger>(instanceName: 'socket-logger'),
    ));
    gh.singleton<_i21.EmailBloc>(_i21.EmailBloc(gh<_i18.AuthRepository>()));
    gh.singleton<_i22.LoginBloc>(_i22.LoginBloc(
      gh<_i18.AuthRepository>(),
      gh<_i3.FlutterSecureStorage>(),
      gh<_i6.Logger>(instanceName: 'app-logger'),
      gh<_i16.UserRepository>(),
    ));
    gh.singleton<_i23.SignUpBloc>(_i23.SignUpBloc(
      gh<_i18.AuthRepository>(),
      gh<_i3.FlutterSecureStorage>(),
      gh<_i16.UserRepository>(),
    ));
    return this;
  }
}

class _$RepositoryModule extends _i24.RepositoryModule {}

class _$AppModule extends _i25.AppModule {}

class _$NetworkModule extends _i26.NetworkModule {}
