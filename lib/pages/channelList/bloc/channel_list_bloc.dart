import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/channel.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultChannelPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

@singleton
class ChannelListBloc extends PagedValueBloc<int, Channel> {
  final ChannelRepository _channelRepository;

  ChannelListBloc(this._channelRepository)
      : super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<int, Channel> state,
      Emitter<PagedValueState<int, Channel>> emit) async {
    const limit = _kDefaultBackendPaginationLimit;
    final result = await _channelRepository.getChannels(limit: limit);
    emit(result.fold((page) {
      final nextKey = page.data.length < limit ? null : page.data.length;
      return PagedValueState(items: page.data, nextPageKey: nextKey);
    }, (error) => PagedValueState.error(error)));
  }

  @override
  Future<void> loadMore(int nextPageKey, PagedValueState<int, Channel> state,
      Emitter<PagedValueState<int, Channel>> emit) async {
    final previousState = state.asSuccess;
    const limit = _kDefaultBackendPaginationLimit;
    final result =
        await _channelRepository.getChannels(limit: limit, skip: nextPageKey);
    emit(result.fold((page) {
      final previousItems = previousState.items;
      final newItems = previousItems + page.data;
      final nextKey = page.data.length < limit ? null : newItems.length;
      return previousState.copyWith(items: newItems, nextPageKey: nextKey);
    }, (error) {
      return previousState.copyWith(error: error);
    }));
  }
}
