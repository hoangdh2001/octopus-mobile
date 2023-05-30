import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

part 'create_project_bloc.freezed.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final Workspace _workspace;

  CreateProjectBloc(this._workspace, List<User> users)
      : super(CreateProjectState.initial(users)) {
    on<CreateProjectEvent>((event, emit) async {
      await event.map(
        nameChanged: (value) async {
          emit(state.copyWith(
              name: value.name, successOrFail: none(), isSubmitting: false));
        },
        statusChanged: (value) async {
          emit(
            state.copyWith(
              statusList: value.statusList,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        },
        submitted: (value) async {
          await _handleSubmitted(state, emit);
        },
        usersChanged: (value) async {
          emit(
            state.copyWith(
              users: [...value.users],
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        },
        workspaceAccessChanged: (value) async {
          emit(
            state.copyWith(
              workspaceAccess: value.workspaceAccess,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        },
        createChannelForProjectChanged: (value) async {
          emit(
            state.copyWith(
              createChannelForProject: value.createChannelForProject,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        },
      );
    });
  }

  Future<void> _handleSubmitted(
      CreateProjectState state, Emitter<CreateProjectState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    try {
      final workspace = await _workspace.createProject(
        state.name,
        state.statusList,
        state.workspaceAccess && state.users.length <= 2
            ? false
            : state.createChannelForProject,
        state.workspaceAccess,
        state.workspaceAccess ? [] : state.users,
      );
      emit(state.copyWith(isSubmitting: false, successOrFail: some(workspace)));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, successOrFail: none()));
    }
  }
}

@freezed
class CreateProjectEvent with _$CreateProjectEvent {
  const factory CreateProjectEvent.nameChanged(String name) = NameChanged;
  const factory CreateProjectEvent.statusChanged(List<TaskStatus> statusList) =
      StatusChanged;

  const factory CreateProjectEvent.usersChanged(List<User> users) =
      UsersChanged;

  const factory CreateProjectEvent.workspaceAccessChanged(
      bool workspaceAccess) = WorkspaceAccessChanged;
  const factory CreateProjectEvent.createChannelForProjectChanged(
      bool createChannelForProject) = CreateChannelForProjectChanged;
  const factory CreateProjectEvent.submitted() = Submitted;
}

@freezed
class CreateProjectState with _$CreateProjectState {
  const factory CreateProjectState({
    required String name,
    required bool isSubmitting,
    required Option<WorkspaceState> successOrFail,
    required List<TaskStatus> statusList,
    required List<User> users,
    required bool createChannelForProject,
    required bool workspaceAccess,
  }) = _CreateProjectState;

  factory CreateProjectState.initial(List<User> user) => CreateProjectState(
        name: "",
        isSubmitting: false,
        successOrFail: none(),
        statusList: TaskStatus.defaultStatusList(),
        users: user,
        createChannelForProject: true,
        workspaceAccess: true,
      );
}
