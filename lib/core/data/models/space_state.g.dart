// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceState _$SpaceStateFromJson(Map<String, dynamic> json) => SpaceState(
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
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpaceStateToJson(SpaceState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'deletedDate': instance.deletedDate?.toIso8601String(),
      'tasks': instance.tasks,
      'setting': instance.setting,
      'createdDate': instance.createdDate.toIso8601String(),
    };
