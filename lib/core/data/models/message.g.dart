// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['_id'] as String,
      updated: json['updated'] as bool?,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
      text: json['text'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      channelId: json['channelId'] as String?,
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
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'updated': instance.updated,
      'status': _$MessageStatusEnumMap[instance.status],
      'text': instance.text,
      'type': _$MessageTypeEnumMap[instance.type],
      'channelId': instance.channelId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'sender': instance.sender,
      'senderID': instance.senderID,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.deleted: 'DELETED',
  MessageStatus.error: 'ERROR',
  MessageStatus.ready: 'READY',
};

const _$MessageTypeEnumMap = {
  MessageType.systemNotification: 'SYSTEM_NOTIFICATION',
  MessageType.normal: 'NORMAL',
};
