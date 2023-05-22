import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/read.dart';
import 'package:octopus/core/data/models/user.dart';

part 'channel_state.g.dart';

@JsonSerializable()
class ChannelModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;

  final String? avatar;

  final String? name;

  final DateTime? lastMessageAt;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final DateTime? deletedAt;

  @JsonKey(name: 'hiddenChannel')
  final bool hidden;

  final bool activeNotify;

  final User? createdBy;

  ChannelModel({
    required this.id,
    this.name,
    this.lastMessageAt,
    this.avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deletedAt,
    required this.hidden,
    required this.activeNotify,
    this.createdBy,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);

  ChannelModel copyWith({
    String? id,
    String? name,
    DateTime? lastMessageAt,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool? hidden,
    bool? activeNotify,
    User? createdBy,
  }) =>
      ChannelModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lastMessageAt: lastMessageAt ?? this.lastMessageAt,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        hidden: hidden ?? this.hidden,
        activeNotify: activeNotify ?? this.activeNotify,
        createdBy: createdBy ?? this.createdBy,
      );

  ChannelModel merge(
    ChannelModel? other,
  ) {
    if (other == null) return this;
    return copyWith(
      id: other.id,
      lastMessageAt: other.lastMessageAt,
      createdAt: other.createdAt,
      updatedAt: other.updatedAt,
      deletedAt: other.deletedAt,
      hidden: other.hidden,
      activeNotify: other.activeNotify,
      avatar: other.avatar,
      name: other.name,
      createdBy: other.createdBy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        avatar,
        name,
        lastMessageAt,
        createdAt,
        updatedAt,
        deletedAt,
        hidden,
        activeNotify,
        createdBy
      ];
}

@JsonSerializable()
class ChannelState extends Equatable {
  final ChannelModel? channel;

  final List<Message>? messages;

  final List<Member>? members;

  final List<Read>? read;

  final List<Message>? pinnedMessages;

  const ChannelState(
      {this.channel,
      this.messages,
      this.members,
      this.read,
      this.pinnedMessages});

  factory ChannelState.fromJson(Map<String, dynamic> json) =>
      _$ChannelStateFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelStateToJson(this);

  @override
  List<Object?> get props => [
        channel,
        messages,
        read,
        pinnedMessages,
      ];

  ChannelState copyWith({
    ChannelModel? channel,
    List<Message>? messages,
    List<Member>? members,
    List<Message>? pinnedMessages,
    List<Read>? read,
  }) =>
      ChannelState(
        channel: channel ?? this.channel,
        messages: messages ?? this.messages,
        members: members ?? this.members,
        read: read ?? this.read,
        pinnedMessages: pinnedMessages ?? this.pinnedMessages,
      );
}
