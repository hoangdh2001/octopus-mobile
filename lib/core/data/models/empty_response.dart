import 'package:json_annotation/json_annotation.dart';

part 'empty_response.g.dart';

@JsonSerializable(createToJson: false)
class EmptyResponse {
  /// Create a new instance from a json
  static EmptyResponse fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);
}
