// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_group_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewGroupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String groupName) changedGroupName,
    required TResult Function(User user) addUser,
    required TResult Function(User user) removeUser,
    required TResult Function() newGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String groupName)? changedGroupName,
    TResult? Function(User user)? addUser,
    TResult? Function(User user)? removeUser,
    TResult? Function()? newGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String groupName)? changedGroupName,
    TResult Function(User user)? addUser,
    TResult Function(User user)? removeUser,
    TResult Function()? newGroup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangedGroupName value) changedGroupName,
    required TResult Function(AddUser value) addUser,
    required TResult Function(RemoveUser value) removeUser,
    required TResult Function(NewGroup value) newGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangedGroupName value)? changedGroupName,
    TResult? Function(AddUser value)? addUser,
    TResult? Function(RemoveUser value)? removeUser,
    TResult? Function(NewGroup value)? newGroup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangedGroupName value)? changedGroupName,
    TResult Function(AddUser value)? addUser,
    TResult Function(RemoveUser value)? removeUser,
    TResult Function(NewGroup value)? newGroup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewGroupEventCopyWith<$Res> {
  factory $NewGroupEventCopyWith(
          NewGroupEvent value, $Res Function(NewGroupEvent) then) =
      _$NewGroupEventCopyWithImpl<$Res, NewGroupEvent>;
}

/// @nodoc
class _$NewGroupEventCopyWithImpl<$Res, $Val extends NewGroupEvent>
    implements $NewGroupEventCopyWith<$Res> {
  _$NewGroupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChangedGroupNameCopyWith<$Res> {
  factory _$$ChangedGroupNameCopyWith(
          _$ChangedGroupName value, $Res Function(_$ChangedGroupName) then) =
      __$$ChangedGroupNameCopyWithImpl<$Res>;
  @useResult
  $Res call({String groupName});
}

/// @nodoc
class __$$ChangedGroupNameCopyWithImpl<$Res>
    extends _$NewGroupEventCopyWithImpl<$Res, _$ChangedGroupName>
    implements _$$ChangedGroupNameCopyWith<$Res> {
  __$$ChangedGroupNameCopyWithImpl(
      _$ChangedGroupName _value, $Res Function(_$ChangedGroupName) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
  }) {
    return _then(_$ChangedGroupName(
      null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangedGroupName implements ChangedGroupName {
  const _$ChangedGroupName(this.groupName);

  @override
  final String groupName;

  @override
  String toString() {
    return 'NewGroupEvent.changedGroupName(groupName: $groupName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangedGroupName &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangedGroupNameCopyWith<_$ChangedGroupName> get copyWith =>
      __$$ChangedGroupNameCopyWithImpl<_$ChangedGroupName>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String groupName) changedGroupName,
    required TResult Function(User user) addUser,
    required TResult Function(User user) removeUser,
    required TResult Function() newGroup,
  }) {
    return changedGroupName(groupName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String groupName)? changedGroupName,
    TResult? Function(User user)? addUser,
    TResult? Function(User user)? removeUser,
    TResult? Function()? newGroup,
  }) {
    return changedGroupName?.call(groupName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String groupName)? changedGroupName,
    TResult Function(User user)? addUser,
    TResult Function(User user)? removeUser,
    TResult Function()? newGroup,
    required TResult orElse(),
  }) {
    if (changedGroupName != null) {
      return changedGroupName(groupName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangedGroupName value) changedGroupName,
    required TResult Function(AddUser value) addUser,
    required TResult Function(RemoveUser value) removeUser,
    required TResult Function(NewGroup value) newGroup,
  }) {
    return changedGroupName(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangedGroupName value)? changedGroupName,
    TResult? Function(AddUser value)? addUser,
    TResult? Function(RemoveUser value)? removeUser,
    TResult? Function(NewGroup value)? newGroup,
  }) {
    return changedGroupName?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangedGroupName value)? changedGroupName,
    TResult Function(AddUser value)? addUser,
    TResult Function(RemoveUser value)? removeUser,
    TResult Function(NewGroup value)? newGroup,
    required TResult orElse(),
  }) {
    if (changedGroupName != null) {
      return changedGroupName(this);
    }
    return orElse();
  }
}

abstract class ChangedGroupName implements NewGroupEvent {
  const factory ChangedGroupName(final String groupName) = _$ChangedGroupName;

