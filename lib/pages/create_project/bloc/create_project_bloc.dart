import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

part 'create_project_bloc.freezed.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final Workspace _workspace;

  CreateProjectBloc(this._workspace) : super(CreateProjectState.initial()) {
    on<CreateProjectEvent>((event, emit) async {
      await event.map(nameChanged: (value) async {
        emit(state.copyWith(
            name: value.name, successOrFail: none(), isSubmitting: false));
      }, statusChanged: (value) async {
        emit(
          state.copyWith(
            statusList: value.statusList,
            successOrFail: none(),
            isSubmitting: false,
          ),
        );
      }, submitted: (value) async {
        await _handleSubmitted(state, emit);
      });
    });
  }

  Future<void> _handleSubmitted(
      CreateProjectState state, Emitter<CreateProjectState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    try {
      final workspace =
          await _workspace.createProject(state.name, state.statusList);
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
  const factory CreateProjectEvent.submitted() = Submitted;
}

@freezed
class CreateProjectState with _$CreateProjectState {
  const factory CreateProjectState({
    required String name,
    required bool isSubmitting,
    required Option<WorkspaceState> successOrFail,
    required List<TaskStatus> statusList,
  }) = _CreateProjectState;

  factory CreateProjectState.initial() => CreateProjectState(
        name: "",
        isSubmitting: false,
        successOrFail: none(),
        statusList: TaskStatus.defaultStatusList(),
      );
}
