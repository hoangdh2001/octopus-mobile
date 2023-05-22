import 'package:json_annotation/json_annotation.dart';

part 'add_members_request.g.dart';

@JsonSerializable(createToJson: true)
class AddMembersRequest {
  final List<String> members;

  AddMembersRequest({required this.members});

  factory AddMembersRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMembersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMembersRequestToJson(this);
}
