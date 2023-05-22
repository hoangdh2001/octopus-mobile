import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/get_message_response.dart';

part 'search_message_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchMessagesResponse {
  @JsonKey(defaultValue: [])
  late List<GetMessageResponse> results;

  late String? next;

  late String? previous;

  static SearchMessagesResponse fromJson(Map<String, dynamic> json) =>
      _$SearchMessagesResponseFromJson(json);
}
