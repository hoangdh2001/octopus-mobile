import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';

part 'add_role_request.g.dart';

@JsonSerializable()
class AddRoleRequest {
  final String name;
  final String? description;
  final List<WorkspaceOwnCapability>? ownCapabilities;

  AddRoleRequest({required this.name, this.description, this.ownCapabilities});

  factory AddRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$AddRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddRoleRequestToJson(this);
}
