import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';

const defaultChannelPagedLimit = 10;

const _kDefaultBackendPaginationLimit = 30;

class ChannelListBloc extends PagedValueBloc<int, Channel> {
  final ChannelRepository _channelRepository;
  final Client _client;

  ChannelListBloc(this._channelRepository, this._client)
      : super(const PagedValueState.loading());

  @override
  Future<void> doInitialLoad(PagedValueState<int, Channel> state,
      Emitter<PagedValueState<int, Channel>> emit) async {
    const limit = _kDefaultBackendPaginationLimit;
    final result = await _channelRepository.getChannels(limit: limit);
    emit(result.fold((page) {
      final channels = _client.addChannel(page.data);
      final nextKey = channels.length < limit ? null : channels.length;
      return PagedValueState(items: channels, nextPageKey: nextKey);
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
      final channels = _client.addChannel(page.data);
      final previousItems = previousState.items;
      final newItems = previousItems + channels;
      final nextKey = channels.length < limit ? null : newItems.length;
      return previousState.copyWith(items: newItems, nextPageKey: nextKey);
    }, (error) {
      return previousState.copyWith(error: error);
    }));
  }
}
