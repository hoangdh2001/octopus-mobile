import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';

part 'message_list_cubit.freezed.dart';

@singleton
class MessageListCubit extends Cubit<MessageListState> {
  final ChannelRepository _channelRepository;
  MessageListCubit(this._channelRepository) : super(MessageListState.initial());

  Future<Either<ChannelState, Error>> queryChannel(String channelID,
      {PaginationParams? messagesPagination}) async {
    final rs = await _channelRepository.queryChannel(channelID,
        messagesPagination: messagesPagination);

    return rs;
  }
}

@freezed
class MessageListState with _$MessageListState {
  const factory MessageListState.initial() = _Initial;
}
