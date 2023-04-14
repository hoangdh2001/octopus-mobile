import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';

part 'verify_email.g.dart';

@JsonSerializable()
class VerifyEmail extends Equatable {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'verificationType')
  final VerificationType verificationType;

  const VerifyEmail(this.email, this.success, this.verificationType);

  @JsonKey()
  @override
  List<Object?> get props => [email, success, verificationType];

  factory VerifyEmail.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailToJson(this);

  @override
  String toString() {
    return "$email $success $verificationType";
  }
}
