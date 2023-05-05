// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_reaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendReactionResponse _$SendReactionResponseFromJson(
        Map<String, dynamic> json) =>
    SendReactionResponse()
      ..message = Message.fromJson(json['message'] as Map<String, dynamic>)
      ..reaction = Reaction.fromJson(json['reaction'] as Map<String, dynamic>);
