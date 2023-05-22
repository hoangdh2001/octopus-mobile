import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/project.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'create_list_bloc.freezed.dart';

class CreateListBloc extends Bloc<CreateListEvent, CreateListState> {
  final Workspace _workspace;

  final Project _project;

  CreateListBloc(this._workspace, this._project)
      : super(CreateListState.initial()) {
    on<CreateListEvent>((event, emit) async {
      await event.map(nameChanged: (value) async {
        emit(state.copyWith(
            name: value.name, successOrFail: none(), isSubmitting: false));
      }, submitted: (value) async {
        await _handleSubmitted(state, emit);
      });
    });
  }

  Future<void> _handleSubmitted(
      CreateListState state, Emitter<CreateListState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    try {
      final project = await _workspace.createSpace(
          _project.id, state.name, _project.setting);
      emit(state.copyWith(isSubmitting: false, successOrFail: some(project)));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, successOrFail: none()));
    }
  }
}

@freezed
class CreateListEvent with _$CreateListEvent {
  const factory CreateListEvent.nameChanged(String name) = NameChanged;
  const factory CreateListEvent.submitted() = Submitted;
}

@freezed
class CreateListState with _$CreateListState {
  const factory CreateListState({
    required String name,
    required bool isSubmitting,
    required Option<Project> successOrFail,
    required List<TaskStatus> statusList,
  }) = _CreateListState;

  factory CreateListState.initial() => CreateListState(
        name: "",
        isSubmitting: false,
        successOrFail: none(),
        statusList: TaskStatus.defaultStatusList(),
      );
}
