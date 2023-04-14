// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['email'] as String,
      json['lastName'] as String?,
      json['password'] as String?,
      json['phoneNumber'] as String?,
      json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      json['gender'] as bool?,
      json['active'] as bool?,
      json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
      json['avatar'] as String?,
      json['refreshToken'] as String?,
      json['enabled'] as bool?,
      json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'lastName': instance.lastName,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'birthDay': instance.birthDay?.toIso8601String(),
      'gender': instance.gender,
      'active': instance.active,
      'lastActive': instance.lastActive?.toIso8601String(),
      'avatar': instance.avatar,
      'refreshToken': instance.refreshToken,
      'enabled': instance.enabled,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
    };
