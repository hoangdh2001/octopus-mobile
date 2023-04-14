// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Page<T>(
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      totalItem: json['totalItem'] as int?,
      totalPage: json['totalPage'] as int?,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PageToJson<T>(
  Page<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'skip': instance.skip,
      'limit': instance.limit,
      'totalItem': instance.totalItem,
      'totalPage': instance.totalPage,
      'data': instance.data.map(toJsonT).toList(),
    };
