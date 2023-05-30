import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_group.dart';
import 'package:octopus/core/data/models/workspace_role.dart';

part 'workspace_member.g.dart';

@JsonSerializable()
class WorkspaceMember extends Equatable {
  final User user;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final WorkspaceRole? role;
  final List<WorkspaceGroup>? groups;

  const WorkspaceMember({
    required this.user,
    this.createdDate,
    this.updatedDate,
    this.role,
    this.groups,
  });

  factory WorkspaceMember.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceMemberFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceMemberToJson(this);

  @override
  List<Object?> get props => [
        user,
        createdDate,
        updatedDate,
        role,
        groups,
      ];
}
