// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmail _$VerifyEmailFromJson(Map<String, dynamic> json) => VerifyEmail(
      json['email'] as String,
      json['success'] as bool,
      $enumDecode(_$VerificationTypeEnumMap, json['verificationType']),
    );

Map<String, dynamic> _$VerifyEmailToJson(VerifyEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'success': instance.success,
      'verificationType': _$VerificationTypeEnumMap[instance.verificationType]!,
    };

const _$VerificationTypeEnumMap = {
  VerificationType.login: 'LOGIN',
  VerificationType.signUp: 'SIGN_UP',
};
