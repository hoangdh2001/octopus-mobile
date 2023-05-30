// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChannelQuery _$ChannelQueryFromJson(Map<String, dynamic> json) {
  return _ChannelQuery.fromJson(json);
}

/// @nodoc
mixin _$ChannelQuery {
  PaginationParams? get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelQueryCopyWith<ChannelQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelQueryCopyWith<$Res> {
  factory $ChannelQueryCopyWith(
          ChannelQuery value, $Res Function(ChannelQuery) then) =
      _$ChannelQueryCopyWithImpl<$Res, ChannelQuery>;
  @useResult
  $Res call({PaginationParams? messages});
}

/// @nodoc
class _$ChannelQueryCopyWithImpl<$Res, $Val extends ChannelQuery>
    implements $ChannelQueryCopyWith<$Res> {
  _$ChannelQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as PaginationParams?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChannelQueryCopyWith<$Res>
    implements $ChannelQueryCopyWith<$Res> {
  factory _$$_ChannelQueryCopyWith(
          _$_ChannelQuery value, $Res Function(_$_ChannelQuery) then) =
      __$$_ChannelQueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PaginationParams? messages});
}

/// @nodoc
class __$$_ChannelQueryCopyWithImpl<$Res>
    extends _$ChannelQueryCopyWithImpl<$Res, _$_ChannelQuery>
    implements _$$_ChannelQueryCopyWith<$Res> {
  __$$_ChannelQueryCopyWithImpl(
      _$_ChannelQuery _value, $Res Function(_$_ChannelQuery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = freezed,
  }) {
    return _then(_$_ChannelQuery(
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as PaginationParams?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChannelQuery implements _ChannelQuery {
  _$_ChannelQuery({this.messages});

  factory _$_ChannelQuery.fromJson(Map<String, dynamic> json) =>
      _$$_ChannelQueryFromJson(json);

  @override
  final PaginationParams? messages;

  @override
  String toString() {
    return 'ChannelQuery(messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChannelQuery &&
            (identical(other.messages, messages) ||
                other.messages == messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, messages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChannelQueryCopyWith<_$_ChannelQuery> get copyWith =>
      __$$_ChannelQueryCopyWithImpl<_$_ChannelQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChannelQueryToJson(
      this,
    );
  }
}

abstract class _ChannelQuery implements ChannelQuery {
  factory _ChannelQuery({final PaginationParams? messages}) = _$_ChannelQuery;

  factory _ChannelQuery.fromJson(Map<String, dynamic> json) =
      _$_ChannelQuery.fromJson;

  @override
  PaginationParams? get messages;
  @override
  @JsonKey(ignore: true)
  _$$_ChannelQueryCopyWith<_$_ChannelQuery> get copyWith =>
      throw _privateConstructorUsedError;
}
