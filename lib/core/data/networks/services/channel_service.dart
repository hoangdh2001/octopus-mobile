import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/channel_query.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/new_channel.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:retrofit/retrofit.dart';
import 'package:octopus/core/extensions/extension_multipart_file.dart';

part 'channel_service.g.dart';

@RestApi()
abstract class ChannelService {
  factory ChannelService(Dio dio, {String baseUrl}) = _ChannelService;

  @GET('/channels/search')
  Future<Page<ChannelState>> getChannels(
      @Query('skip') int? skip, @Query('limit') int? limit);

  @POST('/channels')
  Future<ChannelState> createChannel(@Body() NewChannel newChannel);

  @POST('/channels/{channelID}/query')
  Future<ChannelState> queryChannel(
      @Path('channelID') String channelID, @Body() ChannelQuery channelQuery);

  @POST('/channels/{channelID}/messages')
  Future<Message> sendMessage(
      @Path('channelID') String channelID, @Body() Message message);

  @POST('/channels/{channelID}/file')
  @MultiPart()
  Future<Attachment> sendFile(
      @Path('channelID') String channelID,
      @Part(name: 'attachmentID') String attachmentID,
      @Part(fileName: 'file') MultipartFile? file,
      @SendProgress() ProgressCallback? onSendProgress,
      @ReceiveProgress() ProgressCallback? onReceiveProgress,
      @CancelRequest() CancelToken? cancelToken);

  @POST('/channels/{channelID}/image')
  @MultiPart()
  Future<Attachment> sendImage(
      @Path('channelID') String channelID,
      @Part(name: 'attachmentID') String attachmentID,
      @Part(fileName: 'image') MultipartFile file,
      @SendProgress() ProgressCallback? onSendProgress,
      @ReceiveProgress() ProgressCallback? onReceiveProgress,
      @CancelRequest() CancelToken? cancelToken);
}
