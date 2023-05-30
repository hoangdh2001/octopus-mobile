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

  const Setting({
    required this.id,
    required this.statuses,
    this.createdDate,
    this.updatedDate,
  });

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  Setting copyWith({
    String? id,
    List<TaskStatus>? statuses,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) =>
      Setting(
        id: id ?? this.id,
        statuses: statuses ?? this.statuses,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );

  @override
  List<Object?> get props => [id, statuses, createdDate, updatedDate];
}
