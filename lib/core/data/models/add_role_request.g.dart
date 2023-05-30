// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_role_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRoleRequest _$AddRoleRequestFromJson(Map<String, dynamic> json) =>
    AddRoleRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      ownCapabilities: (json['ownCapabilities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WorkspaceOwnCapabilityEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$AddRoleRequestToJson(AddRoleRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
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
