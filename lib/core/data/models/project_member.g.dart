// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMember _$ProjectMemberFromJson(Map<String, dynamic> json) =>
    ProjectMember(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      role: $enumDecode(_$ProjectRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$ProjectMemberToJson(ProjectMember instance) =>
    <String, dynamic>{
      'user': instance.user,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'role': _$ProjectRoleEnumMap[instance.role]!,
    };

const _$ProjectRoleEnumMap = {
  ProjectRole.OWNER: 'OWNER',
  ProjectRole.MEMBER: 'MEMBER',
  ProjectRole.VIEWER: 'VIEWER',
};
