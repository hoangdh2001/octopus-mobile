// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_space_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSpaceRequest _$CreateSpaceRequestFromJson(Map<String, dynamic> json) =>
    CreateSpaceRequest(
      name: json['name'] as String,
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateSpaceRequestToJson(CreateSpaceRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'setting': instance.setting,
    };
