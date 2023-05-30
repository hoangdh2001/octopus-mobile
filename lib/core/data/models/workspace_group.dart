import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workspace_group.g.dart';

@JsonSerializable()
class WorkspaceGroup extends Equatable {
  final String id;
  final String? name;
  final String? description;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;

  const WorkspaceGroup({
    required this.id,
    this.name,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
  });

  factory WorkspaceGroup.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceGroupFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceGroupToJson(this);

  WorkspaceGroup copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
  }) =>
      WorkspaceGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedDate: deletedDate ?? this.deletedDate,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdDate,
        updatedDate,
        deletedDate,
      ];
}
