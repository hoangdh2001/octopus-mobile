import 'package:equatable/equatable.dart';

const _groupOperators = [
  FilterOperator.and,
  FilterOperator.or,
  FilterOperator.nor,
];

const _arrayOperators = [
  FilterOperator.in_,
  FilterOperator.notIn,
];

const _joinOperator = [
  FilterOperator.join,
];

enum FilterType {
  SQL,
  NO_SQL;
}

enum FieldType {
  STRING,

  INTEGER,

  BOOLEAN,

  DATE,

  DOUBLE,

  UUID,

  _null;

  @override
  String toString() {
    switch (this) {
      case FieldType.STRING:
        return 'STRING';
      case FieldType.INTEGER:
        return 'INTEGER';
      case FieldType.BOOLEAN:
        return 'BOOLEAN';
      case FieldType.DATE:
        return 'DATE';
      case FieldType.DOUBLE:
        return 'DOUBLE';
      case FieldType.UUID:
        return 'UUID';
      case FieldType._null:
        return 'null';
    }
  }
}

enum FilterOperator {
  equal,

  notEqual,

  greater,

  greaterOrEqual,

  less,

  lessOrEqual,

  in_,

  notIn,

  query,

  autoComplete,

  exists,

  and,

  or,

  nor,

  contains,

  join;

  @override
  String toString() {
    switch (this) {
      case FilterOperator.equal:
        return r'$eq';
      case FilterOperator.notEqual:
        return r'$ne';
      case FilterOperator.greater:
        return r'$gt';
      case FilterOperator.greaterOrEqual:
        return r'$gte';
      case FilterOperator.less:
        return r'$lt';
      case FilterOperator.lessOrEqual:
        return r'$lte';
      case FilterOperator.in_:
        return r'$in';
      case FilterOperator.notIn:
        return r'$nin';
      case FilterOperator.query:
        return r'$q';
      case FilterOperator.autoComplete:
        return r'$autocomplete';
      case FilterOperator.exists:
        return r'$exists';
      case FilterOperator.and:
        return r'$and';
      case FilterOperator.or:
        return r'$or';
      case FilterOperator.nor:
        return r'$nor';
      case FilterOperator.contains:
        return r'$contains';
      case FilterOperator.join:
        return r'$join';
    }
  }
}

class Filter extends Equatable {
  Filter.__(
      {required this.value,
      this.operator,
      this.key,
      String? fieldType,
      FilterType? type})
      : fieldType = fieldType ?? convertType(value),
        _type = type ?? FilterType.NO_SQL;

  Filter._({
    required FilterOperator operator,
    required this.value,
    this.key,
    FieldType? fieldType,
    FilterType? type,
  })  : operator = '$operator',
        fieldType = '${fieldType ?? convertType(value)}',
        _type = type ?? FilterType.NO_SQL;

  const Filter.empty()
      : value = const <String, Object?>{},
        operator = null,
        key = null,
        fieldType = null,
        _type = FilterType.NO_SQL;

  factory Filter.and(List<Filter> filters, {FilterType? type}) =>
      Filter._(operator: FilterOperator.and, value: filters, type: type);

  factory Filter.or(List<Filter> filters, {FilterType? type}) =>
      Filter._(operator: FilterOperator.or, value: filters, type: type);

  factory Filter.nor(List<Filter> filters) =>
      Filter._(operator: FilterOperator.nor, value: filters);

  factory Filter.equal(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.equal,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.notEqual(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.notEqual,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.greater(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.greater,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.greaterOrEqual(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.greaterOrEqual,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.less(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.less,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.lessOrEqual(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.lessOrEqual,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.in_(String key, List<Object> values,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.in_,
        key: key,
        value: values,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.notIn(String key, List<Object> values,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.notIn,
        key: key,
        value: values,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.query(String key, String text) =>
      Filter._(operator: FilterOperator.query, key: key, value: text);

  factory Filter.autoComplete(String key, String text) =>
      Filter._(operator: FilterOperator.autoComplete, key: key, value: text);

  factory Filter.exists(String key, {bool exists = true}) =>
      Filter._(operator: FilterOperator.exists, key: key, value: exists);

  factory Filter.notExists(String key) => Filter.exists(key, exists: false);

  factory Filter.contains(String key, Object value,
          {FieldType? fieldType, FilterType? type}) =>
      Filter._(
        operator: FilterOperator.contains,
        key: key,
        value: value,
        fieldType: fieldType,
        type: type,
      );

  factory Filter.join(String key, Object value, {FilterType? type}) => Filter._(
        operator: FilterOperator.join,
        key: key,
        value: value,
        type: type,
      );

  factory Filter.custom({
    required Object value,
    String? operator,
    String? key,
    String? fieldType,
  }) = Filter.__;

  factory Filter.raw({
    required Map<String, Object?> value,
  }) = Filter.__;

  final String? operator;

  final String? key;

  final Object /*List<Object>|List<Filter>|String*/ value;

  final String? fieldType;

  final FilterType _type;

  @override
  List<Object?> get props => [operator, key, value];

  Map<String, Object?> toJson() {
    final json = <String, Object?>{};
    final groupOperators = _groupOperators.map((it) => '$it');
    final arrayOperators = _arrayOperators.map((it) => '$it');
    final joinOperators = _joinOperator.map((it) => '$it');

    if (_type == FilterType.NO_SQL) {
      if (groupOperators.contains(operator)) {
        json[operator!] = value;
      } else if (operator != null) {
        json[key!] = {operator: value};
      } else if (key != null) {
        json[key!] = value;
      } else {
        return value as Map<String, Object?>;
      }
    } else {
      if (joinOperators.contains(operator)) {
        json['key'] = key;
        json['operator'] = operator!;
        json['value'] = value;
      } else if (groupOperators.contains(operator)) {
        json['operator'] = operator!;
        json['values'] = value;
      } else if (arrayOperators.contains(operator)) {
        json['key'] = key;
        json['operator'] = operator!;
        json['field_type'] = fieldType;
        json['values'] = value;
      } else if (operator != null) {
        json['key'] = key;
        json['operator'] = operator!;
        json['field_type'] = fieldType;
        json['value'] = value;
      } else if (key != null) {
        json['key'] = key;
        json['field_type'] = fieldType;
        json['value'] = value;
      } else {
        return value as Map<String, Object?>;
      }
    }

    return json;
  }

  static String? convertType(Object value) {
    switch (value.runtimeType) {
      case String:
        return FieldType.STRING.toString();
      case int:
        return FieldType.INTEGER.toString();
      case bool:
        return FieldType.BOOLEAN.toString();
      case DateTime:
        return FieldType.DATE.toString();
      case double:
        return FieldType.DOUBLE.toString();
      case List:
        return convertType((value as List).first);
      default:
        return null;
    }
  }
}
