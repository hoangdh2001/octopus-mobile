// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_project_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateProjectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProjectEventCopyWith<$Res> {
  factory $CreateProjectEventCopyWith(
          CreateProjectEvent value, $Res Function(CreateProjectEvent) then) =
      _$CreateProjectEventCopyWithImpl<$Res, CreateProjectEvent>;
}

/// @nodoc
class _$CreateProjectEventCopyWithImpl<$Res, $Val extends CreateProjectEvent>
    implements $CreateProjectEventCopyWith<$Res> {
  _$CreateProjectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NameChangedCopyWith<$Res> {
  factory _$$NameChangedCopyWith(
          _$NameChanged value, $Res Function(_$NameChanged) then) =
      __$$NameChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NameChangedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res, _$NameChanged>
    implements _$$NameChangedCopyWith<$Res> {
  __$$NameChangedCopyWithImpl(
      _$NameChanged _value, $Res Function(_$NameChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NameChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NameChanged implements NameChanged {
  const _$NameChanged(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'CreateProjectEvent.nameChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NameChangedCopyWith<_$NameChanged> get copyWith =>
      __$$NameChangedCopyWithImpl<_$NameChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return nameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return nameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (nameChanged != null) {
      return nameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return nameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return nameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (nameChanged != null) {
      return nameChanged(this);
    }
    return orElse();
  }
}

abstract class NameChanged implements CreateProjectEvent {
  const factory NameChanged(final String name) = _$NameChanged;

  String get name;
  @JsonKey(ignore: true)
  _$$NameChangedCopyWith<_$NameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusChangedCopyWith<$Res> {
  factory _$$StatusChangedCopyWith(
          _$StatusChanged value, $Res Function(_$StatusChanged) then) =
      __$$StatusChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TaskStatus> statusList});
}

/// @nodoc
class __$$StatusChangedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res, _$StatusChanged>
    implements _$$StatusChangedCopyWith<$Res> {
  __$$StatusChangedCopyWithImpl(
      _$StatusChanged _value, $Res Function(_$StatusChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusList = null,
  }) {
    return _then(_$StatusChanged(
      null == statusList
          ? _value._statusList
          : statusList // ignore: cast_nullable_to_non_nullable
              as List<TaskStatus>,
    ));
  }
}

/// @nodoc

class _$StatusChanged implements StatusChanged {
  const _$StatusChanged(final List<TaskStatus> statusList)
      : _statusList = statusList;

  final List<TaskStatus> _statusList;
  @override
  List<TaskStatus> get statusList {
    if (_statusList is EqualUnmodifiableListView) return _statusList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusList);
  }

  @override
  String toString() {
    return 'CreateProjectEvent.statusChanged(statusList: $statusList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusChanged &&
            const DeepCollectionEquality()
                .equals(other._statusList, _statusList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_statusList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusChangedCopyWith<_$StatusChanged> get copyWith =>
      __$$StatusChangedCopyWithImpl<_$StatusChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return statusChanged(statusList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return statusChanged?.call(statusList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(statusList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(this);
    }
    return orElse();
  }
}

abstract class StatusChanged implements CreateProjectEvent {
  const factory StatusChanged(final List<TaskStatus> statusList) =
      _$StatusChanged;

  List<TaskStatus> get statusList;
  @JsonKey(ignore: true)
  _$$StatusChangedCopyWith<_$StatusChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsersChangedCopyWith<$Res> {
  factory _$$UsersChangedCopyWith(
          _$UsersChanged value, $Res Function(_$UsersChanged) then) =
      __$$UsersChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<User> users});
}

/// @nodoc
class __$$UsersChangedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res, _$UsersChanged>
    implements _$$UsersChangedCopyWith<$Res> {
  __$$UsersChangedCopyWithImpl(
      _$UsersChanged _value, $Res Function(_$UsersChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_$UsersChanged(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc

class _$UsersChanged implements UsersChanged {
  const _$UsersChanged(final List<User> users) : _users = users;

  final List<User> _users;
  @override
  List<User> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'CreateProjectEvent.usersChanged(users: $users)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersChanged &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersChangedCopyWith<_$UsersChanged> get copyWith =>
      __$$UsersChangedCopyWithImpl<_$UsersChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return usersChanged(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return usersChanged?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (usersChanged != null) {
      return usersChanged(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return usersChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return usersChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (usersChanged != null) {
      return usersChanged(this);
    }
    return orElse();
  }
}

abstract class UsersChanged implements CreateProjectEvent {
  const factory UsersChanged(final List<User> users) = _$UsersChanged;

  List<User> get users;
  @JsonKey(ignore: true)
  _$$UsersChangedCopyWith<_$UsersChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WorkspaceAccessChangedCopyWith<$Res> {
  factory _$$WorkspaceAccessChangedCopyWith(_$WorkspaceAccessChanged value,
          $Res Function(_$WorkspaceAccessChanged) then) =
      __$$WorkspaceAccessChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool workspaceAccess});
}

/// @nodoc
class __$$WorkspaceAccessChangedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res, _$WorkspaceAccessChanged>
    implements _$$WorkspaceAccessChangedCopyWith<$Res> {
  __$$WorkspaceAccessChangedCopyWithImpl(_$WorkspaceAccessChanged _value,
      $Res Function(_$WorkspaceAccessChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaceAccess = null,
  }) {
    return _then(_$WorkspaceAccessChanged(
      null == workspaceAccess
          ? _value.workspaceAccess
          : workspaceAccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WorkspaceAccessChanged implements WorkspaceAccessChanged {
  const _$WorkspaceAccessChanged(this.workspaceAccess);

  @override
  final bool workspaceAccess;

  @override
  String toString() {
    return 'CreateProjectEvent.workspaceAccessChanged(workspaceAccess: $workspaceAccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceAccessChanged &&
            (identical(other.workspaceAccess, workspaceAccess) ||
                other.workspaceAccess == workspaceAccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, workspaceAccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceAccessChangedCopyWith<_$WorkspaceAccessChanged> get copyWith =>
      __$$WorkspaceAccessChangedCopyWithImpl<_$WorkspaceAccessChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return workspaceAccessChanged(workspaceAccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return workspaceAccessChanged?.call(workspaceAccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (workspaceAccessChanged != null) {
      return workspaceAccessChanged(workspaceAccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return workspaceAccessChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return workspaceAccessChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (workspaceAccessChanged != null) {
      return workspaceAccessChanged(this);
    }
    return orElse();
  }
}

abstract class WorkspaceAccessChanged implements CreateProjectEvent {
  const factory WorkspaceAccessChanged(final bool workspaceAccess) =
      _$WorkspaceAccessChanged;

  bool get workspaceAccess;
  @JsonKey(ignore: true)
  _$$WorkspaceAccessChangedCopyWith<_$WorkspaceAccessChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateChannelForProjectChangedCopyWith<$Res> {
  factory _$$CreateChannelForProjectChangedCopyWith(
          _$CreateChannelForProjectChanged value,
          $Res Function(_$CreateChannelForProjectChanged) then) =
      __$$CreateChannelForProjectChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({bool createChannelForProject});
}

/// @nodoc
class __$$CreateChannelForProjectChangedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res,
        _$CreateChannelForProjectChanged>
    implements _$$CreateChannelForProjectChangedCopyWith<$Res> {
  __$$CreateChannelForProjectChangedCopyWithImpl(
      _$CreateChannelForProjectChanged _value,
      $Res Function(_$CreateChannelForProjectChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createChannelForProject = null,
  }) {
    return _then(_$CreateChannelForProjectChanged(
      null == createChannelForProject
          ? _value.createChannelForProject
          : createChannelForProject // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateChannelForProjectChanged
    implements CreateChannelForProjectChanged {
  const _$CreateChannelForProjectChanged(this.createChannelForProject);

  @override
  final bool createChannelForProject;

  @override
  String toString() {
    return 'CreateProjectEvent.createChannelForProjectChanged(createChannelForProject: $createChannelForProject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChannelForProjectChanged &&
            (identical(
                    other.createChannelForProject, createChannelForProject) ||
                other.createChannelForProject == createChannelForProject));
  }

  @override
  int get hashCode => Object.hash(runtimeType, createChannelForProject);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChannelForProjectChangedCopyWith<_$CreateChannelForProjectChanged>
      get copyWith => __$$CreateChannelForProjectChangedCopyWithImpl<
          _$CreateChannelForProjectChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return createChannelForProjectChanged(createChannelForProject);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return createChannelForProjectChanged?.call(createChannelForProject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (createChannelForProjectChanged != null) {
      return createChannelForProjectChanged(createChannelForProject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return createChannelForProjectChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return createChannelForProjectChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (createChannelForProjectChanged != null) {
      return createChannelForProjectChanged(this);
    }
    return orElse();
  }
}

abstract class CreateChannelForProjectChanged implements CreateProjectEvent {
  const factory CreateChannelForProjectChanged(
      final bool createChannelForProject) = _$CreateChannelForProjectChanged;

  bool get createChannelForProject;
  @JsonKey(ignore: true)
  _$$CreateChannelForProjectChangedCopyWith<_$CreateChannelForProjectChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittedCopyWith<$Res> {
  factory _$$SubmittedCopyWith(
          _$Submitted value, $Res Function(_$Submitted) then) =
      __$$SubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittedCopyWithImpl<$Res>
    extends _$CreateProjectEventCopyWithImpl<$Res, _$Submitted>
    implements _$$SubmittedCopyWith<$Res> {
  __$$SubmittedCopyWithImpl(
      _$Submitted _value, $Res Function(_$Submitted) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Submitted implements Submitted {
  const _$Submitted();

  @override
  String toString() {
    return 'CreateProjectEvent.submitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Submitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(List<TaskStatus> statusList) statusChanged,
    required TResult Function(List<User> users) usersChanged,
    required TResult Function(bool workspaceAccess) workspaceAccessChanged,
    required TResult Function(bool createChannelForProject)
        createChannelForProjectChanged,
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function(List<User> users)? usersChanged,
    TResult? Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult? Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult? Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function(List<User> users)? usersChanged,
    TResult Function(bool workspaceAccess)? workspaceAccessChanged,
    TResult Function(bool createChannelForProject)?
        createChannelForProjectChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(UsersChanged value) usersChanged,
    required TResult Function(WorkspaceAccessChanged value)
        workspaceAccessChanged,
    required TResult Function(CreateChannelForProjectChanged value)
        createChannelForProjectChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(UsersChanged value)? usersChanged,
    TResult? Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult? Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(UsersChanged value)? usersChanged,
    TResult Function(WorkspaceAccessChanged value)? workspaceAccessChanged,
    TResult Function(CreateChannelForProjectChanged value)?
        createChannelForProjectChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class Submitted implements CreateProjectEvent {
  const factory Submitted() = _$Submitted;
}

/// @nodoc
mixin _$CreateProjectState {
  String get name => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<WorkspaceState> get successOrFail =>
      throw _privateConstructorUsedError;
  List<TaskStatus> get statusList => throw _privateConstructorUsedError;
  List<User> get users => throw _privateConstructorUsedError;
  bool get createChannelForProject => throw _privateConstructorUsedError;
  bool get workspaceAccess => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateProjectStateCopyWith<CreateProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProjectStateCopyWith<$Res> {
  factory $CreateProjectStateCopyWith(
          CreateProjectState value, $Res Function(CreateProjectState) then) =
      _$CreateProjectStateCopyWithImpl<$Res, CreateProjectState>;
  @useResult
  $Res call(
      {String name,
      bool isSubmitting,
      Option<WorkspaceState> successOrFail,
      List<TaskStatus> statusList,
      List<User> users,
      bool createChannelForProject,
      bool workspaceAccess});
}

/// @nodoc
class _$CreateProjectStateCopyWithImpl<$Res, $Val extends CreateProjectState>
    implements $CreateProjectStateCopyWith<$Res> {
  _$CreateProjectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isSubmitting = null,
    Object? successOrFail = null,
    Object? statusList = null,
    Object? users = null,
    Object? createChannelForProject = null,
    Object? workspaceAccess = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<WorkspaceState>,
      statusList: null == statusList
          ? _value.statusList
          : statusList // ignore: cast_nullable_to_non_nullable
              as List<TaskStatus>,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      createChannelForProject: null == createChannelForProject
          ? _value.createChannelForProject
          : createChannelForProject // ignore: cast_nullable_to_non_nullable
              as bool,
      workspaceAccess: null == workspaceAccess
          ? _value.workspaceAccess
          : workspaceAccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateProjectStateCopyWith<$Res>
    implements $CreateProjectStateCopyWith<$Res> {
  factory _$$_CreateProjectStateCopyWith(_$_CreateProjectState value,
          $Res Function(_$_CreateProjectState) then) =
      __$$_CreateProjectStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      bool isSubmitting,
      Option<WorkspaceState> successOrFail,
      List<TaskStatus> statusList,
      List<User> users,
      bool createChannelForProject,
      bool workspaceAccess});
}

/// @nodoc
class __$$_CreateProjectStateCopyWithImpl<$Res>
    extends _$CreateProjectStateCopyWithImpl<$Res, _$_CreateProjectState>
    implements _$$_CreateProjectStateCopyWith<$Res> {
  __$$_CreateProjectStateCopyWithImpl(
      _$_CreateProjectState _value, $Res Function(_$_CreateProjectState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isSubmitting = null,
    Object? successOrFail = null,
    Object? statusList = null,
    Object? users = null,
    Object? createChannelForProject = null,
    Object? workspaceAccess = null,
  }) {
    return _then(_$_CreateProjectState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<WorkspaceState>,
      statusList: null == statusList
          ? _value._statusList
          : statusList // ignore: cast_nullable_to_non_nullable
              as List<TaskStatus>,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      createChannelForProject: null == createChannelForProject
          ? _value.createChannelForProject
          : createChannelForProject // ignore: cast_nullable_to_non_nullable
              as bool,
      workspaceAccess: null == workspaceAccess
          ? _value.workspaceAccess
          : workspaceAccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CreateProjectState implements _CreateProjectState {
  const _$_CreateProjectState(
      {required this.name,
      required this.isSubmitting,
      required this.successOrFail,
      required final List<TaskStatus> statusList,
      required final List<User> users,
      required this.createChannelForProject,
      required this.workspaceAccess})
      : _statusList = statusList,
        _users = users;

  @override
  final String name;
  @override
  final bool isSubmitting;
  @override
  final Option<WorkspaceState> successOrFail;
  final List<TaskStatus> _statusList;
  @override
  List<TaskStatus> get statusList {
    if (_statusList is EqualUnmodifiableListView) return _statusList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusList);
  }

  final List<User> _users;
  @override
  List<User> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final bool createChannelForProject;
  @override
  final bool workspaceAccess;

  @override
  String toString() {
    return 'CreateProjectState(name: $name, isSubmitting: $isSubmitting, successOrFail: $successOrFail, statusList: $statusList, users: $users, createChannelForProject: $createChannelForProject, workspaceAccess: $workspaceAccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateProjectState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.successOrFail, successOrFail) ||
                other.successOrFail == successOrFail) &&
            const DeepCollectionEquality()
                .equals(other._statusList, _statusList) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(
                    other.createChannelForProject, createChannelForProject) ||
                other.createChannelForProject == createChannelForProject) &&
            (identical(other.workspaceAccess, workspaceAccess) ||
                other.workspaceAccess == workspaceAccess));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      isSubmitting,
      successOrFail,
      const DeepCollectionEquality().hash(_statusList),
      const DeepCollectionEquality().hash(_users),
      createChannelForProject,
      workspaceAccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateProjectStateCopyWith<_$_CreateProjectState> get copyWith =>
      __$$_CreateProjectStateCopyWithImpl<_$_CreateProjectState>(
          this, _$identity);
}

abstract class _CreateProjectState implements CreateProjectState {
  const factory _CreateProjectState(
      {required final String name,
      required final bool isSubmitting,
      required final Option<WorkspaceState> successOrFail,
      required final List<TaskStatus> statusList,
      required final List<User> users,
      required final bool createChannelForProject,
      required final bool workspaceAccess}) = _$_CreateProjectState;

  @override
  String get name;
  @override
  bool get isSubmitting;
  @override
  Option<WorkspaceState> get successOrFail;
  @override
  List<TaskStatus> get statusList;
  @override
  List<User> get users;
  @override
  bool get createChannelForProject;
  @override
  bool get workspaceAccess;
  @override
  @JsonKey(ignore: true)
  _$$_CreateProjectStateCopyWith<_$_CreateProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}
