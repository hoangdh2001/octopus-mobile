import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/channel.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:retrofit/retrofit.dart';

part 'channel_service.g.dart';

@RestApi()
abstract class ChannelService {
  factory ChannelService(Dio dio, {String baseUrl}) = _ChannelService;

  @GET('/channels/search')
  Future<Page<Channel>> getChannels(
      @Query('skip') int? skip, @Query('limit') int? limit);
}
