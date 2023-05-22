// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workspace_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWorkspaceRequest _$CreateWorkspaceRequestFromJson(
        Map<String, dynamic> json) =>
    CreateWorkspaceRequest(
      name: json['name'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateWorkspaceRequestToJson(
        CreateWorkspaceRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'members': instance.members,
    };
