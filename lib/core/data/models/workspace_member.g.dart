// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceMember _$WorkspaceMemberFromJson(Map<String, dynamic> json) =>
    WorkspaceMember(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      role: json['role'] == null
          ? null
          : WorkspaceRole.fromJson(json['role'] as Map<String, dynamic>),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => WorkspaceGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkspaceMemberToJson(WorkspaceMember instance) =>
    <String, dynamic>{
      'user': instance.user,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'role': instance.role,
      'groups': instance.groups,
    };
