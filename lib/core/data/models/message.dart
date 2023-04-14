
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
import 'package:octopus/core/data/models/user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @JsonKey(name: '_id')
    required String id,
    required bool? updated,
    required MessageStatus? status,
    required String text,
    required MessageType? type,
    required String? channelId,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required User? sender,
    required String? senderID,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
