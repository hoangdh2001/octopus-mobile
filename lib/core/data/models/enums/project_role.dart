import 'package:json_annotation/json_annotation.dart';

enum ProjectRole {
  @JsonValue('OWNER')
  OWNER,
  @JsonValue('MEMBER')
  MEMBER,
  @JsonValue('VIEWER')
  VIEWER,
}
