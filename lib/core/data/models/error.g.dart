// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Error _$$_ErrorFromJson(Map<String, dynamic> json) => _$_Error(
      title: json['title'] as String,
      status: json['status'] as int,
      detail: json['detail'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$_ErrorToJson(_$_Error instance) => <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
      'path': instance.path,
    };
