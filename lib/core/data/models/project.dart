import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/space.dart';
part 'project.g.dart';

@JsonSerializable()
class Project extends Equatable {
  final String id;
  final String name;
  final bool? status;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? deletedDate;
  final List<Space>? spaces;
  final Setting setting;

  const Project({
    required this.id,
    required this.name,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.spaces,
    required this.setting,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

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
