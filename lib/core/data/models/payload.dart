import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';

part 'payload.g.dart';

@JsonSerializable()
class Payload extends PaginationParams {
  @JsonKey(name: "sort", includeToJson: true, includeFromJson: false)
  final List<SortOption>? sort;
  @JsonKey(
      name: "filter_conditions", includeToJson: true, includeFromJson: false)
  final Filter? filter;
  @JsonKey(includeToJson: true, includeFromJson: false)
  final int? page;
  @JsonKey(includeToJson: true, includeFromJson: false)
  final int? size;

  const Payload({
    this.sort,
    this.filter,
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
