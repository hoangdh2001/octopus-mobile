// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      email: json['email'] as String,
      otp: json['otp'] as String?,
      password: json['password'] as String?,
      code: json['code'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'password': instance.password,
      'code': instance.code,
      'type': instance.type,
    };
