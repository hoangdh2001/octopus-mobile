import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultChannelPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

@singleton
class UserListBloc extends PagedValueBloc<int, User> {
  final UserRepository _userRepository;

  UserListBloc(this._userRepository) : super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<int, User> state,
      Emitter<PagedValueState<int, User>> emit) async {
    const limit = _kDefaultBackendPaginationLimit;
    final result = await _userRepository.getUsers();
    emit(result.fold((users) {
      final nextKey = users.length < limit ? null : users.length;
      return PagedValueState(items: users, nextPageKey: nextKey);
    }, (error) => PagedValueState.error(error)));
  }

  @override
  Future<void> loadMore(int nextPageKey, PagedValueState<int, User> state,
      Emitter<PagedValueState<int, User>> emit) async {
    final previousState = state.asSuccess;
    const limit = _kDefaultBackendPaginationLimit;
    final result = await _userRepository.getUsers();
    emit(result.fold((users) {
      final previousItems = previousState.items;
      final newItems = previousItems + users;
      final nextKey = users.length < limit ? null : newItems.length;
      return previousState.copyWith(items: newItems, nextPageKey: nextKey);
    }, (error) {
      return previousState.copyWith(error: error);
    }));
  }
}
