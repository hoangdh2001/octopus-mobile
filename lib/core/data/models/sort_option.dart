import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sort_option.g.dart';

@JsonSerializable(includeIfNull: false)
class SortOption<T> {
  const SortOption(
    this.field, {
    this.direction = SortOption.DESC,
    this.comparator,
  });

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      _$SortOptionFromJson(json);

  static const ASC = 1;

  static const DESC = -1;

  final String field;

  final int direction;

  @JsonKey(ignore: true)
  final Comparator<T>? comparator;

  Map<String, dynamic> toJson() => _$SortOptionToJson(this);
}
