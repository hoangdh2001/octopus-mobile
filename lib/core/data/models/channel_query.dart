import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/pagination_params.dart';

part 'channel_query.freezed.dart';
part 'channel_query.g.dart';

@freezed
class ChannelQuery with _$ChannelQuery {
  factory ChannelQuery({
    PaginationParams? messages,
  }) = _ChannelQuery;

  factory ChannelQuery.fromJson(Map<String, Object?> json) => _$ChannelQueryFromJson(json);
}
