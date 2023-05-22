import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/add_members_request.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/channel_query.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/empty_response.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/mark_read_request.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/new_channel.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/models/search_message_response.dart';
import 'package:octopus/core/data/models/send_reaction_response.dart';
import 'package:retrofit/retrofit.dart';

part 'channel_service.g.dart';

@RestApi()
abstract class ChannelService {
  factory ChannelService(Dio dio, {String baseUrl}) = _ChannelService;

  @GET('/channels')
  Future<Page<ChannelState>> getChannels(@Query('payload') String payload);

  @POST('/channels')
  Future<ChannelState> createChannel(@Body() NewChannel newChannel);

  @POST('/channels/{channelID}/query')
  Future<ChannelState> queryChannel(
      @Path('channelID') String channelID, @Body() ChannelQuery channelQuery);

  @POST('/channels/{channelID}/messages')
  Future<Message> sendMessage(
      @Path('channelID') String channelID, @Body() Message message);

  @DELETE('/channels/{channelID}/messages/{messageID}')
  Future<EmptyResponse> deleteMessage(@Path('channelID') String channelID,
      @Path('messageID') String messageID, @Query('hard') bool? hard);

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
    @Part(name: 'attachmentID') String? attachmentID,
    @Part(fileName: 'image') MultipartFile? file,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @CancelRequest() CancelToken? cancelToken,
  );

  @POST('/channels/{channelID}/event')
  Future<EmptyResponse> sendEvent(
      @Path('channelID') String channelID, @Body() Event event);

  @POST('/channels/{channelID}/read')
  Future<EmptyResponse> markRead(@Path('channelID') String channelID,
      @Body() MarkReadRequest markRequestRequest);

  @POST('/channels/{channelID}/messages/{messageID}/reactions/{reactionType}')
  Future<SendReactionResponse> sendReaction(
    @Path('channelID') String channelID,
    @Path('messageID') String messageID,
    @Path('reactionType') String reactionType,
  );

  @DELETE('/channels/{channelID}/messages/{messageID}/reactions/{reactionType}')
  Future<EmptyResponse> deleteReaction(
    @Path('channelID') String channelID,
    @Path('messageID') String messageID,
    @Path('reactionType') String reactionType,
  );

  @POST('/channels/{channelID}/call/{callType}')
  Future<String> call(
      @Path('channelID') String channelID, @Path('callType') String callType);

  @PUT('/channels/{channelID}')
  Future<ChannelState> updateChannel(@Path('channelID') String channelID,
      @Body() Map<String, Object?> channelData);

  @PUT('/channels/{channelID}/messages/{messageID}')
  Future<Message> updateMessage(@Path('channelID') String channelID,
      @Path('messageID') String messageID, @Body() Map<String, Object?>? set);

  @POST('/channels/{channelID}/mute')
  Future<EmptyResponse> muteChannel(@Path('channelID') String channelID);

  @POST('/channels/{channelID}/unmute')
  Future<EmptyResponse> unmuteChannel(@Path('channelID') String channelID);

  @GET('/channels/search')
  Future<SearchMessagesResponse> search(@Query('payload') String payload);

  @POST('/channels/{channelID}/members')
  Future<EmptyResponse> addMembers(
      @Path('channelID') String channelID, @Body() AddMembersRequest members);
}
