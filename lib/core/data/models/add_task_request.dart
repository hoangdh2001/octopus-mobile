import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'add_task_request.g.dart';

@JsonSerializable()
class AddTaskRequest extends Equatable {
  final String name;
  final String? description;
  final List<String>? assignees;
  final DateTime? startDate;
  final DateTime? dueDate;
  final TaskStatus taskStatus;

  AddTaskRequest({
    required this.name,
    this.description,
    this.assignees,
    this.startDate,
    this.dueDate,
    required this.taskStatus,
  });

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);

  @override
  List<Object?> get props => [
        name,
        description,
        assignees,
        startDate,
        dueDate,
        taskStatus,
      ];
}
