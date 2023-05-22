import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/project.dart';
import 'package:octopus/core/data/models/space.dart';
import 'package:octopus/core/data/models/user.dart';

part 'new_task_bloc.freezed.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  final Workspace _workspace;

  NewTaskBloc(this._workspace) : super(NewTaskState.initial()) {
    on<NewTaskEvent>(
      (event, emit) async {
        await event.map(nameChanged: (value) async {
          emit(state.copyWith(
            name: value.name,
            successOrFail: none(),
            isSubmitting: false,
          ));
        }, descriptionChanged: (value) async {
          emit(state.copyWith(
            description: value.description,
            successOrFail: none(),
            isSubmitting: false,
          ));
        }, assigneesChanged: (value) {
          emit(
            state.copyWith(
              assignees: [...value.assignees],
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        }, startDateChanged: (value) {
          emit(
            state.copyWith(
              startDate: value.startDate,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        }, dueDateChanged: (value) {
          emit(
            state.copyWith(
              dueDate: value.dueDate,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        }, submitted: (value) async {
          await _handleSubmitted(state, emit);
        }, selectList: (value) {
          emit(
            state.copyWith(
              project: value.project,
              space: value.space,
              successOrFail: none(),
              isSubmitting: false,
            ),
          );
        });
      },
    );
  }

  Future<void> _handleSubmitted(
      NewTaskState state, Emitter<NewTaskState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    if (state.space == null || state.project == null) {
      emit(state.copyWith(
          isSubmitting: false,
          successOrFail: some(right('Select list first'))));
      return;
    }
    try {
      final project = await _workspace.newTask(
        state.project!.id,
        state.space!.id,
        state.name,
        description: state.description,
        assignees: state.assignees,
        startDate: state.startDate,
        dueDate: state.dueDate,
      );
      emit(state.copyWith(
          isSubmitting: false, successOrFail: some(left(project))));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, successOrFail: none()));
    }
  }
}

@freezed
class NewTaskEvent with _$NewTaskEvent {
  const factory NewTaskEvent.nameChanged(String name) = NameChanged;
  const factory NewTaskEvent.descriptionChanged(String description) =
      DescriptionChanged;
  const factory NewTaskEvent.assigneesChanged(List<User> assignees) =
      AssigneesChanged;
  const factory NewTaskEvent.startDateChanged(DateTime? startDate) =
      StartDateChanged;
  const factory NewTaskEvent.dueDateChanged(DateTime? dueDate) = DueDateChanged;
  const factory NewTaskEvent.selectList(Project project, Space space) =
      SelectList;
  const factory NewTaskEvent.submitted() = Submitted;
}

@freezed
class NewTaskState with _$NewTaskState {
  const factory NewTaskState({
    required String name,
    Space? space,
    Project? project,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    List<User>? assignees,
    required bool isSubmitting,
    required Option<Either<Project, String>> successOrFail,
  }) = _NewTaskState;

  factory NewTaskState.initial() => NewTaskState(
        name: "",
        isSubmitting: false,
        successOrFail: none(),
      );
}
