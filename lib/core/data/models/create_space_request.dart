import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/setting.dart';
import 'package:octopus/core/data/models/task_status.dart';

part 'create_space_request.g.dart';

@JsonSerializable()
class CreateSpaceRequest extends Equatable {
  final String name;
  final Setting setting;

  const CreateSpaceRequest({
    required this.name,
    required this.setting,
  });

  factory CreateSpaceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSpaceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSpaceRequestToJson(this);

  @override
  List<Object?> get props => [name];
}
