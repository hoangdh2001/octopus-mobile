import 'package:json_annotation/json_annotation.dart';

part 'add_task_request.g.dart';

@JsonSerializable()
class AddTaskRequest {
  final String name;
  final String? description;
  final List<String>? assignees;
  final DateTime? startDate;
  final DateTime? dueDate;

  AddTaskRequest({
    required this.name,
    this.description,
    this.assignees,
    this.startDate,
    this.dueDate,
  });

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}
