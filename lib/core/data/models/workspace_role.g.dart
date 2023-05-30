// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceRole _$WorkspaceRoleFromJson(Map<String, dynamic> json) =>
    WorkspaceRole(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ownCapabilities: (json['ownCapabilities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WorkspaceOwnCapabilityEnumMap, e))
          .toList(),
      roleDefault: json['roleDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkspaceRoleToJson(WorkspaceRole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roleDefault': instance.roleDefault,
      'description': instance.description,
      'ownCapabilities': instance.ownCapabilities
          ?.map((e) => _$WorkspaceOwnCapabilityEnumMap[e]!)
          .toList(),
    };

const _$WorkspaceOwnCapabilityEnumMap = {
  WorkspaceOwnCapability.allCapabilities: 'ALL_CAPABILITIES',
  WorkspaceOwnCapability.createProject: 'CREATE_PROJECT',
  WorkspaceOwnCapability.addMember: 'ADD_MEMBER',
  WorkspaceOwnCapability.createList: 'CREATE_LIST',
  WorkspaceOwnCapability.viewOtherProject: 'VIEW_OTHER_PROJECT',
};
