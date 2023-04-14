import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "otp")
  final String? otp;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "type")
  final String type;

  const LoginRequest({
    required this.email,
    this.otp,
    this.password,
    this.code,
    required this.type,
  });

  @override
  List<Object?> get props => [email, otp, password, code, type];

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
