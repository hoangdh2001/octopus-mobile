// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Read _$ReadFromJson(Map<String, dynamic> json) => Read(
      lastRead: DateTime.parse(json['lastRead'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      unreadMessages: json['unreadMessages'] as int? ?? 0,
    );

Map<String, dynamic> _$ReadToJson(Read instance) => <String, dynamic>{
      'lastRead': instance.lastRead.toIso8601String(),
      'user': instance.user,
      'unreadMessages': instance.unreadMessages,
    };
