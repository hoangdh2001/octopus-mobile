import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/message.dart';

part 'channel.freezed.dart';

part 'channel.g.dart';

@freezed
class ChannelModel with _$ChannelModel {
  const factory ChannelModel({
    @JsonKey(name: '_id') required String id,
    required String? avatar,
    required String? name,
    required String? lastMessageAt,
    required String? createdAt,
    required String? updatedAt,
  }) = _ChannelModel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
}

@freezed
class Channel with _$Channel {
  const factory Channel({
    ChannelModel? channel,
    List<Message>? messages,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}
