// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectRequest _$CreateProjectRequestFromJson(
        Map<String, dynamic> json) =>
    CreateProjectRequest(
      name: json['name'] as String,
      statusList: (json['statusList'] as List<dynamic>)
          .map((e) => TaskStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      createChannel: json['createChannel'] as bool,
      workspaceAccess: json['workspaceAccess'] as bool,
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateProjectRequestToJson(
        CreateProjectRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'members': instance.members,
      'statusList': instance.statusList,
      'createChannel': instance.createChannel,
      'workspaceAccess': instance.workspaceAccess,
    };
