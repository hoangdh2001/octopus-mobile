import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/user.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String? name;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String? description;
  final List<User>? assignees;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;

  Task({
    required this.id,
    this.name,
    this.startDate,
    this.dueDate,
    this.description,
    this.assignees,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

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
        deletedDate
      ];
}
