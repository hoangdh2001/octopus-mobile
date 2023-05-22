// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortOption<T> _$SortOptionFromJson<T>(Map<String, dynamic> json) =>
    SortOption<T>(
      json['field'] as String,
      direction: json['direction'] as int? ?? SortOption.DESC,
    );

Map<String, dynamic> _$SortOptionToJson<T>(SortOption<T> instance) =>
    <String, dynamic>{
      'field': instance.field,
      'direction': instance.direction,
    };
