import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request.g.dart';

@JsonSerializable()
class VerifyEmailRequest extends Equatable {
  @JsonKey(name: 'email')
  final String email;

  const VerifyEmailRequest(this.email);

  @JsonKey()
  @override
  List<Object?> get props => [email];

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);

  @override
  String toString() {
    return email;
  }
}
