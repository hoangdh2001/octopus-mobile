// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      limit: json['limit'] as int? ?? 10,
      before: json['before'] as int? ?? 10,
      after: json['after'] as int? ?? 10,
      page: json['page'] as int?,
      offset: json['offset'] as int?,
      next: json['next'] as String?,
      idAround: json['id_around'] as String?,
      greaterThan: json['id_gt'] as String?,
      greaterThanOrEqual: json['id_gte'] as String?,
      lessThan: json['id_lt'] as String?,
      lessThanOrEqual: json['id_lte'] as String?,
      createdAtAfterOrEqual: json['created_at_after_or_equal'] == null
          ? null
          : DateTime.parse(json['created_at_after_or_equal'] as String),
      createdAtAfter: json['created_at_after'] == null
          ? null
          : DateTime.parse(json['created_at_after'] as String),
      createdAtBeforeOrEqual: json['created_at_before_or_equal'] == null
          ? null
          : DateTime.parse(json['created_at_before_or_equal'] as String),
      createdAtBefore: json['created_at_before'] == null
          ? null
          : DateTime.parse(json['created_at_before'] as String),
      createdAtAround: json['created_at_around'] == null
          ? null
          : DateTime.parse(json['created_at_around'] as String),
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) {
  final val = <String, dynamic>{
    'limit': instance.limit,
    'before': instance.before,
    'after': instance.after,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('offset', instance.offset);
  writeNotNull('next', instance.next);
  writeNotNull('id_around', instance.idAround);
  writeNotNull('id_gt', instance.greaterThan);
  writeNotNull('id_gte', instance.greaterThanOrEqual);
  writeNotNull('id_lt', instance.lessThan);
  writeNotNull('id_lte', instance.lessThanOrEqual);
  writeNotNull('created_at_after_or_equal',
      instance.createdAtAfterOrEqual?.toIso8601String());
  writeNotNull('created_at_after', instance.createdAtAfter?.toIso8601String());
  writeNotNull('created_at_before_or_equal',
      instance.createdAtBeforeOrEqual?.toIso8601String());
  writeNotNull(
      'created_at_before', instance.createdAtBefore?.toIso8601String());
  writeNotNull(
      'created_at_around', instance.createdAtAround?.toIso8601String());
  return val;
}
