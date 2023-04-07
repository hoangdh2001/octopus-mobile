// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmail _$VerifyEmailFromJson(Map<String, dynamic> json) => VerifyEmail(
      json['email'] as String,
      json['success'] as bool,
      $enumDecode(_$VerificationTypeEnumMap, json['verification_type']),
    );

Map<String, dynamic> _$VerifyEmailToJson(VerifyEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'success': instance.success,
      'verification_type':
          _$VerificationTypeEnumMap[instance.verificationType]!,
    };

const _$VerificationTypeEnumMap = {
  VerificationType.LOGIN: 'LOGIN',
  VerificationType.SIGN_UP: 'SIGN_UP',
};
