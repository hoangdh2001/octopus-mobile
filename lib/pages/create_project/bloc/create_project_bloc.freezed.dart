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
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
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
    required TResult Function() submitted,
  }) {
    return nameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return nameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
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
    required TResult Function(Submitted value) submitted,
  }) {
    return nameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return nameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
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
    required TResult Function() submitted,
  }) {
    return statusChanged(statusList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return statusChanged?.call(statusList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
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
    required TResult Function(Submitted value) submitted,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
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
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(List<TaskStatus> statusList)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(List<TaskStatus> statusList)? statusChanged,
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
    required TResult Function(Submitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(StatusChanged value)? statusChanged,
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
      List<TaskStatus> statusList});
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
      List<TaskStatus> statusList});
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
    ));
  }
}

/// @nodoc

class _$_CreateProjectState implements _CreateProjectState {
  const _$_CreateProjectState(
      {required this.name,
      required this.isSubmitting,
      required this.successOrFail,
      required final List<TaskStatus> statusList})
      : _statusList = statusList;

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

  @override
  String toString() {
    return 'CreateProjectState(name: $name, isSubmitting: $isSubmitting, successOrFail: $successOrFail, statusList: $statusList)';
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
                .equals(other._statusList, _statusList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, isSubmitting,
      successOrFail, const DeepCollectionEquality().hash(_statusList));

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
      required final List<TaskStatus> statusList}) = _$_CreateProjectState;

  @override
  String get name;
  @override
  bool get isSubmitting;
  @override
  Option<WorkspaceState> get successOrFail;
  @override
  List<TaskStatus> get statusList;
  @override
  @JsonKey(ignore: true)
  _$$_CreateProjectStateCopyWith<_$_CreateProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}
