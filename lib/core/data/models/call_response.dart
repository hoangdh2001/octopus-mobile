import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_response.g.dart';

@JsonSerializable()
class CallResponse {
  @JsonKey(name: "uuid", includeFromJson: true, includeToJson: false)
  final String uuid;

  CallResponse(this.uuid);

  factory CallResponse.fromJson(Map<String, Object?> json) =>
      _$CallResponseFromJson(json);
}
