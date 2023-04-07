import 'package:json_annotation/json_annotation.dart';

enum VerificationType {
  @JsonValue("LOGIN")
  LOGIN,
  @JsonValue("SIGN_UP")
  SIGN_UP;
}
