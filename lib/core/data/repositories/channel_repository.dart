import 'package:dartz/dartz.dart';
import 'package:octopus/core/data/models/channel.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/page.dart';

abstract class ChannelRepository {
  Future<Either<Page<Channel>, Error>> getChannels({int? skip, int? limit});
}
