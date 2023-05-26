// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceState _$WorkspaceStateFromJson(Map<String, dynamic> json) =>
    WorkspaceState(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool?,
      avatar: json['avatar'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => ProjectState.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => WorkspaceMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkspaceStateToJson(WorkspaceState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'projects': instance.projects,
      'members': instance.members,
    };
