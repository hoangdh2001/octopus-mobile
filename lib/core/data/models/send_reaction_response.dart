import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/reaction.dart';

part 'send_reaction_response.g.dart';

@JsonSerializable(createToJson: false)
class SendReactionResponse {
  /// Message returned by the api call
  late Message message;

  /// The reaction created by the api call
  late Reaction reaction;

  /// Create a new instance from a json
  static SendReactionResponse fromJson(Map<String, dynamic> json) =>
      _$SendReactionResponseFromJson(json);
}
