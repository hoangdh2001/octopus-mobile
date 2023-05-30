import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultUserPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

class UserListBloc extends PagedValueBloc<int, User> {
  final Client client;

  final Filter? filter;
  Filter? _activeFilter;

  final List<SortOption>? sort;
  List<SortOption>? _activeSort;

  /// If true you’ll receive user presence updates via the websocket events
  final bool presence;

  /// The limit to apply to the user list. The default is set to
  /// [defaultUserPagedLimit].
  final int limit;

  /// Allows for the change of filters used for user queries.
  ///
  /// Use this if you need to support runtime filter changes,
  /// through custom filters UI.
  set filter(Filter? value) => _activeFilter = value;

  /// Allows for the change of the query sort used for user queries.
  ///
  /// Use this if you need to support runtime sort changes,
  /// through custom sort UI.
  set sort(List<SortOption>? value) => _activeSort = value;

  UserListBloc({
    required this.client,
    this.filter,
    this.sort,
    this.presence = true,
    this.limit = defaultUserPagedLimit,
  }) : super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<int, User> state,
      Emitter<PagedValueState<int, User>> emit) async {
    const limit = _kDefaultBackendPaginationLimit;
    try {
      final users = await client.queryUser(
        filter: _activeFilter ?? filter,
        sort: _activeSort ?? sort,
        pagination: const PaginationParams(limit: limit),
      );
      final nextKey = users.length < limit ? null : 1;
      final membersWorkspace = users
          .where((user) =>
              client.state.currentWorkspace!.state!.workspaceState.members
                  ?.map((member) => member.user)
                  .contains(user) ??
              false)
          .toList();
      emit(PagedValueState(items: membersWorkspace, nextPageKey: nextKey));
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
      final users = await client.queryUser(
        filter: _activeFilter,
        sort: _activeSort,
        pagination: PaginationParams(limit: limit, offset: nextPageKey),
      );
      final previousItems = previousState.items;
      final newItems = previousItems + users;
      final nextKey = users.length < limit ? null : nextPageKey + 1;
      final membersWorkspace = newItems
          .where((user) =>
              client.state.currentWorkspace!.state!.workspaceState.members
                  ?.contains(user) ??
              false)
          .toList();
      emit(PagedValueState(items: membersWorkspace, nextPageKey: nextKey));
    } on OCError catch (error) {
      emit(previousState.copyWith(error: error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(previousState.copyWith(error: chatError));
    }
  }
}
