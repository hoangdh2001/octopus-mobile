import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable(includeIfNull: false)
class PaginationParams extends Equatable {
  const PaginationParams({
    this.limit = 10,
    this.before = 10,
    this.after = 10,
    this.page,
    this.offset,
    this.next,
    this.idAround,
    this.greaterThan,
    this.greaterThanOrEqual,
    this.lessThan,
    this.lessThanOrEqual,
    this.createdAtAfterOrEqual,
    this.createdAtAfter,
    this.createdAtBeforeOrEqual,
    this.createdAtBefore,
    this.createdAtAround,
  }) : assert(
          offset == null || offset == 0 || next == null,
          'Cannot specify non-zero `offset` with `next` parameter',
        );

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  final int limit;

  @Deprecated('before is deprecated, use limit instead')
  final int before;

  @Deprecated('after is deprecated, use limit instead')
  final int after;

  final int? page;

  final int? offset;

  final String? next;

  @JsonKey(name: 'id_around')
  final String? idAround;

  @JsonKey(name: 'id_gt')
  final String? greaterThan;

  @JsonKey(name: 'id_gte')
  final String? greaterThanOrEqual;

  @JsonKey(name: 'id_lt')
  final String? lessThan;

  @JsonKey(name: 'id_lte')
  final String? lessThanOrEqual;

  @JsonKey(name: 'created_at_after_or_equal')
  final DateTime? createdAtAfterOrEqual;

  @JsonKey(name: 'created_at_after')
  final DateTime? createdAtAfter;

  @JsonKey(name: 'created_at_before_or_equal')
  final DateTime? createdAtBeforeOrEqual;

  @JsonKey(name: 'created_at_before')
  final DateTime? createdAtBefore;

  @JsonKey(name: 'created_at_around')
  final DateTime? createdAtAround;

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);

  PaginationParams copyWith({
    int? limit,
    int? before,
    int? after,
    int? offset,
    String? idAround,
    String? next,
    String? greaterThan,
    String? greaterThanOrEqual,
    String? lessThan,
    String? lessThanOrEqual,
    DateTime? createdAtAfterOrEqual,
    DateTime? createdAtAfter,
    DateTime? createdAtBeforeOrEqual,
    DateTime? createdAtBefore,
    DateTime? createdAtAround,
  }) =>
      PaginationParams(
        limit: limit ?? this.limit,
        before: before ?? this.before,
        after: limit ?? this.after,
        offset: offset ?? this.offset,
        idAround: idAround ?? this.idAround,
        next: next ?? this.next,
        greaterThan: greaterThan ?? this.greaterThan,
        greaterThanOrEqual: greaterThanOrEqual ?? this.greaterThanOrEqual,
        lessThan: lessThan ?? this.lessThan,
        lessThanOrEqual: lessThanOrEqual ?? this.lessThanOrEqual,
        createdAtAfterOrEqual:
            createdAtAfterOrEqual ?? this.createdAtAfterOrEqual,
        createdAtAfter: createdAtAfter ?? this.createdAtAfter,
        createdAtBeforeOrEqual:
            createdAtBeforeOrEqual ?? this.createdAtBeforeOrEqual,
        createdAtBefore: createdAtBefore ?? this.createdAtBefore,
        createdAtAround: createdAtAround ?? this.createdAtAround,
      );

  @override
  List<Object?> get props => [
        limit,
        before,
        after,
        offset,
        next,
        idAround,
        greaterThan,
        greaterThanOrEqual,
        lessThan,
        lessThanOrEqual,
      ];
}
