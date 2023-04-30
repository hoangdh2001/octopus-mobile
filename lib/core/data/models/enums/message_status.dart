import 'package:json_annotation/json_annotation.dart';

enum MessageStatus {
  @JsonValue("DELETED")
  deleted,
  @JsonValue("ERROR")
  error,
  @JsonValue("READY")
  ready,
  sending;
}
