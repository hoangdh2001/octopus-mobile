import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/device.dart';
import 'package:octopus/core/data/models/user.dart';

part "own_user.g.dart";

@JsonSerializable()
class OwnUser extends User {
  const OwnUser({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.birthday,
    super.gender,
    super.active,
    super.lastActive,
    super.avatar,
    super.enabled,
    super.createdDate,
    super.updatedDate,
    this.devices = const [],
  });

  final List<Device> devices;

  factory OwnUser.fromUser(User user) => OwnUser(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      birthday: user.birthday,
      gender: user.gender,
      active: user.active,
      lastActive: user.lastActive,
      avatar: user.avatar,
      enabled: user.enabled,
      createdDate: user.createdDate,
      updatedDate: user.updatedDate);

  factory OwnUser.fromJson(Map<String, dynamic> json) =>
      _$OwnUserFromJson(json);

  Map<String, dynamic> toJson() => _$OwnUserToJson(this);

  OwnUser copyWith({
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
    List<Device>? devices,
  }) =>
      OwnUser(
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
        devices: devices ?? this.devices,
      );

  OwnUser merge(OwnUser? other) {
    if (other == null) return this;
    return copyWith(
      id: other.id,
      email: other.email,
      firstName: other.firstName,
      lastName: other.lastName,
      phoneNumber: other.phoneNumber,
      birthday: other.birthday,
      gender: other.gender,
      active: other.active,
      lastActive: other.lastActive,
      avatar: other.avatar,
      enabled: other.enabled,
      createdDate: other.createdDate,
      updatedDate: other.updatedDate,
      devices: other.devices,
    );
  }
}
