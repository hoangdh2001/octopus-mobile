// ignore_for_file: deprecated_member_use_from_same_package

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

/// Pagination options.
@JsonSerializable(includeIfNull: false)
class PaginationParams extends Equatable {
  /// Creates a new PaginationParams instance
  ///
  /// For example:
  /// ```dart
  /// // limit to 50
  /// final paginationParams = PaginationParams(limit: 50);
  ///
  /// // limit to 50 with offset
  /// final paginationParams = PaginationParams(limit: 50, offset: 50);
  /// ```
  const PaginationParams({
    this.limit = 10,
    this.skip = 10,
    this.idAround,
    this.greaterThan,
    this.greaterThanOrEqual,
    this.lessThan,
    this.lessThanOrEqual,
  });

  /// Create a new instance from a json
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  /// The amount of items requested from the APIs.
  final int limit;

  /// The amount of items requested before message ID from the APIs.
  @Deprecated('before is deprecated, use limit instead')
  final int skip;

  @JsonKey(name: 'id_around')
  final String? idAround;

  /// Filter on ids greater than the given value.
  @JsonKey(name: 'id_gt')
  final String? greaterThan;

  /// Filter on ids greater than or equal to the given value.
  @JsonKey(name: 'id_gte')
  final String? greaterThanOrEqual;

  /// Filter on ids smaller than the given value.
  @JsonKey(name: 'id_lt')
  final String? lessThan;

  /// Filter on ids smaller than or equal to the given value.
  @JsonKey(name: 'id_lte')
  final String? lessThanOrEqual;

  /// Serialize model to json
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);

  /// Creates a copy of [PaginationParams] with specified attributes overridden.
  PaginationParams copyWith({
    int? limit,
    int? skip,
    String? idAround,
    String? greaterThan,
    String? greaterThanOrEqual,
    String? lessThan,
    String? lessThanOrEqual,
  }) =>
      PaginationParams(
        limit: limit ?? this.limit,
        skip: limit ?? this.skip,
        idAround: idAround ?? this.idAround,
        greaterThan: greaterThan ?? this.greaterThan,
        greaterThanOrEqual: greaterThanOrEqual ?? this.greaterThanOrEqual,
        lessThan: lessThan ?? this.lessThan,
        lessThanOrEqual: lessThanOrEqual ?? this.lessThanOrEqual,
      );

  @override
  List<Object?> get props => [
        limit,
        idAround,
        greaterThan,
        greaterThanOrEqual,
        lessThan,
        lessThanOrEqual,
      ];
}
