import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/networks/services/auth_service.dart';
import 'package:octopus/core/data/networks/services/channel_service.dart';
import 'package:octopus/core/data/networks/services/user_service.dart';
import 'package:octopus/core/data/networks/services/workspace_service.dart';
import 'package:octopus/core/data/repositories/auth_repository.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/impl/auth_repository_impl.dart';
import 'package:octopus/core/data/repositories/impl/channel_repository_impl.dart';
import 'package:octopus/core/data/repositories/impl/user_repository_impl.dart';
import 'package:octopus/core/data/repositories/impl/workspace_repository_impl.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/data/repositories/workspace_repository.dart';

@module
abstract class RepositoryModule {
  @singleton
  AuthRepository prepareAuthRepository(AuthService authService) =>
      AuthRepositoryImpl(authService);

  @singleton
  ChannelRepository prepareChannelRepository(ChannelService channelService) =>
      ChannelRepositoryImpl(channelService);

  @singleton
  UserRepository prepareUserRepostiry(UserService userService) =>
      UserRepositoryImpl(userService);

  @singleton
  WorkspaceRepository prepareWorkspace(WorkspaceService workspaceService) =>
      WorkspaceRepositoryImpl(workspaceService);
}
