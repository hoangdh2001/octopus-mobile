// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddGroupRequest _$AddGroupRequestFromJson(Map<String, dynamic> json) =>
    AddGroupRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      memberID: (json['memberID'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AddGroupRequestToJson(AddGroupRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'memberID': instance.memberID,
    };
