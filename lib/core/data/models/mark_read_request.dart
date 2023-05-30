import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mark_read_request.g.dart';

@JsonSerializable()
class MarkReadRequest extends Equatable {
  final String? messageID;

  const MarkReadRequest({this.messageID});

  factory MarkReadRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkReadRequestToJson(this);

  @override
  List<Object?> get props => [messageID];
}
