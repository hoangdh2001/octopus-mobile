// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) => Reaction(
      type: json['type'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      reacter: json['reacter'] == null
          ? null
          : User.fromJson(json['reacter'] as Map<String, dynamic>),
      reacterID: json['reacterID'] as String?,
    );

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'reacter': instance.reacter,
      'reacterID': instance.reacterID,
    };
