import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

part 'get_task_response.g.dart';

@JsonSerializable()
class GetTaskResponse extends Equatable {
  final List<Task> tasks;
  final WorkspaceState workspace;

  const GetTaskResponse({
    required this.tasks,
    required this.workspace,
  });

  factory GetTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTaskResponseToJson(this);

  @override
  List<Object?> get props => [tasks, workspace];
}
