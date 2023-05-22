import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/get_message_response.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultMessageSearchPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

class MessageSearchListBloc extends PagedValueBloc<String, GetMessageResponse> {
  final Client client;

  final Filter filter;
  Filter _activeFilter;

  final Filter? messageFilter;
  Filter? _activeMessageFilter;

  final Filter? attachmentFilter;
  Filter? _activeAttachmentFilter;

  final String? searchQuery;
  String? _activeSearchQuery;

  final List<SortOption>? sort;
  List<SortOption>? _activeSort;

  final int limit;

  set filter(Filter value) => _activeFilter = value;

  set messageFilter(Filter? value) => _activeMessageFilter = value;

  set searchQuery(String? value) => _activeSearchQuery = value;

  set sort(List<SortOption>? value) => _activeSort = value;

  MessageSearchListBloc({
    required this.client,
    required this.filter,
    this.messageFilter,
    this.attachmentFilter,
    this.searchQuery,
    this.sort,
    this.limit = defaultMessageSearchPagedLimit,
  })  : assert(
          messageFilter != null ||
              searchQuery != null ||
              attachmentFilter != null,
          'Either messageFilter or searchQuery must be provided',
        ),
        assert(
          messageFilter == null ||
              searchQuery == null ||
              attachmentFilter != null,
          'Only one of messageFilter or searchQuery can be provided',
        ),
        _activeFilter = filter,
        _activeMessageFilter = messageFilter,
        _activeAttachmentFilter = attachmentFilter,
        _activeSearchQuery = searchQuery,
        _activeSort = sort,
        super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<String, GetMessageResponse> state,
      Emitter<PagedValueState<String, GetMessageResponse>> emit) async {
    final limit = min(
      this.limit * defaultInitialPagedLimitMultiplier,
      _kDefaultBackendPaginationLimit,
    );
    try {
      final response = await client.search(
        _activeFilter,
        sort: _activeSort,
        query: _activeSearchQuery,
        messageFilters: _activeMessageFilter,
        attachmentFilters: _activeAttachmentFilter,
        paginationParams: PaginationParams(limit: limit),
      );

      final results = response.results;
      final nextKey = response.next;
      emit(PagedValueState(
        items: results,
        nextPageKey: nextKey,
      ));
    } on OCError catch (error) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> loadMore(
      String nextPageKey,
      PagedValueState<String, GetMessageResponse> state,
      Emitter<PagedValueState<String, GetMessageResponse>> emit) async {
    final previousState = state.asSuccess;
    try {
      final response = await client.search(
        _activeFilter,
        sort: _activeSort,
        query: _activeSearchQuery,
        messageFilters: _activeMessageFilter,
        paginationParams: PaginationParams(limit: limit, next: nextPageKey),
      );

      final results = response.results;
      final previousItems = previousState.items;
      final newItems = previousItems + results;
      final next = response.next;
      final nextKey = next != null && next.isNotEmpty ? next : null;
      emit(PagedValueState(
        items: newItems,
        nextPageKey: nextKey,
      ));
    } on OCError catch (error) {
      emit(previousState.copyWith(error: error));
    } catch (error) {
      final chatError = OCError(error.toString());
      emit(previousState.copyWith(error: chatError));
    }
  }

  @override
  Future<void> refresh(
      Refresh event,
      PagedValueState<String, GetMessageResponse> state,
      Emitter<PagedValueState<String, GetMessageResponse>> emitter) async {
    if (event.resetValue ?? true) {
      _activeFilter = filter;
      _activeMessageFilter = messageFilter;
      _activeSearchQuery = searchQuery;
      _activeSort = sort;
    }
    return super.refresh(event, state, emitter);
  }
}
