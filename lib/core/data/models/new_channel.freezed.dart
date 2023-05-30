// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewChannel _$NewChannelFromJson(Map<String, dynamic> json) {
  return _NewChannel.fromJson(json);
}

/// @nodoc
mixin _$NewChannel {
  List<String> get newMembers => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewChannelCopyWith<NewChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewChannelCopyWith<$Res> {
  factory $NewChannelCopyWith(
          NewChannel value, $Res Function(NewChannel) then) =
      _$NewChannelCopyWithImpl<$Res, NewChannel>;
  @useResult
  $Res call({List<String> newMembers, String? name, String? userID});
}

/// @nodoc
class _$NewChannelCopyWithImpl<$Res, $Val extends NewChannel>
    implements $NewChannelCopyWith<$Res> {
  _$NewChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newMembers = null,
    Object? name = freezed,
    Object? userID = freezed,
  }) {
    return _then(_value.copyWith(
      newMembers: null == newMembers
          ? _value.newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewChannelCopyWith<$Res>
    implements $NewChannelCopyWith<$Res> {
  factory _$$_NewChannelCopyWith(
          _$_NewChannel value, $Res Function(_$_NewChannel) then) =
      __$$_NewChannelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> newMembers, String? name, String? userID});
}

/// @nodoc
class __$$_NewChannelCopyWithImpl<$Res>
    extends _$NewChannelCopyWithImpl<$Res, _$_NewChannel>
    implements _$$_NewChannelCopyWith<$Res> {
  __$$_NewChannelCopyWithImpl(
      _$_NewChannel _value, $Res Function(_$_NewChannel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newMembers = null,
    Object? name = freezed,
    Object? userID = freezed,
  }) {
    return _then(_$_NewChannel(
      newMembers: null == newMembers
          ? _value._newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewChannel implements _NewChannel {
  const _$_NewChannel(
      {required final List<String> newMembers, this.name, this.userID})
      : _newMembers = newMembers;

  factory _$_NewChannel.fromJson(Map<String, dynamic> json) =>
      _$$_NewChannelFromJson(json);

  final List<String> _newMembers;
  @override
  List<String> get newMembers {
    if (_newMembers is EqualUnmodifiableListView) return _newMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newMembers);
  }

  @override
  final String? name;
  @override
  final String? userID;

  @override
  String toString() {
    return 'NewChannel(newMembers: $newMembers, name: $name, userID: $userID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewChannel &&
            const DeepCollectionEquality()
                .equals(other._newMembers, _newMembers) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_newMembers), name, userID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewChannelCopyWith<_$_NewChannel> get copyWith =>
      __$$_NewChannelCopyWithImpl<_$_NewChannel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewChannelToJson(
      this,
    );
  }
}

abstract class _NewChannel implements NewChannel {
  const factory _NewChannel(
      {required final List<String> newMembers,
      final String? name,
      final String? userID}) = _$_NewChannel;

  factory _NewChannel.fromJson(Map<String, dynamic> json) =
      _$_NewChannel.fromJson;

  @override
  List<String> get newMembers;
  @override
  String? get name;
  @override
  String? get userID;
  @override
  @JsonKey(ignore: true)
  _$$_NewChannelCopyWith<_$_NewChannel> get copyWith =>
      throw _privateConstructorUsedError;
}
