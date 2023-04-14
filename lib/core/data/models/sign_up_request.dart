import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';

part 'sign_up_request.g.dart';

@freezed
class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, Object?> json) =>
      _$SignUpRequestFromJson(json);
}
