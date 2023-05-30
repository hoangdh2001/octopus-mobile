import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';

part 'workspace_role.g.dart';

@JsonSerializable()
class WorkspaceRole extends Equatable {
  final String id;
  final String name;
  final bool roleDefault;
  final String? description;
  final List<WorkspaceOwnCapability>? ownCapabilities;

  const WorkspaceRole({
    required this.id,
    required this.name,
    this.description,
    this.ownCapabilities,
    this.roleDefault = false,
  });

  factory WorkspaceRole.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceRoleFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceRoleToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        ownCapabilities,
        roleDefault,
      ];
}
