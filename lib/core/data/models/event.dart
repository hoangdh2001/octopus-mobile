import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/own_user.dart';
import 'package:octopus/core/data/models/user.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  Event({
    this.type = 'local.event',
    this.connectionID,
    DateTime? createdAt,
    this.channel,
    this.channelID,
    this.message,
    this.me,
    this.user,
    this.active,
  }) : createdAt = createdAt?.toUtc() ?? DateTime.now().toUtc();

  final String type;

  final ChannelState? channel;

  final String? channelID;

  final Message? message;

  final String? connectionID;

  final OwnUser? me;

  final User? user;

  final DateTime createdAt;

  final bool? active;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
