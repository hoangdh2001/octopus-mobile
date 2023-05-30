// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewChannel _$$_NewChannelFromJson(Map<String, dynamic> json) =>
    _$_NewChannel(
      newMembers: (json['newMembers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
      userID: json['userID'] as String?,
    );

Map<String, dynamic> _$$_NewChannelToJson(_$_NewChannel instance) =>
    <String, dynamic>{
      'newMembers': instance.newMembers,
      'name': instance.name,
      'userID': instance.userID,
    };
