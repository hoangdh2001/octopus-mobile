import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';

part 'new_group_bloc.freezed.dart';

@singleton
class NewGroupBloc extends Bloc<NewGroupEvent, NewGroupState> {
  final ChannelRepository _channelRepository;

  NewGroupBloc(this._channelRepository) : super(NewGroupState.initial()) {
    on<NewGroupEvent>((event, emit) async {
      await event.map(
        changedGroupName: (value) async {
          emit(state.copyWith(name: value.groupName));
        },
        addUser: (value) async {
          emit(state.copyWith(users: Set.from(state.users)..add(value.user)));
        },
        removeUser: (value) async {
          if (state.users.contains(value.user)) {
            emit(state.copyWith(
                users: Set.from(state.users)..remove(value.user)));
          }
        },
        newGroup: (value) async {
          await _handleNewGroup(state, emit);
        },
      );
    });
  }

  Future<void> _handleNewGroup(
      NewGroupState state, Emitter<NewGroupState> emit) async {
    final result = await _channelRepository.createChannel(
        newMembers: state.users.map((user) => user.id).toList(),
        name: state.name);
    emit(result.fold(
        (user) => state.copyWith(
            successOrFail: some(left(user)), name: '', users: <User>{}),
        (error) => state.copyWith(successOrFail: some(right(error)))));
  }
}

@freezed
class NewGroupEvent with _$NewGroupEvent {
  const factory NewGroupEvent.changedGroupName(String groupName) =
      ChangedGroupName;
  const factory NewGroupEvent.addUser(User user) = AddUser;
  const factory NewGroupEvent.removeUser(User user) = RemoveUser;
  const factory NewGroupEvent.newGroup() = NewGroup;
}

@freezed
class NewGroupState with _$NewGroupState {
  const factory NewGroupState({
    required String name,
    required Set<User> users,
    required Option<Either<ChannelState, Error>> successOrFail,
  }) = _NewGroupState;

  factory NewGroupState.initial() =>
      NewGroupState(name: '', users: <User>{}, successOrFail: none());
}
