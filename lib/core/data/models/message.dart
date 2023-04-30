import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:uuid/uuid.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends Equatable {
  Message({
    String? id,
    this.updated,
    this.channelID,
    this.status = MessageStatus.sending,
    this.text,
    this.type = MessageType.normal,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.sender,
    this.senderID,
    this.attachments = const [],
  })  : id = id ?? const Uuid().v4(),
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  @JsonKey(name: "_id")
  final String id;

  @JsonKey(includeIfNull: false)
  final bool? updated;

  @JsonKey(includeIfNull: false)
  final String? channelID;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  final MessageStatus status;

  @JsonKey(
    includeIfNull: false,
  )
  final String? text;

  @JsonKey(
    includeIfNull: false,
  )
  final MessageType type;

  final DateTime? _createdAt;

  @JsonKey(name: "createdAt")
  DateTime get createdAt => _createdAt ?? DateTime.now();

  final DateTime? _updatedAt;

  @JsonKey(
    name: "updatedAt",
    includeIfNull: false,
  )
  DateTime get updatedAt => _updatedAt ?? DateTime.now();

  @JsonKey(includeIfNull: false)
  final User? sender;

  @JsonKey(includeIfNull: false)
  final String? senderID;

  @JsonKey(includeIfNull: false)
  final List<Attachment> attachments;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({
    String? id,
    bool? updated,
    String? channelID,
    MessageStatus? status,
    String? text,
    MessageType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? sender,
    String? senderID,
    List<Attachment>? attachments,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      channelID: channelID ?? this.channelID,
      type: type ?? this.type,
      updated: updated ?? this.updated,
      status: status ?? this.status,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
      sender: sender ?? this.sender,
      senderID: senderID ?? this.senderID,
      attachments: attachments ?? this.attachments,
    );
  }

  Message merge(Message? other) {
    if (other == null) return this;
    return copyWith(
      id: other.id,
      updated: other.updated,
      channelID: other.channelID,
      status: other.status,
      text: other.text,
      type: other.type,
      createdAt: other.createdAt,
      updatedAt: other.updatedAt,
      sender: other.sender,
      senderID: other.senderID,
      attachments: other.attachments,
    );
  }

  @override
  List<Object?> get props => [
        id,
        updated,
        status,
        text,
        type,
        _createdAt,
        _updatedAt,
        sender,
        senderID,
        attachments,
      ];
}
