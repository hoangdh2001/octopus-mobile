import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/user.dart';

part 'reaction.g.dart';

@JsonSerializable()
class Reaction extends Equatable {
  Reaction({
    required this.type,
    DateTime? createdAt,
    this.reacter,
    String? reacterID,
  })  : reacterID = reacterID ?? reacter?.id,
        createdAt = createdAt ?? DateTime.now();

  final String type;
  final DateTime createdAt;
  final User? reacter;
  final String? reacterID;

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);

  Reaction copyWith({
    DateTime? createdAt,
    String? type,
    User? reacter,
    String? reacterID,
  }) =>
      Reaction(
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        reacter: reacter ?? this.reacter,
        reacterID: reacterID ?? this.reacterID,
      );

  @override
  List<Object?> get props => [type, createdAt, reacter, reacterID];
}