  String get groupName;
  @JsonKey(ignore: true)
  _$$ChangedGroupNameCopyWith<_$ChangedGroupName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddUserCopyWith<$Res> {
  factory _$$AddUserCopyWith(_$AddUser value, $Res Function(_$AddUser) then) =
      __$$AddUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$AddUserCopyWithImpl<$Res>
    extends _$NewGroupEventCopyWithImpl<$Res, _$AddUser>
    implements _$$AddUserCopyWith<$Res> {
  __$$AddUserCopyWithImpl(_$AddUser _value, $Res Function(_$AddUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AddUser(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$AddUser implements AddUser {
  const _$AddUser(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'NewGroupEvent.addUser(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUser &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddUserCopyWith<_$AddUser> get copyWith =>
      __$$AddUserCopyWithImpl<_$AddUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String groupName) changedGroupName,
    required TResult Function(User user) addUser,
    required TResult Function(User user) removeUser,
    required TResult Function() newGroup,
  }) {
    return addUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String groupName)? changedGroupName,
    TResult? Function(User user)? addUser,
    TResult? Function(User user)? removeUser,
    TResult? Function()? newGroup,
  }) {
    return addUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String groupName)? changedGroupName,
    TResult Function(User user)? addUser,
    TResult Function(User user)? removeUser,
    TResult Function()? newGroup,
    required TResult orElse(),
  }) {
    if (addUser != null) {
      return addUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangedGroupName value) changedGroupName,
    required TResult Function(AddUser value) addUser,
    required TResult Function(RemoveUser value) removeUser,
    required TResult Function(NewGroup value) newGroup,
  }) {
    return addUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangedGroupName value)? changedGroupName,
    TResult? Function(AddUser value)? addUser,
    TResult? Function(RemoveUser value)? removeUser,
    TResult? Function(NewGroup value)? newGroup,
  }) {
    return addUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangedGroupName value)? changedGroupName,
    TResult Function(AddUser value)? addUser,
    TResult Function(RemoveUser value)? removeUser,
    TResult Function(NewGroup value)? newGroup,
    required TResult orElse(),
  }) {
    if (addUser != null) {
      return addUser(this);
    }
    return orElse();
  }
}

abstract class AddUser implements NewGroupEvent {
  const factory AddUser(final User user) = _$AddUser;

  User get user;
  @JsonKey(ignore: true)
  _$$AddUserCopyWith<_$AddUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveUserCopyWith<$Res> {
  factory _$$RemoveUserCopyWith(
          _$RemoveUser value, $Res Function(_$RemoveUser) then) =
      __$$RemoveUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$RemoveUserCopyWithImpl<$Res>
    extends _$NewGroupEventCopyWithImpl<$Res, _$RemoveUser>
    implements _$$RemoveUserCopyWith<$Res> {
  __$$RemoveUserCopyWithImpl(
      _$RemoveUser _value, $Res Function(_$RemoveUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$RemoveUser(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$RemoveUser implements RemoveUser {
  const _$RemoveUser(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'NewGroupEvent.removeUser(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveUser &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveUserCopyWith<_$RemoveUser> get copyWith =>
      __$$RemoveUserCopyWithImpl<_$RemoveUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String groupName) changedGroupName,
    required TResult Function(User user) addUser,
    required TResult Function(User user) removeUser,
    required TResult Function() newGroup,
  }) {
    return removeUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String groupName)? changedGroupName,
    TResult? Function(User user)? addUser,
    TResult? Function(User user)? removeUser,
    TResult? Function()? newGroup,
  }) {
    return removeUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String groupName)? changedGroupName,
    TResult Function(User user)? addUser,
    TResult Function(User user)? removeUser,
    TResult Function()? newGroup,
    required TResult orElse(),
  }) {
    if (removeUser != null) {
      return removeUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangedGroupName value) changedGroupName,
    required TResult Function(AddUser value) addUser,
    required TResult Function(RemoveUser value) removeUser,
    required TResult Function(NewGroup value) newGroup,
  }) {
    return removeUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangedGroupName value)? changedGroupName,
    TResult? Function(AddUser value)? addUser,
    TResult? Function(RemoveUser value)? removeUser,
    TResult? Function(NewGroup value)? newGroup,
  }) {
    return removeUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangedGroupName value)? changedGroupName,
    TResult Function(AddUser value)? addUser,
    TResult Function(RemoveUser value)? removeUser,
    TResult Function(NewGroup value)? newGroup,
    required TResult orElse(),
  }) {
    if (removeUser != null) {
      return removeUser(this);
    }
    return orElse();
  }
}

abstract class RemoveUser implements NewGroupEvent {
  const factory RemoveUser(final User user) = _$RemoveUser;

