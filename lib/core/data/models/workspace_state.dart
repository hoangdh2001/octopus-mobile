import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/user.dart';

part 'workspace_state.g.dart';

@JsonSerializable()
class WorkspaceState extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final bool? status;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<ProjectState>? projects;
  final List<User>? members;

  const WorkspaceState({
    required this.id,
    required this.name,
    this.status,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projects,
    this.members,
  });

  factory WorkspaceState.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceStateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceStateToJson(this);

  WorkspaceState copyWith({
    String? id,
    String? name,
    bool? status,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<ProjectState>? projects,
    List<User>? members,
  }) =>
      WorkspaceState(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        projects: projects ?? this.projects,
        members: members ?? this.members,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        avatar,
        createdAt,
        updatedAt,
        deletedAt,
        projects,
        members
      ];
}
