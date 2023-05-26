// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_members_with_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMemberWithEmail _$AddMemberWithEmailFromJson(Map<String, dynamic> json) =>
    AddMemberWithEmail(
      email: json['email'] as String,
      role: json['role'] as String,
      group: json['group'] as String?,
    );

Map<String, dynamic> _$AddMemberWithEmailToJson(AddMemberWithEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'role': instance.role,
      'group': instance.group,
    };
