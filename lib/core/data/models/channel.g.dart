// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChannelModel _$$_ChannelModelFromJson(Map<String, dynamic> json) =>
    _$_ChannelModel(
      id: json['_id'] as String,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      lastMessageAt: json['lastMessageAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_ChannelModelToJson(_$_ChannelModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'avatar': instance.avatar,
      'name': instance.name,
      'lastMessageAt': instance.lastMessageAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_$_Channel _$$_ChannelFromJson(Map<String, dynamic> json) => _$_Channel(
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChannelToJson(_$_Channel instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'messages': instance.messages,
    };
