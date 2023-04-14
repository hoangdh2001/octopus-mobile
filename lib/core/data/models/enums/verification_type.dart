import 'package:json_annotation/json_annotation.dart';

enum VerificationType {
  @JsonValue("LOGIN")
  login("login"),
  @JsonValue("SIGN_UP")
  signUp("signUp");

  final String name;

  const VerificationType(this.name);

  static VerificationType? rawValue(String? name) {
    switch (name) {
      case 'login':
        return VerificationType.login;
      case 'signUp':
        return VerificationType.signUp;
      default:
        return null;
    }
  }
}
