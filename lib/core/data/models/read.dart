import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/user.dart';

part 'read.g.dart';

@JsonSerializable()
class Read extends Equatable {
  const Read({
    required this.lastRead,
    required this.user,
    this.unreadMessages = 0,
  });

  factory Read.fromJson(Map<String, dynamic> json) => _$ReadFromJson(json);

  final DateTime lastRead;

  final User user;

  final int unreadMessages;

  Map<String, dynamic> toJson() => _$ReadToJson(this);

  Read copyWith({
    DateTime? lastRead,
    User? user,
    int? unreadMessages,
  }) =>
      Read(
        lastRead: lastRead ?? this.lastRead,
        user: user ?? this.user,
        unreadMessages: unreadMessages ?? this.unreadMessages,
      );

  @override
  List<Object?> get props => [
        lastRead,
        user,
        unreadMessages,
      ];
}
