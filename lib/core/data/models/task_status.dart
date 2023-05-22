import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_status.g.dart';

@JsonSerializable()
class TaskStatus extends Equatable {
  final String? id;
  final String? name;
  final String? color;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final bool closeStatus;

  const TaskStatus({
    this.id,
    this.name,
    this.color,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.closeStatus = false,
  });

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);

  Map<String, dynamic> toJson() => _$TaskStatusToJson(this);

  @override
  List<Object?> get props =>
      [id, name, color, createdDate, updatedDate, deletedDate, closeStatus];

  TaskStatus copyWith({
    String? id,
    String? name,
    String? color,
    DateTime? createdDate,
    DateTime? updatedDate,
    DateTime? deletedDate,
    bool? closeStatus,
  }) =>
      TaskStatus(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        deletedDate: deletedDate ?? this.deletedDate,
        closeStatus: closeStatus ?? this.closeStatus,
      );

  static List<TaskStatus> defaultStatusList() {
    return [
      const TaskStatus(
        name: "TO DO",
        color: "#CCCCCC",
        closeStatus: false,
      ),
      const TaskStatus(
        name: "DONE",
        color: "#2bcd6e",
        closeStatus: true,
      ),
    ];
  }
}
