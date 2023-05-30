import 'package:json_annotation/json_annotation.dart';

part 'add_group_request.g.dart';

@JsonSerializable()
class AddGroupRequest {
  final String name;
  final String? description;
  final List<String>? memberID;

  AddGroupRequest({required this.name, this.description, this.memberID});

  factory AddGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AddGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddGroupRequestToJson(this);
}
