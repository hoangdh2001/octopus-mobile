// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChannelModel _$$_ChannelModelFromJson(Map<String, dynamic> json) =>
    _$_ChannelModel(
      id: json['_id'] as String,
      avatar: json['avatar'] as String?,
      name: json['name'] as String?,
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      hidden: json['hiddenChannel'] as bool,
      activeNotify: json['activeNotify'] as bool,
    );

Map<String, dynamic> _$$_ChannelModelToJson(_$_ChannelModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'avatar': instance.avatar,
      'name': instance.name,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'hiddenChannel': instance.hidden,
      'activeNotify': instance.activeNotify,
    };

_$_ChannelState _$$_ChannelStateFromJson(Map<String, dynamic> json) =>
    _$_ChannelState(
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      read: (json['read'] as List<dynamic>?)
          ?.map((e) => Read.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChannelStateToJson(_$_ChannelState instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'messages': instance.messages,
      'members': instance.members,
      'read': instance.read,
    };
