import 'package:json_annotation/json_annotation.dart';

part 'create_workspace_request.g.dart';

@JsonSerializable(createToJson: true)
class CreateWorkspaceRequest {
  final String name;
  final List<String> members;

  CreateWorkspaceRequest({required this.name, required this.members});

  factory CreateWorkspaceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkspaceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWorkspaceRequestToJson(this);
}
