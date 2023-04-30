// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) {
  return _ChannelModel.fromJson(json);
}

/// @nodoc
mixin _$ChannelModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'hiddenChannel')
  bool get hidden => throw _privateConstructorUsedError;
  bool get activeNotify => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelModelCopyWith<ChannelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelModelCopyWith<$Res> {
  factory $ChannelModelCopyWith(
          ChannelModel value, $Res Function(ChannelModel) then) =
      _$ChannelModelCopyWithImpl<$Res, ChannelModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? avatar,
      String? name,
      DateTime? lastMessageAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      @JsonKey(name: 'hiddenChannel') bool hidden,
      bool activeNotify});
}

/// @nodoc
class _$ChannelModelCopyWithImpl<$Res, $Val extends ChannelModel>
    implements $ChannelModelCopyWith<$Res> {
  _$ChannelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatar = freezed,
    Object? name = freezed,
    Object? lastMessageAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? hidden = null,
    Object? activeNotify = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      activeNotify: null == activeNotify
          ? _value.activeNotify
          : activeNotify // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChannelModelCopyWith<$Res>
    implements $ChannelModelCopyWith<$Res> {
  factory _$$_ChannelModelCopyWith(
          _$_ChannelModel value, $Res Function(_$_ChannelModel) then) =
      __$$_ChannelModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? avatar,
      String? name,
      DateTime? lastMessageAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      @JsonKey(name: 'hiddenChannel') bool hidden,
      bool activeNotify});
}

/// @nodoc
class __$$_ChannelModelCopyWithImpl<$Res>
    extends _$ChannelModelCopyWithImpl<$Res, _$_ChannelModel>
    implements _$$_ChannelModelCopyWith<$Res> {
  __$$_ChannelModelCopyWithImpl(
      _$_ChannelModel _value, $Res Function(_$_ChannelModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatar = freezed,
    Object? name = freezed,
    Object? lastMessageAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? hidden = null,
    Object? activeNotify = null,
  }) {
    return _then(_$_ChannelModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      activeNotify: null == activeNotify
          ? _value.activeNotify
          : activeNotify // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChannelModel implements _ChannelModel {
  const _$_ChannelModel(
      {@JsonKey(name: '_id') required this.id,
      this.avatar,
      this.name,
      this.lastMessageAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      @JsonKey(name: 'hiddenChannel') required this.hidden,
      required this.activeNotify});

  factory _$_ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChannelModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? avatar;
  @override
  final String? name;
  @override
  final DateTime? lastMessageAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  @JsonKey(name: 'hiddenChannel')
  final bool hidden;
  @override
  final bool activeNotify;

  @override
  String toString() {
    return 'ChannelModel(id: $id, avatar: $avatar, name: $name, lastMessageAt: $lastMessageAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, hidden: $hidden, activeNotify: $activeNotify)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChannelModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.activeNotify, activeNotify) ||
                other.activeNotify == activeNotify));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, avatar, name, lastMessageAt,
      createdAt, updatedAt, deletedAt, hidden, activeNotify);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChannelModelCopyWith<_$_ChannelModel> get copyWith =>
      __$$_ChannelModelCopyWithImpl<_$_ChannelModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChannelModelToJson(
      this,
    );
  }
}

abstract class _ChannelModel implements ChannelModel {
  const factory _ChannelModel(
      {@JsonKey(name: '_id') required final String id,
      final String? avatar,
      final String? name,
      final DateTime? lastMessageAt,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? deletedAt,
      @JsonKey(name: 'hiddenChannel') required final bool hidden,
      required final bool activeNotify}) = _$_ChannelModel;

  factory _ChannelModel.fromJson(Map<String, dynamic> json) =
      _$_ChannelModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get avatar;
  @override
  String? get name;
  @override
  DateTime? get lastMessageAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  @JsonKey(name: 'hiddenChannel')
  bool get hidden;
  @override
  bool get activeNotify;
  @override
  @JsonKey(ignore: true)
  _$$_ChannelModelCopyWith<_$_ChannelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ChannelState _$ChannelStateFromJson(Map<String, dynamic> json) {
  return _ChannelState.fromJson(json);
}

/// @nodoc
mixin _$ChannelState {
  ChannelModel? get channel => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  List<Member> get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelStateCopyWith<ChannelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelStateCopyWith<$Res> {
  factory $ChannelStateCopyWith(
          ChannelState value, $Res Function(ChannelState) then) =
      _$ChannelStateCopyWithImpl<$Res, ChannelState>;
  @useResult
  $Res call(
      {ChannelModel? channel, List<Message> messages, List<Member> members});

  $ChannelModelCopyWith<$Res>? get channel;
}

/// @nodoc
class _$ChannelStateCopyWithImpl<$Res, $Val extends ChannelState>
    implements $ChannelStateCopyWith<$Res> {
  _$ChannelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = freezed,
    Object? messages = null,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ChannelModel?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChannelModelCopyWith<$Res>? get channel {
    if (_value.channel == null) {
      return null;
    }

    return $ChannelModelCopyWith<$Res>(_value.channel!, (value) {
      return _then(_value.copyWith(channel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChannelStateCopyWith<$Res>
    implements $ChannelStateCopyWith<$Res> {
  factory _$$_ChannelStateCopyWith(
          _$_ChannelState value, $Res Function(_$_ChannelState) then) =
      __$$_ChannelStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ChannelModel? channel, List<Message> messages, List<Member> members});

  @override
  $ChannelModelCopyWith<$Res>? get channel;
}

/// @nodoc
class __$$_ChannelStateCopyWithImpl<$Res>
    extends _$ChannelStateCopyWithImpl<$Res, _$_ChannelState>
    implements _$$_ChannelStateCopyWith<$Res> {
  __$$_ChannelStateCopyWithImpl(
      _$_ChannelState _value, $Res Function(_$_ChannelState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channel = freezed,
    Object? messages = null,
    Object? members = null,
  }) {
    return _then(_$_ChannelState(
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as ChannelModel?,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChannelState implements _ChannelState {
  const _$_ChannelState(
      {this.channel,
      required final List<Message> messages,
      required final List<Member> members})
      : _messages = messages,
        _members = members;

  factory _$_ChannelState.fromJson(Map<String, dynamic> json) =>
      _$$_ChannelStateFromJson(json);

  @override
  final ChannelModel? channel;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<Member> _members;
  @override
  List<Member> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'ChannelState(channel: $channel, messages: $messages, members: $members)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChannelState &&
            (identical(other.channel, channel) || other.channel == channel) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      channel,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChannelStateCopyWith<_$_ChannelState> get copyWith =>
      __$$_ChannelStateCopyWithImpl<_$_ChannelState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChannelStateToJson(
      this,
    );
  }
}

abstract class _ChannelState implements ChannelState {
  const factory _ChannelState(
      {final ChannelModel? channel,
      required final List<Message> messages,
      required final List<Member> members}) = _$_ChannelState;

  factory _ChannelState.fromJson(Map<String, dynamic> json) =
      _$_ChannelState.fromJson;

  @override
  ChannelModel? get channel;
  @override
  List<Message> get messages;
  @override
  List<Member> get members;
  @override
  @JsonKey(ignore: true)
  _$$_ChannelStateCopyWith<_$_ChannelState> get copyWith =>
      throw _privateConstructorUsedError;
}
