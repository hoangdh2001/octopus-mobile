import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue('SYSTEM_NOTIFICATION')
  systemNotification,
  @JsonValue('SYSTEM_ADDED_MEMBER')
  systemAddMember,
  @JsonValue('SYSTEM_MEMBER_LEFT')
  systemMemberLeft,
  @JsonValue('SYSTEM_REMOVED_MEMBER')
  systemRemovedMember,
  @JsonValue('SYSTEM_CREATED_CHANNEL')
  systemCreatedChannel,
  @JsonValue('SYSTEM_CHANGED_NAME')
  systemChangedName,
  @JsonValue('SYSTEM_CHANGED_AVATAR')
  systemChangedAvatar,
  @JsonValue('NORMAL')
  normal,
  @JsonValue('DELETED')
  deleted;
}
