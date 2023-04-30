// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      type: json['type'] as String? ?? 'local.event',
      channel: json['channel'] == null
          ? null
          : ChannelState.fromJson(json['channel'] as Map<String, dynamic>),
      channelID: json['channelID'] as String?,
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      connectionID: json['connectionID'] as String?,
      me: json['me'] == null
          ? null
          : OwnUser.fromJson(json['me'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'type': instance.type,
      'channel': instance.channel,
      'channelID': instance.channelID,
      'message': instance.message,
      'connectionID': instance.connectionID,
      'me': instance.me,
    };
