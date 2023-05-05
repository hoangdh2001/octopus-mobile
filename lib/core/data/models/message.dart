import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
import 'package:octopus/core/data/models/reaction.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:uuid/uuid.dart';

part 'message.g.dart';

class _NullConst {
  const _NullConst();
}

const _nullConst = _NullConst();

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
    this.quotedMessage,
    String? quotedMessageID,
    this.reactions,
    this.ownReactions,
    this.reactionCounts,
    this.deletedAt,
    this.ignoreUser,
  })  : id = id ?? const Uuid().v4(),
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _quotedMessageID = quotedMessageID;

  @JsonKey(name: "_id")
  final String id;

  @JsonKey(includeIfNull: false)
  final bool? updated;

  @JsonKey(includeIfNull: false)
  final String? channelID;

  @JsonKey(includeFromJson: true, includeToJson: false, name: "status")
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

  final Message? quotedMessage;

  final String? _quotedMessageID;

  @JsonKey(name: "quotedMessageID", includeFromJson: false, includeToJson: true)
  String? get quotedMessageID => _quotedMessageID ?? quotedMessage?.id;

  bool get isDeleted => type == MessageType.deleted;

  final List<Reaction>? reactions;

  final List<Reaction>? ownReactions;

  final Map<String, int>? reactionCounts;

  final DateTime? deletedAt;

  final List<String>? ignoreUser;

  bool get isSystem => type == MessageType.systemNotification;

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
    Object? quotedMessage = _nullConst,
    Object? quotedMessageID = _nullConst,
    List<Reaction>? reactions,
    List<Reaction>? ownReactions,
    Map<String, int>? reactionCounts,
    DateTime? deletedAt,
    List<String>? ignoreUser,
  }) {
    assert(() {
      if (quotedMessage is! Message &&
          quotedMessage != null &&
          quotedMessage is! _NullConst) {
        throw ArgumentError(
          '`quotedMessage` can only be set as Message or null',
        );
      }
      return true;
    }(), 'Validate type for quotedMessage');

    assert(() {
      if (quotedMessageID is! String &&
          quotedMessageID != null &&
          quotedMessageID is! _NullConst) {
        throw ArgumentError(
          '`quotedMessage` can only be set as String or null',
        );
      }
      return true;
    }(), 'Validate type for quotedMessage');
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
      quotedMessage: quotedMessage == _nullConst
          ? this.quotedMessage
          : quotedMessage as Message?,
      quotedMessageID: quotedMessageID == _nullConst
          ? _quotedMessageID
          : quotedMessageID as String?,
      reactions: reactions ?? this.reactions,
      ownReactions: ownReactions ?? this.ownReactions,
      reactionCounts: reactionCounts ?? this.reactionCounts,
      deletedAt: deletedAt ?? this.deletedAt,
      ignoreUser: ignoreUser ?? this.ignoreUser,
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
      quotedMessage: other.quotedMessage,
      reactions: other.reactions,
      ownReactions: other.ownReactions,
      reactionCounts: other.reactionCounts,
      deletedAt: other.deletedAt,
      ignoreUser: other.ignoreUser,
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
        quotedMessage,
        quotedMessageID,
        reactions,
        reactionCounts,
        deletedAt,
        ignoreUser,
      ];
}
