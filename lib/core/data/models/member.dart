import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/user.dart';

part 'member.g.dart';

@JsonSerializable()
class Member extends Equatable {
  Member({
    this.user,
    this.userID,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final User? user;

  final String? userID;

  /// The date of creation
  final DateTime createdAt;

  /// The last date of update
  final DateTime updatedAt;

  factory Member.fromJson(Map<String, dynamic> json) {
    final member = _$MemberFromJson(json);
    return member.copyWith(
      userID: member.user?.id,
    );
  }

  Member copyWith({
    User? user,
    String? userID,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Member(
        user: user ?? this.user,
        userID: userID ?? this.userID,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  List<Object?> get props => [
        user,
        createdAt,
        updatedAt,
      ];
}
