import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/enums/project_role.dart';
import 'package:octopus/core/data/models/user.dart';

part 'project_member.g.dart';

@JsonSerializable()
class ProjectMember extends Equatable {
  final User user;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final ProjectRole role;

  const ProjectMember({
    required this.user,
    this.createdDate,
    this.updatedDate,
    required this.role,
  });

  factory ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectMemberToJson(this);

  ProjectMember copyWith({
    User? user,
    DateTime? createdDate,
    DateTime? updatedDate,
    ProjectRole? role,
  }) =>
      ProjectMember(
        user: user ?? this.user,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        role: role ?? this.role,
      );

  @override
  List<Object?> get props => [
        user,
        createdDate,
        updatedDate,
        role,
      ];
}
