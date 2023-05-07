import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/channel_query.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:dartz/dartz.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/mark_read_request.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/new_channel.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/send_reaction_response.dart';
import 'package:octopus/core/data/networks/services/channel_service.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelService _channelService;

  ChannelRepositoryImpl(this._channelService);

  @override
  Future<Page<ChannelState>> getChannels({int? skip, int? limit}) async {
    final channels = await _channelService.getChannels(skip, limit);
    return channels;
  }

  @override
  Future<Either<ChannelState, Error>> createChannel(
      {required List<String> newMembers, String? name, String? userID}) async {
    try {
      final channel = await _channelService.createChannel(
          NewChannel(newMembers: newMembers, name: name, userID: userID));
      return left(channel);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }

  @override
  Future<ChannelState> queryChannel(String channelID,
      {PaginationParams? messagesPagination}) async {
    final channel = await _channelService.queryChannel(
        channelID, ChannelQuery(messages: messagesPagination));
    return channel;
  }

  @override
  Future<Message> sendMessage(String channelID,
      {required Message message}) async {
    return await _channelService.sendMessage(channelID, message);
  }

  @override
  Future<EmptyResponse> deleteMessage(String channelID, String messageID,
      {bool? hard}) async {
    return await _channelService.deleteMessage(channelID, messageID, hard);
  }

  @override
  Future<Attachment> sendFile(
      String channelID, String attachmentID, AttachmentFile file,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken}) async {
    final multipart = await file.toMultipartFile();
    return await _channelService.sendFile(channelID, attachmentID, multipart,
        onSendProgress, onReceiveProgress, cancelToken);
  }

  @override
  Future<Attachment> sendImage(
      String channelID, String attachmentID, AttachmentFile image,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken}) async {
    final multipart = await image.toMultipartFile();
    return await _channelService.sendImage(channelID, attachmentID, multipart,
        onSendProgress, onReceiveProgress, cancelToken);
  }

  @override
  Future<EmptyResponse> sendEvent(String channelID, Event event) async {
    return await _channelService.sendEvent(channelID, event);
  }

  @override
  Future<EmptyResponse> markChannelRead(String channelID,
      {String? messageID}) async {
    return await _channelService.markRead(
        channelID, MarkReadRequest(messageID: messageID));
  }

  @override
  Future<EmptyResponse> deleteReaction(
      String channelID, String messageID, String reactionType) async {
    return await _channelService.deleteReaction(
        channelID, messageID, reactionType);
  }

  @override
  Future<SendReactionResponse> sendReaction(
      String channelID, String messageID, String reactionType) async {
    return await _channelService.sendReaction(
        channelID, messageID, reactionType);
  }

  @override
  Future<String> call(String channelID, {String callType = 'pushCall'}) async {
    return await _channelService.call(channelID, callType);
  }
}
