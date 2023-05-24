import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/add_members_request.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/channel_query.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/mark_read_request.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/new_channel.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/search_message_response.dart';
import 'package:octopus/core/data/models/send_reaction_response.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/networks/services/channel_service.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelService _channelService;

  ChannelRepositoryImpl(this._channelService);

  @override
  Future<Page<ChannelState>> getChannels({
    Filter? filter,
    List<SortOption<ChannelModel>>? sort,
    int? memberLimit,
    int? messageLimit,
    PaginationParams pagination = const PaginationParams(),
  }) async {
    final channels = await _channelService.getChannels(
      jsonEncode(
        {
          if (sort != null) 'sort': sort,
          if (filter != null) 'filter_conditions': filter,
          if (memberLimit != null) 'member_limit': memberLimit,
          if (messageLimit != null) 'message_limit': messageLimit,

          // pagination
          ...pagination.toJson(),
        },
      ),
    );
    return channels;
  }

  @override
  Future<ChannelState> createChannel(
      {required List<String> newMembers, String? name, String? userID}) async {
    final channel = await _channelService.createChannel(
        NewChannel(newMembers: newMembers, name: name, userID: userID));
    return channel;
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
    String channelID,
    AttachmentFile image, {
    String? attachmentID,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
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

  @override
  Future<ChannelState> udpateChannel(
      String channelID, Map<String, Object?> data) async {
    return await _channelService.updateChannel(channelID, data);
  }

  @override
  Future<Message> updateMessage(
      String channelID, String messageID, Map<String, Object?>? set) async {
    final message =
        await _channelService.updateMessage(channelID, messageID, set);
    return message;
  }

  @override
  Future<EmptyResponse> muteChannel(String channelID) async {
    final empty = await _channelService.muteChannel(channelID);
    return empty;
  }

  @override
  Future<EmptyResponse> unmuteChannel(String channelID) async {
    final empty = await _channelService.unmuteChannel(channelID);
    return empty;
  }

  @override
  Future<SearchMessagesResponse> search(Filter filter,
      {String? query,
      List<SortOption>? sort,
      PaginationParams? pagination,
      Filter? messageFilters,
      Filter? attachmentFilters}) async {
    assert(
      pagination?.offset == null || pagination?.offset == 0 || sort == null,
      'Cannot specify `offset` with `sort` parameter',
    );
    assert(() {
      if (query == null &&
          messageFilters == null &&
          attachmentFilters == null) {
        throw ArgumentError('Provide at least `query` or `messageFilters`');
      }
      if (query != null &&
          messageFilters != null &&
          attachmentFilters != null) {
        throw ArgumentError(
          "Can't provide both `query` and `messageFilters` at the same time",
        );
      }
      return true;
    }(), 'Check incoming params.');
    final searchMessagesResponse = await _channelService.search(jsonEncode({
      'filter_conditions': filter,
      if (sort != null) 'sort': sort,
      if (query != null) 'query': query,
      if (messageFilters != null) 'message_filter_conditions': messageFilters,
      if (attachmentFilters != null)
        'attachment_filter_conditions': attachmentFilters,
      if (pagination != null) ...pagination.toJson(),
    }));
    return searchMessagesResponse;
  }

  @override
  Future<EmptyResponse> addMembers(
      String channelID, List<String> members) async {
    return await _channelService.addMembers(
        channelID, AddMembersRequest(members: members));
  }

  @override
  Future<EmptyResponse> removeMembers(
      String channelID, String memberID, String removeType) async {
    return await _channelService.removeMember(channelID, memberID, removeType);
  }
}
