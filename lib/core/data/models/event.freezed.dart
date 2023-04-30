// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get type => throw _privateConstructorUsedError;
  ChannelState? get channel => throw _privateConstructorUsedError;
  String? get channelID => throw _privateConstructorUsedError;
  Message? get message => throw _privateConstructorUsedError;
  String? get connectionID => throw _privateConstructorUsedError;
  OwnUser? get me => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String type,
      ChannelState? channel,
      String? channelID,
      Message? message,
      String? connectionID,
      OwnUser? me});

  $ChannelStateCopyWith<$Res>? get channel;
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? channel = freezed,
    Object? channelID = freezed,
    Object? message = freezed,
    Object? connectionID = freezed,
    Object? me = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ChannelState?,
      channelID: freezed == channelID
          ? _value.channelID
          : channelID // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      connectionID: freezed == connectionID
          ? _value.connectionID
          : connectionID // ignore: cast_nullable_to_non_nullable
              as String?,
      me: freezed == me
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as OwnUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChannelStateCopyWith<$Res>? get channel {
    if (_value.channel == null) {
      return null;
    }

    return $ChannelStateCopyWith<$Res>(_value.channel!, (value) {
      return _then(_value.copyWith(channel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      ChannelState? channel,
      String? channelID,
      Message? message,
      String? connectionID,
      OwnUser? me});

  @override
  $ChannelStateCopyWith<$Res>? get channel;
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? channel = freezed,
    Object? channelID = freezed,
    Object? message = freezed,
    Object? connectionID = freezed,
    Object? me = freezed,
  }) {
    return _then(_$_Event(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ChannelState?,
      channelID: freezed == channelID
          ? _value.channelID
          : channelID // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      connectionID: freezed == connectionID
          ? _value.connectionID
          : connectionID // ignore: cast_nullable_to_non_nullable
              as String?,
      me: freezed == me
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as OwnUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  _$_Event(
      {this.type = 'local.event',
      this.channel,
      this.channelID,
      this.message,
      this.connectionID,
      this.me});

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  final ChannelState? channel;
  @override
  final String? channelID;
  @override
  final Message? message;
  @override
  final String? connectionID;
  @override
  final OwnUser? me;

  @override
  String toString() {
    return 'Event(type: $type, channel: $channel, channelID: $channelID, message: $message, connectionID: $connectionID, me: $me)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.channelID, channelID) ||
                other.channelID == channelID) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.connectionID, connectionID) ||
                other.connectionID == connectionID) &&
            (identical(other.me, me) || other.me == me));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, channel, channelID, message, connectionID, me);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  factory _Event(
      {final String type,
      final ChannelState? channel,
      final String? channelID,
      final Message? message,
      final String? connectionID,
      final OwnUser? me}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get type;
  @override
  ChannelState? get channel;
  @override
  String? get channelID;
  @override
  Message? get message;
  @override
  String? get connectionID;
  @override
  OwnUser? get me;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}
