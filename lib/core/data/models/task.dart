import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String? name;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String? description;
  final List<String>? assignees;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final TaskStatus? taskStatus;

  const Task({
    required this.id,
    this.name,
    this.startDate,
    this.dueDate,
    this.description,
    this.assignees,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.taskStatus,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? dueDate,
    String? description,
    List<String>? assignees,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
    TaskStatus? taskStatus,
  }) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        dueDate: dueDate ?? this.dueDate,
        description: description ?? this.description,
        assignees: assignees ?? this.assignees,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedDate: deletedDate ?? this.deletedDate,
        taskStatus: taskStatus ?? this.taskStatus,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        startDate,
        dueDate,
        description,
        assignees,
        createdDate,
        updatedDate,
        deletedDate,
        taskStatus,
      ];
}
