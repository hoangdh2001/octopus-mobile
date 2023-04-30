import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/own_user.dart';
part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  factory Event({
    @Default('local.event') String type,
    ChannelState? channel,
    String? channelID,
    Message? message,
    String? connectionID,
    OwnUser? me,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Known top level fields.
  /// Useful for [Serializer] methods.
  static final topLevelFields = [
    'type',
    'channel',
    'message',
  ];
}
