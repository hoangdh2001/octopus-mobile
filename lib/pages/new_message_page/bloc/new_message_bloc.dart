import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/user.dart';

part 'new_message_bloc.freezed.dart';

@singleton
class NewMessageBloc extends Bloc<NewMessageEvent, NewMessageState> {
  NewMessageBloc() : super(NewMessageState.initial()) {
    on<NewMessageEvent>((event, emit) async {
      await event.map(selectedUsers: (value) async {
        state.selectedUser.add(value.user);
        emit(state.copyWith(selectedUser: state.selectedUser));
      }, removeUsers: (value) async {
        state.selectedUser.remove(value);
        emit(state.copyWith(selectedUser: state.selectedUser));
      });
    });
  }
}

@freezed
class NewMessageEvent with _$NewMessageEvent {
  const factory NewMessageEvent.selectedUsers(User user) = SelectedUsers;
  const factory NewMessageEvent.removeUsers(User user) = RemoveUsers;
}

@freezed
class NewMessageState with _$NewMessageState {
  const factory NewMessageState({required Set<User> selectedUser}) =
      _NewMessageState;

  factory NewMessageState.initial() =>
      const NewMessageState(selectedUser: <User>{});
}
