import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'create_project_request.g.dart';

@JsonSerializable()
class CreateProjectRequest {
  final String name;
  final List<String>? members;
  final List<TaskStatus> statusList;
  final bool createChannel;
  final bool workspaceAccess;

  CreateProjectRequest(
      {required this.name,
      required this.statusList,
      required this.createChannel,
      required this.workspaceAccess,
      this.members});

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProjectRequestToJson(this);
}
