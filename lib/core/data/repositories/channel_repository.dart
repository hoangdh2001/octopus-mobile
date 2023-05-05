import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/send_reaction_response.dart';

abstract class ChannelRepository {
  Future<Page<ChannelState>> getChannels({int? skip, int? limit});
  Future<Either<ChannelState, Error>> createChannel(
      {required List<String> newMembers, String? name, String? userID});
  Future<Either<ChannelState, Error>> queryChannel(String channelID,
      {PaginationParams? messagesPagination});
  Future<Message> sendMessage(String channelID, {required Message message});
  Future<EmptyResponse> deleteMessage(String channelID, String messageID,
      {bool? hard});
  Future<Attachment> sendFile(
      String channelID, String attachmentID, AttachmentFile file,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken});
  Future<Attachment> sendImage(
      String channelID, String attachmentID, AttachmentFile image,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken});
  Future<EmptyResponse> sendEvent(String channelID, Event event);

  Future<EmptyResponse> markChannelRead(String channelID, {String? messageID});

  Future<SendReactionResponse> sendReaction(
      String channelID, String messageID, String reactionType);

  Future<EmptyResponse> deleteReaction(
      String channelID, String messageID, String reactionType);
}
