// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['_id'] as String?,
      updated: json['updated'] as bool?,
      channelID: json['channelID'] as String?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.sending,
      text: json['text'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.normal,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      senderID: json['senderID'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      quotedMessage: json['quotedMessage'] == null
          ? null
          : Message.fromJson(json['quotedMessage'] as Map<String, dynamic>),
      reactions: (json['reactions'] as List<dynamic>?)
          ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownReactions: (json['ownReactions'] as List<dynamic>?)
          ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      reactionCounts: (json['reactionCounts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      ignoreUser: (json['ignoreUser'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updated', instance.updated);
  writeNotNull('channelID', instance.channelID);
  writeNotNull('text', instance.text);
  val['type'] = _$MessageTypeEnumMap[instance.type]!;
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt.toIso8601String();
  writeNotNull('sender', instance.sender);
  writeNotNull('senderID', instance.senderID);
  val['attachments'] = instance.attachments;
  val['quotedMessage'] = instance.quotedMessage;
  val['quotedMessageID'] = instance.quotedMessageID;
  val['reactions'] = instance.reactions;
  val['ownReactions'] = instance.ownReactions;
  val['reactionCounts'] = instance.reactionCounts;
  val['deletedAt'] = instance.deletedAt?.toIso8601String();
  val['ignoreUser'] = instance.ignoreUser;
  return val;
}

const _$MessageStatusEnumMap = {
  MessageStatus.error: 'ERROR',
  MessageStatus.ready: 'READY',
  MessageStatus.sending: 'sending',
  MessageStatus.updating: 'updating',
  MessageStatus.deleting: 'deleting',
};

const _$MessageTypeEnumMap = {
  MessageType.systemNotification: 'SYSTEM_NOTIFICATION',
  MessageType.normal: 'NORMAL',
  MessageType.deleted: 'DELETED',
};
