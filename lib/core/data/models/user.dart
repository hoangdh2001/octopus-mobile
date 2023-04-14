import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "birthDay")
  final DateTime? birthDay;
  @JsonKey(name: "gender")
  final bool? gender;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "lastActive")
  final DateTime? lastActive;
  @JsonKey(name: "avatar")
  final String? avatar;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "createdDate")
  final DateTime? createdDate;
  @JsonKey(name: "updatedDate")
  final DateTime? updatedDate;

  const User(
      this.id,
      this.email,
      this.lastName,
      this.password,
      this.phoneNumber,
      this.birthDay,
      this.gender,
      this.active,
      this.lastActive,
      this.avatar,
      this.refreshToken,
      this.enabled,
      this.createdDate,
      this.updatedDate);

  @JsonKey()
  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
