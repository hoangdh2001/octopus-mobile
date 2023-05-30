import 'package:json_annotation/json_annotation.dart';

enum MessageStatus {
  @JsonValue("ERROR")
  error,
  @JsonValue("READY")
  ready,
  sending,
  updating,
  deleting;
}
