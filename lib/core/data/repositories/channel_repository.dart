import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/search_message_response.dart';
import 'package:octopus/core/data/models/send_reaction_response.dart';
import 'package:octopus/core/data/models/sort_option.dart';

abstract class ChannelRepository {
  Future<Page<ChannelState>> getChannels({
    Filter? filter,
    List<SortOption<ChannelModel>>? sort,
    int? memberLimit,
    int? messageLimit,
    PaginationParams pagination = const PaginationParams(),
  });
  Future<ChannelState> createChannel(
      {required List<String> newMembers, String? name, String? userID});
  Future<ChannelState> queryChannel(String channelID,
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
    String channelID,
    AttachmentFile image, {
    String? attachmentID,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  });
  Future<EmptyResponse> sendEvent(String channelID, Event event);

  Future<EmptyResponse> markChannelRead(String channelID, {String? messageID});

  Future<SendReactionResponse> sendReaction(
      String channelID, String messageID, String reactionType);

  Future<EmptyResponse> deleteReaction(
      String channelID, String messageID, String reactionType);

  Future<String> call(String channelID, bool hasVideo, bool isGroup,
      {String callType = 'pushCall'});

  Future<ChannelState> udpateChannel(
      String channelID, Map<String, Object?> data);

  Future<Message> updateMessage(
      String channelID, String messageID, Map<String, Object?>? set);

  Future<EmptyResponse> muteChannel(String channelID);

  Future<EmptyResponse> unmuteChannel(String channelID);

  Future<SearchMessagesResponse> search(
    Filter filter, {
    String? query,
    List<SortOption>? sort,
    PaginationParams? pagination,
    Filter? messageFilters,
    Filter? attachmentFilters,
  });

  Future<EmptyResponse> addMembers(String channelID, List<String> members);

  Future<EmptyResponse> removeMembers(
      String channelID, String memberID, String removeType);
}
