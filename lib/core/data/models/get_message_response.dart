import 'package:json_annotation/json_annotation.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/message.dart';

part 'get_message_response.g.dart';

@JsonSerializable(createToJson: false)
class GetMessageResponse {
  late Message message;

  ChannelModel? channel;

  static GetMessageResponse fromJson(Map<String, dynamic> json) =>
      _$GetMessageResponseFromJson(json);
}
