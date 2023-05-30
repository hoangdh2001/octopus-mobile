// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceGroup _$WorkspaceGroupFromJson(Map<String, dynamic> json) =>
    WorkspaceGroup(
      id: json['id'] as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      deletedDate: json['deletedDate'] == null
          ? null
          : DateTime.parse(json['deletedDate'] as String),
    );

Map<String, dynamic> _$WorkspaceGroupToJson(WorkspaceGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'deletedDate': instance.deletedDate?.toIso8601String(),
    };
