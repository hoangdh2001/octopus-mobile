// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_message_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewMessageEvent {
  User get user => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) selectedUsers,
    required TResult Function(User user) removeUsers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(User user)? selectedUsers,
    TResult? Function(User user)? removeUsers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? selectedUsers,
    TResult Function(User user)? removeUsers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedUsers value) selectedUsers,
    required TResult Function(RemoveUsers value) removeUsers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedUsers value)? selectedUsers,
    TResult? Function(RemoveUsers value)? removeUsers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedUsers value)? selectedUsers,
    TResult Function(RemoveUsers value)? removeUsers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewMessageEventCopyWith<NewMessageEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewMessageEventCopyWith<$Res> {
  factory $NewMessageEventCopyWith(
          NewMessageEvent value, $Res Function(NewMessageEvent) then) =
      _$NewMessageEventCopyWithImpl<$Res, NewMessageEvent>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class _$NewMessageEventCopyWithImpl<$Res, $Val extends NewMessageEvent>
    implements $NewMessageEventCopyWith<$Res> {
  _$NewMessageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectedUsersCopyWith<$Res>
    implements $NewMessageEventCopyWith<$Res> {
  factory _$$SelectedUsersCopyWith(
          _$SelectedUsers value, $Res Function(_$SelectedUsers) then) =
      __$$SelectedUsersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$SelectedUsersCopyWithImpl<$Res>
    extends _$NewMessageEventCopyWithImpl<$Res, _$SelectedUsers>
    implements _$$SelectedUsersCopyWith<$Res> {
  __$$SelectedUsersCopyWithImpl(
      _$SelectedUsers _value, $Res Function(_$SelectedUsers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SelectedUsers(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$SelectedUsers implements SelectedUsers {
  const _$SelectedUsers(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'NewMessageEvent.selectedUsers(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedUsers &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedUsersCopyWith<_$SelectedUsers> get copyWith =>
      __$$SelectedUsersCopyWithImpl<_$SelectedUsers>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) selectedUsers,
    required TResult Function(User user) removeUsers,
  }) {
    return selectedUsers(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(User user)? selectedUsers,
    TResult? Function(User user)? removeUsers,
  }) {
    return selectedUsers?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? selectedUsers,
    TResult Function(User user)? removeUsers,
    required TResult orElse(),
  }) {
    if (selectedUsers != null) {
      return selectedUsers(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedUsers value) selectedUsers,
    required TResult Function(RemoveUsers value) removeUsers,
  }) {
    return selectedUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedUsers value)? selectedUsers,
    TResult? Function(RemoveUsers value)? removeUsers,
  }) {
    return selectedUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedUsers value)? selectedUsers,
    TResult Function(RemoveUsers value)? removeUsers,
    required TResult orElse(),
  }) {
    if (selectedUsers != null) {
      return selectedUsers(this);
    }
    return orElse();
  }
}

abstract class SelectedUsers implements NewMessageEvent {
  const factory SelectedUsers(final User user) = _$SelectedUsers;

  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$SelectedUsersCopyWith<_$SelectedUsers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveUsersCopyWith<$Res>
    implements $NewMessageEventCopyWith<$Res> {
  factory _$$RemoveUsersCopyWith(
          _$RemoveUsers value, $Res Function(_$RemoveUsers) then) =
      __$$RemoveUsersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$RemoveUsersCopyWithImpl<$Res>
    extends _$NewMessageEventCopyWithImpl<$Res, _$RemoveUsers>
    implements _$$RemoveUsersCopyWith<$Res> {
  __$$RemoveUsersCopyWithImpl(
      _$RemoveUsers _value, $Res Function(_$RemoveUsers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$RemoveUsers(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$RemoveUsers implements RemoveUsers {
  const _$RemoveUsers(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'NewMessageEvent.removeUsers(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveUsers &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveUsersCopyWith<_$RemoveUsers> get copyWith =>
      __$$RemoveUsersCopyWithImpl<_$RemoveUsers>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(User user) selectedUsers,
    required TResult Function(User user) removeUsers,
  }) {
    return removeUsers(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(User user)? selectedUsers,
    TResult? Function(User user)? removeUsers,
  }) {
    return removeUsers?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(User user)? selectedUsers,
    TResult Function(User user)? removeUsers,
    required TResult orElse(),
  }) {
    if (removeUsers != null) {
      return removeUsers(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedUsers value) selectedUsers,
    required TResult Function(RemoveUsers value) removeUsers,
  }) {
    return removeUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedUsers value)? selectedUsers,
    TResult? Function(RemoveUsers value)? removeUsers,
  }) {
    return removeUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedUsers value)? selectedUsers,
    TResult Function(RemoveUsers value)? removeUsers,
    required TResult orElse(),
  }) {
    if (removeUsers != null) {
      return removeUsers(this);
    }
    return orElse();
  }
}

abstract class RemoveUsers implements NewMessageEvent {
  const factory RemoveUsers(final User user) = _$RemoveUsers;

  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$RemoveUsersCopyWith<_$RemoveUsers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewMessageState {
  Set<User> get selectedUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewMessageStateCopyWith<NewMessageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewMessageStateCopyWith<$Res> {
  factory $NewMessageStateCopyWith(
          NewMessageState value, $Res Function(NewMessageState) then) =
      _$NewMessageStateCopyWithImpl<$Res, NewMessageState>;
  @useResult
  $Res call({Set<User> selectedUser});
}

/// @nodoc
class _$NewMessageStateCopyWithImpl<$Res, $Val extends NewMessageState>
    implements $NewMessageStateCopyWith<$Res> {
  _$NewMessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
  }) {
    return _then(_value.copyWith(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as Set<User>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewMessageStateCopyWith<$Res>
    implements $NewMessageStateCopyWith<$Res> {
  factory _$$_NewMessageStateCopyWith(
          _$_NewMessageState value, $Res Function(_$_NewMessageState) then) =
      __$$_NewMessageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<User> selectedUser});
}

/// @nodoc
class __$$_NewMessageStateCopyWithImpl<$Res>
    extends _$NewMessageStateCopyWithImpl<$Res, _$_NewMessageState>
    implements _$$_NewMessageStateCopyWith<$Res> {
  __$$_NewMessageStateCopyWithImpl(
      _$_NewMessageState _value, $Res Function(_$_NewMessageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
  }) {
    return _then(_$_NewMessageState(
      selectedUser: null == selectedUser
          ? _value._selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as Set<User>,
    ));
  }
}

/// @nodoc

class _$_NewMessageState implements _NewMessageState {
  const _$_NewMessageState({required final Set<User> selectedUser})
      : _selectedUser = selectedUser;

  final Set<User> _selectedUser;
  @override
  Set<User> get selectedUser {
    if (_selectedUser is EqualUnmodifiableSetView) return _selectedUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedUser);
  }

  @override
  String toString() {
    return 'NewMessageState(selectedUser: $selectedUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewMessageState &&
            const DeepCollectionEquality()
                .equals(other._selectedUser, _selectedUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_selectedUser));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewMessageStateCopyWith<_$_NewMessageState> get copyWith =>
      __$$_NewMessageStateCopyWithImpl<_$_NewMessageState>(this, _$identity);
}

abstract class _NewMessageState implements NewMessageState {
  const factory _NewMessageState({required final Set<User> selectedUser}) =
      _$_NewMessageState;

  @override
  Set<User> get selectedUser;
  @override
  @JsonKey(ignore: true)
  _$$_NewMessageStateCopyWith<_$_NewMessageState> get copyWith =>
      throw _privateConstructorUsedError;
}
