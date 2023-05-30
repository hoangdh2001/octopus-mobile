// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChannelQuery _$$_ChannelQueryFromJson(Map<String, dynamic> json) =>
    _$_ChannelQuery(
      messages: json['messages'] == null
          ? null
          : PaginationParams.fromJson(json['messages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChannelQueryToJson(_$_ChannelQuery instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
