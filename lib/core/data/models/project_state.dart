import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/space_state.dart';
part 'project_state.g.dart';

@JsonSerializable()
class ProjectState extends Equatable {
  final String id;
  final String name;
  final bool? status;
  final DateTime? _createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final List<SpaceState>? spaces;
  final Setting setting;

  const ProjectState({
    required this.id,
    required this.name,
    this.status,
    DateTime? createdDate,
    this.updatedDate,
    this.deletedDate,
    this.spaces,
    required this.setting,
  }) : _createdDate = createdDate;

  DateTime get createdDate => _createdDate ?? DateTime.now();

  factory ProjectState.fromJson(Map<String, dynamic> json) =>
      _$ProjectStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectStateToJson(this);

  ProjectState copyWith({
    String? id,
    String? name,
    bool? status,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
    List<SpaceState>? spaces,
    Setting? setting,
  }) =>
      ProjectState(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedDate: deletedDate ?? this.deletedDate,
        spaces: spaces ?? this.spaces,
        setting: setting ?? this.setting,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        createdDate,
        updatedDate,
        deletedDate,
        spaces,
        setting,
      ];
}
