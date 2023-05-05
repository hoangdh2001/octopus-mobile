import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/read.dart';

part 'channel_state.freezed.dart';

part 'channel_state.g.dart';

@freezed
class ChannelModel with _$ChannelModel {
  const factory ChannelModel({
    @JsonKey(name: '_id') required String id,
    String? avatar,
    String? name,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    @JsonKey(name: 'hiddenChannel') required bool hidden,
    required bool activeNotify,
  }) = _ChannelModel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);
}

@freezed
class ChannelState with _$ChannelState {
  const factory ChannelState({
    ChannelModel? channel,
    List<Message>? messages,
    List<Member>? members,
    List<Read>? read,
  }) = _ChannelState;

  factory ChannelState.fromJson(Map<String, dynamic> json) =>
      _$ChannelStateFromJson(json);
}

extension ChannelModelExtension on ChannelModel {
  ChannelModel merge(
    ChannelModel? other,
  ) {
    if (other == null) return this;
    return copyWith(
      id: other.id,
      lastMessageAt: other.lastMessageAt,
      createdAt: other.createdAt,
      updatedAt: other.updatedAt,
      deletedAt: other.deletedAt,
      hidden: other.hidden,
      activeNotify: other.activeNotify,
      avatar: other.avatar,
      name: other.name,
    );
  }
}
