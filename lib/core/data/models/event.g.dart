// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      type: json['type'] as String? ?? 'local.event',
      connectionID: json['connectionID'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      channel: json['channel'] == null
          ? null
          : ChannelState.fromJson(json['channel'] as Map<String, dynamic>),
      channelID: json['channelID'] as String?,
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      me: json['me'] == null
          ? null
          : OwnUser.fromJson(json['me'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'type': instance.type,
      'channel': instance.channel,
      'channelID': instance.channelID,
      'message': instance.message,
      'connectionID': instance.connectionID,
      'me': instance.me,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
      'active': instance.active,
    };
