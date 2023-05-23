import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/task.dart';

part 'space_state.g.dart';

@JsonSerializable()
class SpaceState extends Equatable {
  final String id;
  final String name;
  final bool? status;
  final DateTime? _createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final List<Task>? tasks;
  final Setting setting;

  const SpaceState({
    required this.id,
    required this.name,
    this.status,
    DateTime? createdDate,
    this.updatedDate,
    this.deletedDate,
    this.tasks,
    required this.setting,
  }) : _createdDate = createdDate;

  DateTime get createdDate => _createdDate ?? DateTime.now();

  factory SpaceState.fromJson(Map<String, dynamic> json) =>
      _$SpaceStateFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceStateToJson(this);

  SpaceState copyWith({
    String? id,
    String? name,
    bool? status,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
    List<Task>? tasks,
    Setting? setting,
  }) {
    return SpaceState(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      deletedDate: deletedDate ?? this.deletedDate,
      tasks: tasks ?? this.tasks,
      setting: setting ?? this.setting,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        _createdDate,
        updatedDate,
        deletedDate,
        tasks,
        setting,
      ];
}
