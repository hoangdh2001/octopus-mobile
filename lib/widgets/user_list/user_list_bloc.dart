import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultChannelPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

@singleton
class UserListBloc extends PagedValueBloc<int, User> {
  final Client _client;

  UserListBloc(this._client) : super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<int, User> state,
      Emitter<PagedValueState<int, User>> emit) async {
    const limit = _kDefaultBackendPaginationLimit;
    try {
      final users = await _client.queryUser();
      final nextKey = users.length < limit ? null : users.length;
      emit(PagedValueState(items: users, nextPageKey: nextKey));
    } on OCError catch (error) {
      emit(PagedValueState.error(error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(PagedValueState.error(chatError));
    }
  }

  @override
  Future<void> loadMore(int nextPageKey, PagedValueState<int, User> state,
      Emitter<PagedValueState<int, User>> emit) async {
    final previousState = state.asSuccess;
    const limit = _kDefaultBackendPaginationLimit;
    try {
      final users = await _client.queryUser();
      final previousItems = previousState.items;
      final newItems = previousItems + users;
      final nextKey = users.length < limit ? null : newItems.length;
      emit(PagedValueState(items: newItems, nextPageKey: nextKey));
    } on OCError catch (error) {
      emit(previousState.copyWith(error: error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(previousState.copyWith(error: chatError));
    }
  }
}
