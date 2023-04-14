// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      json['accessToken'] as String,
      json['tokenType'] as String,
      json['expiredIn'] as int,
      User.fromJson(json['user'] as Map<String, dynamic>),
      $enumDecode(_$VerificationTypeEnumMap, json['verificationType']),
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expiredIn': instance.expiredIn,
      'user': instance.user,
      'verificationType': _$VerificationTypeEnumMap[instance.verificationType]!,
    };

const _$VerificationTypeEnumMap = {
  VerificationType.login: 'LOGIN',
  VerificationType.signUp: 'SIGN_UP',
};
