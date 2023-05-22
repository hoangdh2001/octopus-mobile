import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting extends Equatable {
  final String id;
  final List<TaskStatus> statuses;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  Setting({
    required this.id,
    required this.statuses,
    this.createdDate,
    this.updatedDate,
  });

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  @override
  List<Object?> get props => [id, statuses, createdDate, updatedDate];
}
