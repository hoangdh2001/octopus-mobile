import 'package:dio/dio.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/channel.dart';
import 'package:dartz/dartz.dart';
import 'package:octopus/core/data/models/page.dart';
import 'package:octopus/core/data/networks/services/channel_service.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';

class ChannelRepositoryImpl extends ChannelRepository {
  final ChannelService _channelService;

  ChannelRepositoryImpl(this._channelService);

  @override
  Future<Either<Page<Channel>, Error>> getChannels(
      {int? skip, int? limit}) async {
    try {
      final channels = await _channelService.getChannels(skip, limit);
      return left(channels);
    } on DioError catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> error = e.response!.data;
        return right(Error.fromJson(error));
      }
      rethrow;
    }
  }
}
