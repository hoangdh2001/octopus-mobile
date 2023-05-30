// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectState _$ProjectStateFromJson(Map<String, dynamic> json) => ProjectState(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      deletedDate: json['deletedDate'] == null
          ? null
          : DateTime.parse(json['deletedDate'] as String),
      spaces: (json['spaces'] as List<dynamic>?)
          ?.map((e) => SpaceState.fromJson(e as Map<String, dynamic>))
          .toList(),
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
      workspaceAccess: json['workspaceAccess'] as bool?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => ProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectStateToJson(ProjectState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'deletedDate': instance.deletedDate?.toIso8601String(),
      'spaces': instance.spaces,
      'setting': instance.setting,
      'members': instance.members,
      'workspaceAccess': instance.workspaceAccess,
      'createdDate': instance.createdDate.toIso8601String(),
    };
