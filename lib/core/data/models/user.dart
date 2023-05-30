import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.birthday,
    this.gender,
    this.active,
    this.lastActive,
    this.avatar,
    this.enabled,
    this.createdDate,
    this.updatedDate,
  });

  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "birthday")
  final DateTime? birthday;
  @JsonKey(name: "gender")
  final bool? gender;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "lastActive")
  final DateTime? lastActive;
  @JsonKey(name: "avatar")
  final String? avatar;
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "createdDate")
  final DateTime? createdDate;
  @JsonKey(name: "updatedDate")
  final DateTime? updatedDate;

  String get name => '$firstName $lastName';

  @JsonKey()
  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? birthday,
    bool? gender,
    bool? active,
    DateTime? lastActive,
    String? avatar,
    bool? enabled,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        active: active ?? this.active,
        lastActive: lastActive ?? this.lastActive,
        avatar: avatar ?? this.avatar,
        enabled: enabled ?? this.enabled,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
}
