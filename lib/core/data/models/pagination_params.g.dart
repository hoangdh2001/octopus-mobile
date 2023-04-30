// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      limit: json['limit'] as int? ?? 10,
      skip: json['skip'] as int? ?? 10,
      idAround: json['id_around'] as String?,
      greaterThan: json['id_gt'] as String?,
      greaterThanOrEqual: json['id_gte'] as String?,
      lessThan: json['id_lt'] as String?,
      lessThanOrEqual: json['id_lte'] as String?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) {
  final val = <String, dynamic>{
    'limit': instance.limit,
    'skip': instance.skip,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id_around', instance.idAround);
  writeNotNull('id_gt', instance.greaterThan);
  writeNotNull('id_gte', instance.greaterThanOrEqual);
  writeNotNull('id_lt', instance.lessThan);
  writeNotNull('id_lte', instance.lessThanOrEqual);
  return val;
}
