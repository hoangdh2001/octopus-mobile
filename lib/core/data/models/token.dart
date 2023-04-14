import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';
import 'package:octopus/core/data/models/user.dart';

part 'token.g.dart';

@JsonSerializable()
class Token extends Equatable {
  @JsonKey(name: "accessToken")
  final String accessToken;
  @JsonKey(name: "tokenType")
  final String tokenType;
  @JsonKey(name: "expiredIn")
  final int expiredIn;
  @JsonKey(name: "user")
  final User user;
  @JsonKey(name: "verificationType")
  final VerificationType verificationType;

  const Token(this.accessToken, this.tokenType, this.expiredIn, this.user,
      this.verificationType);

  @JsonKey()
  @override
  List<Object?> get props =>
      [accessToken, tokenType, expiredIn, user, verificationType];

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
