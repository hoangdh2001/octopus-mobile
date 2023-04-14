import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue('SYSTEM_NOTIFICATION')
  systemNotification,
  @JsonValue('NORMAL')
  normal,
}
