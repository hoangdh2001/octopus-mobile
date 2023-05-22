import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/task.dart';

part 'space.g.dart';

@JsonSerializable()
class Space extends Equatable {
  final String id;
  final String name;
  final bool? status;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final List<Task>? tasks;
  final Setting setting;

  const Space({
    required this.id,
    required this.name,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.tasks,
    required this.setting,
  });

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        createdDate,
        updatedDate,
        deletedDate,
        tasks,
        setting,
      ];
}