  User get user;
  @JsonKey(ignore: true)
  _$$RemoveUserCopyWith<_$RemoveUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewGroupCopyWith<$Res> {
  factory _$$NewGroupCopyWith(
          _$NewGroup value, $Res Function(_$NewGroup) then) =
      __$$NewGroupCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewGroupCopyWithImpl<$Res>
    extends _$NewGroupEventCopyWithImpl<$Res, _$NewGroup>
    implements _$$NewGroupCopyWith<$Res> {
  __$$NewGroupCopyWithImpl(_$NewGroup _value, $Res Function(_$NewGroup) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NewGroup implements NewGroup {
  const _$NewGroup();

  @override
  String toString() {
    return 'NewGroupEvent.newGroup()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewGroup);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String groupName) changedGroupName,
    required TResult Function(User user) addUser,
    required TResult Function(User user) removeUser,
    required TResult Function() newGroup,
  }) {
    return newGroup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String groupName)? changedGroupName,
    TResult? Function(User user)? addUser,
    TResult? Function(User user)? removeUser,
    TResult? Function()? newGroup,
  }) {
    return newGroup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String groupName)? changedGroupName,
    TResult Function(User user)? addUser,
    TResult Function(User user)? removeUser,
    TResult Function()? newGroup,
    required TResult orElse(),
  }) {
    if (newGroup != null) {
      return newGroup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangedGroupName value) changedGroupName,
    required TResult Function(AddUser value) addUser,
    required TResult Function(RemoveUser value) removeUser,
    required TResult Function(NewGroup value) newGroup,
  }) {
    return newGroup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangedGroupName value)? changedGroupName,
    TResult? Function(AddUser value)? addUser,
    TResult? Function(RemoveUser value)? removeUser,
    TResult? Function(NewGroup value)? newGroup,
  }) {
    return newGroup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangedGroupName value)? changedGroupName,
    TResult Function(AddUser value)? addUser,
    TResult Function(RemoveUser value)? removeUser,
    TResult Function(NewGroup value)? newGroup,
    required TResult orElse(),
  }) {
    if (newGroup != null) {
      return newGroup(this);
    }
    return orElse();
  }
}

abstract class NewGroup implements NewGroupEvent {
  const factory NewGroup() = _$NewGroup;
}

/// @nodoc
mixin _$NewGroupState {
  String get name => throw _privateConstructorUsedError;
  Set<User> get users => throw _privateConstructorUsedError;
  Option<Either<ChannelState, Error>> get successOrFail =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewGroupStateCopyWith<NewGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewGroupStateCopyWith<$Res> {
  factory $NewGroupStateCopyWith(
          NewGroupState value, $Res Function(NewGroupState) then) =
      _$NewGroupStateCopyWithImpl<$Res, NewGroupState>;
  @useResult
  $Res call(
      {String name,
      Set<User> users,
      Option<Either<ChannelState, Error>> successOrFail});
}

/// @nodoc
class _$NewGroupStateCopyWithImpl<$Res, $Val extends NewGroupState>
    implements $NewGroupStateCopyWith<$Res> {
  _$NewGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? users = null,
    Object? successOrFail = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as Set<User>,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<ChannelState, Error>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewGroupStateCopyWith<$Res>
    implements $NewGroupStateCopyWith<$Res> {
  factory _$$_NewGroupStateCopyWith(
          _$_NewGroupState value, $Res Function(_$_NewGroupState) then) =
      __$$_NewGroupStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Set<User> users,
      Option<Either<ChannelState, Error>> successOrFail});
}

/// @nodoc
class __$$_NewGroupStateCopyWithImpl<$Res>
    extends _$NewGroupStateCopyWithImpl<$Res, _$_NewGroupState>
    implements _$$_NewGroupStateCopyWith<$Res> {
  __$$_NewGroupStateCopyWithImpl(
      _$_NewGroupState _value, $Res Function(_$_NewGroupState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? users = null,
    Object? successOrFail = null,
  }) {
    return _then(_$_NewGroupState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as Set<User>,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<ChannelState, Error>>,
    ));
  }
}

/// @nodoc

class _$_NewGroupState implements _NewGroupState {
  const _$_NewGroupState(
      {required this.name,
      required final Set<User> users,
      required this.successOrFail})
      : _users = users;

  @override
  final String name;
  final Set<User> _users;
  @override
  Set<User> get users {
    if (_users is EqualUnmodifiableSetView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_users);
  }

  @override
  final Option<Either<ChannelState, Error>> successOrFail;

  @override
  String toString() {
    return 'NewGroupState(name: $name, users: $users, successOrFail: $successOrFail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewGroupState &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.successOrFail, successOrFail) ||
                other.successOrFail == successOrFail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_users), successOrFail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewGroupStateCopyWith<_$_NewGroupState> get copyWith =>
      __$$_NewGroupStateCopyWithImpl<_$_NewGroupState>(this, _$identity);
}

abstract class _NewGroupState implements NewGroupState {
  const factory _NewGroupState(
          {required final String name,
          required final Set<User> users,
          required final Option<Either<ChannelState, Error>> successOrFail}) =
      _$_NewGroupState;

  @override
  String get name;
  @override
  Set<User> get users;
  @override
  Option<Either<ChannelState, Error>> get successOrFail;
  @override
  @JsonKey(ignore: true)
  _$$_NewGroupStateCopyWith<_$_NewGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}
