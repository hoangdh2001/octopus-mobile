import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

part 'new_workspace_bloc.freezed.dart';

class NewWorkspaceBloc extends Bloc<NewWorkspaceEvent, NewWorkspaceState> {
  final Client _client;

  NewWorkspaceBloc(this._client) : super(NewWorkspaceState.initial()) {
    on<NewWorkspaceEvent>((event, emit) async {
      await event.map(nameChanged: (value) async {
        emit(state.copyWith(
            name: value.name, successOrFail: none(), isSubmitting: false));
      }, submitted: (value) async {
        await _handleSubmitted(state, emit);
      });
    });
  }

  Future<void> _handleSubmitted(
      NewWorkspaceState state, Emitter<NewWorkspaceState> emit) async {
    emit(state.copyWith(isSubmitting: true, successOrFail: none()));
    try {
      final workspace = await _client.createWorkspace(name: state.name);
      emit(state.copyWith(isSubmitting: false, successOrFail: some(workspace)));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, successOrFail: none()));
    }
  }
}

@freezed
class NewWorkspaceEvent with _$NewWorkspaceEvent {
  const factory NewWorkspaceEvent.nameChanged(String name) = NameChanged;
  const factory NewWorkspaceEvent.submitted() = Submitted;
}

@freezed
class NewWorkspaceState with _$NewWorkspaceState {
  const factory NewWorkspaceState({
    required String name,
    required bool isSubmitting,
    required Option<Workspace> successOrFail,
  }) = _NewWorkspaceState;

  factory NewWorkspaceState.initial() => NewWorkspaceState(
        name: "",
        isSubmitting: false,
        successOrFail: none(),
      );
}
