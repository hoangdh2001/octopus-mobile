// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_task_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewTaskEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTaskEventCopyWith<$Res> {
  factory $NewTaskEventCopyWith(
          NewTaskEvent value, $Res Function(NewTaskEvent) then) =
      _$NewTaskEventCopyWithImpl<$Res, NewTaskEvent>;
}

/// @nodoc
class _$NewTaskEventCopyWithImpl<$Res, $Val extends NewTaskEvent>
    implements $NewTaskEventCopyWith<$Res> {
  _$NewTaskEventCopyWithImpl(this._value, this._then);

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
    extends _$NewTaskEventCopyWithImpl<$Res, _$NameChanged>
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
    return 'NewTaskEvent.nameChanged(name: $name)';
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
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return nameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return nameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
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
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return nameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return nameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
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

abstract class NameChanged implements NewTaskEvent {
  const factory NameChanged(final String name) = _$NameChanged;

  String get name;
  @JsonKey(ignore: true)
  _$$NameChangedCopyWith<_$NameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DescriptionChangedCopyWith<$Res> {
  factory _$$DescriptionChangedCopyWith(_$DescriptionChanged value,
          $Res Function(_$DescriptionChanged) then) =
      __$$DescriptionChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String description});
}

/// @nodoc
class __$$DescriptionChangedCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$DescriptionChanged>
    implements _$$DescriptionChangedCopyWith<$Res> {
  __$$DescriptionChangedCopyWithImpl(
      _$DescriptionChanged _value, $Res Function(_$DescriptionChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
  }) {
    return _then(_$DescriptionChanged(
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DescriptionChanged implements DescriptionChanged {
  const _$DescriptionChanged(this.description);

  @override
  final String description;

  @override
  String toString() {
    return 'NewTaskEvent.descriptionChanged(description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptionChanged &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DescriptionChangedCopyWith<_$DescriptionChanged> get copyWith =>
      __$$DescriptionChangedCopyWithImpl<_$DescriptionChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return descriptionChanged(description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return descriptionChanged?.call(description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return descriptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return descriptionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(this);
    }
    return orElse();
  }
}

abstract class DescriptionChanged implements NewTaskEvent {
  const factory DescriptionChanged(final String description) =
      _$DescriptionChanged;

  String get description;
  @JsonKey(ignore: true)
  _$$DescriptionChangedCopyWith<_$DescriptionChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssigneesChangedCopyWith<$Res> {
  factory _$$AssigneesChangedCopyWith(
          _$AssigneesChanged value, $Res Function(_$AssigneesChanged) then) =
      __$$AssigneesChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<User> assignees});
}

/// @nodoc
class __$$AssigneesChangedCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$AssigneesChanged>
    implements _$$AssigneesChangedCopyWith<$Res> {
  __$$AssigneesChangedCopyWithImpl(
      _$AssigneesChanged _value, $Res Function(_$AssigneesChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignees = null,
  }) {
    return _then(_$AssigneesChanged(
      null == assignees
          ? _value._assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc

class _$AssigneesChanged implements AssigneesChanged {
  const _$AssigneesChanged(final List<User> assignees) : _assignees = assignees;

  final List<User> _assignees;
  @override
  List<User> get assignees {
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignees);
  }

  @override
  String toString() {
    return 'NewTaskEvent.assigneesChanged(assignees: $assignees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssigneesChanged &&
            const DeepCollectionEquality()
                .equals(other._assignees, _assignees));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_assignees));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssigneesChangedCopyWith<_$AssigneesChanged> get copyWith =>
      __$$AssigneesChangedCopyWithImpl<_$AssigneesChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return assigneesChanged(assignees);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return assigneesChanged?.call(assignees);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (assigneesChanged != null) {
      return assigneesChanged(assignees);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return assigneesChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return assigneesChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (assigneesChanged != null) {
      return assigneesChanged(this);
    }
    return orElse();
  }
}

abstract class AssigneesChanged implements NewTaskEvent {
  const factory AssigneesChanged(final List<User> assignees) =
      _$AssigneesChanged;

  List<User> get assignees;
  @JsonKey(ignore: true)
  _$$AssigneesChangedCopyWith<_$AssigneesChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartDateChangedCopyWith<$Res> {
  factory _$$StartDateChangedCopyWith(
          _$StartDateChanged value, $Res Function(_$StartDateChanged) then) =
      __$$StartDateChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? startDate});
}

/// @nodoc
class __$$StartDateChangedCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$StartDateChanged>
    implements _$$StartDateChangedCopyWith<$Res> {
  __$$StartDateChangedCopyWithImpl(
      _$StartDateChanged _value, $Res Function(_$StartDateChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
  }) {
    return _then(_$StartDateChanged(
      freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StartDateChanged implements StartDateChanged {
  const _$StartDateChanged(this.startDate);

  @override
  final DateTime? startDate;

  @override
  String toString() {
    return 'NewTaskEvent.startDateChanged(startDate: $startDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartDateChanged &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartDateChangedCopyWith<_$StartDateChanged> get copyWith =>
      __$$StartDateChangedCopyWithImpl<_$StartDateChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return startDateChanged(startDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return startDateChanged?.call(startDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (startDateChanged != null) {
      return startDateChanged(startDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return startDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return startDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (startDateChanged != null) {
      return startDateChanged(this);
    }
    return orElse();
  }
}

abstract class StartDateChanged implements NewTaskEvent {
  const factory StartDateChanged(final DateTime? startDate) =
      _$StartDateChanged;

  DateTime? get startDate;
  @JsonKey(ignore: true)
  _$$StartDateChangedCopyWith<_$StartDateChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DueDateChangedCopyWith<$Res> {
  factory _$$DueDateChangedCopyWith(
          _$DueDateChanged value, $Res Function(_$DueDateChanged) then) =
      __$$DueDateChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? dueDate});
}

/// @nodoc
class __$$DueDateChangedCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$DueDateChanged>
    implements _$$DueDateChangedCopyWith<$Res> {
  __$$DueDateChangedCopyWithImpl(
      _$DueDateChanged _value, $Res Function(_$DueDateChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDate = freezed,
  }) {
    return _then(_$DueDateChanged(
      freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$DueDateChanged implements DueDateChanged {
  const _$DueDateChanged(this.dueDate);

  @override
  final DateTime? dueDate;

  @override
  String toString() {
    return 'NewTaskEvent.dueDateChanged(dueDate: $dueDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DueDateChanged &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dueDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DueDateChangedCopyWith<_$DueDateChanged> get copyWith =>
      __$$DueDateChangedCopyWithImpl<_$DueDateChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return dueDateChanged(dueDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return dueDateChanged?.call(dueDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (dueDateChanged != null) {
      return dueDateChanged(dueDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return dueDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return dueDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (dueDateChanged != null) {
      return dueDateChanged(this);
    }
    return orElse();
  }
}

abstract class DueDateChanged implements NewTaskEvent {
  const factory DueDateChanged(final DateTime? dueDate) = _$DueDateChanged;

  DateTime? get dueDate;
  @JsonKey(ignore: true)
  _$$DueDateChangedCopyWith<_$DueDateChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectListCopyWith<$Res> {
  factory _$$SelectListCopyWith(
          _$SelectList value, $Res Function(_$SelectList) then) =
      __$$SelectListCopyWithImpl<$Res>;
  @useResult
  $Res call({ProjectState project, SpaceState space});
}

/// @nodoc
class __$$SelectListCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$SelectList>
    implements _$$SelectListCopyWith<$Res> {
  __$$SelectListCopyWithImpl(
      _$SelectList _value, $Res Function(_$SelectList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = null,
    Object? space = null,
  }) {
    return _then(_$SelectList(
      null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectState,
      null == space
          ? _value.space
          : space // ignore: cast_nullable_to_non_nullable
              as SpaceState,
    ));
  }
}

/// @nodoc

class _$SelectList implements SelectList {
  const _$SelectList(this.project, this.space);

  @override
  final ProjectState project;
  @override
  final SpaceState space;

  @override
  String toString() {
    return 'NewTaskEvent.selectList(project: $project, space: $space)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectList &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.space, space) || other.space == space));
  }

  @override
  int get hashCode => Object.hash(runtimeType, project, space);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectListCopyWith<_$SelectList> get copyWith =>
      __$$SelectListCopyWithImpl<_$SelectList>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return selectList(project, space);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return selectList?.call(project, space);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (selectList != null) {
      return selectList(project, space);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return selectList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return selectList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
    TResult Function(StatusChanged value)? statusChanged,
    TResult Function(Submitted value)? submitted,
    required TResult orElse(),
  }) {
    if (selectList != null) {
      return selectList(this);
    }
    return orElse();
  }
}

abstract class SelectList implements NewTaskEvent {
  const factory SelectList(final ProjectState project, final SpaceState space) =
      _$SelectList;

  ProjectState get project;
  SpaceState get space;
  @JsonKey(ignore: true)
  _$$SelectListCopyWith<_$SelectList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusChangedCopyWith<$Res> {
  factory _$$StatusChangedCopyWith(
          _$StatusChanged value, $Res Function(_$StatusChanged) then) =
      __$$StatusChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskStatus status});
}

/// @nodoc
class __$$StatusChangedCopyWithImpl<$Res>
    extends _$NewTaskEventCopyWithImpl<$Res, _$StatusChanged>
    implements _$$StatusChangedCopyWith<$Res> {
  __$$StatusChangedCopyWithImpl(
      _$StatusChanged _value, $Res Function(_$StatusChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$StatusChanged(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
    ));
  }
}

/// @nodoc

class _$StatusChanged implements StatusChanged {
  const _$StatusChanged(this.status);

  @override
  final TaskStatus status;

  @override
  String toString() {
    return 'NewTaskEvent.statusChanged(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusChanged &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusChangedCopyWith<_$StatusChanged> get copyWith =>
      __$$StatusChangedCopyWithImpl<_$StatusChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) nameChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return statusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return statusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NameChanged value) nameChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
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

abstract class StatusChanged implements NewTaskEvent {
  const factory StatusChanged(final TaskStatus status) = _$StatusChanged;

  TaskStatus get status;
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
    extends _$NewTaskEventCopyWithImpl<$Res, _$Submitted>
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
    return 'NewTaskEvent.submitted()';
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
    required TResult Function(String description) descriptionChanged,
    required TResult Function(List<User> assignees) assigneesChanged,
    required TResult Function(DateTime? startDate) startDateChanged,
    required TResult Function(DateTime? dueDate) dueDateChanged,
    required TResult Function(ProjectState project, SpaceState space)
        selectList,
    required TResult Function(TaskStatus status) statusChanged,
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? nameChanged,
    TResult? Function(String description)? descriptionChanged,
    TResult? Function(List<User> assignees)? assigneesChanged,
    TResult? Function(DateTime? startDate)? startDateChanged,
    TResult? Function(DateTime? dueDate)? dueDateChanged,
    TResult? Function(ProjectState project, SpaceState space)? selectList,
    TResult? Function(TaskStatus status)? statusChanged,
    TResult? Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? nameChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function(List<User> assignees)? assigneesChanged,
    TResult Function(DateTime? startDate)? startDateChanged,
    TResult Function(DateTime? dueDate)? dueDateChanged,
    TResult Function(ProjectState project, SpaceState space)? selectList,
    TResult Function(TaskStatus status)? statusChanged,
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
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(AssigneesChanged value) assigneesChanged,
    required TResult Function(StartDateChanged value) startDateChanged,
    required TResult Function(DueDateChanged value) dueDateChanged,
    required TResult Function(SelectList value) selectList,
    required TResult Function(StatusChanged value) statusChanged,
    required TResult Function(Submitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NameChanged value)? nameChanged,
    TResult? Function(DescriptionChanged value)? descriptionChanged,
    TResult? Function(AssigneesChanged value)? assigneesChanged,
    TResult? Function(StartDateChanged value)? startDateChanged,
    TResult? Function(DueDateChanged value)? dueDateChanged,
    TResult? Function(SelectList value)? selectList,
    TResult? Function(StatusChanged value)? statusChanged,
    TResult? Function(Submitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NameChanged value)? nameChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(AssigneesChanged value)? assigneesChanged,
    TResult Function(StartDateChanged value)? startDateChanged,
    TResult Function(DueDateChanged value)? dueDateChanged,
    TResult Function(SelectList value)? selectList,
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

abstract class Submitted implements NewTaskEvent {
  const factory Submitted() = _$Submitted;
}

/// @nodoc
mixin _$NewTaskState {
  String get name => throw _privateConstructorUsedError;
  SpaceState? get space => throw _privateConstructorUsedError;
  ProjectState? get project => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  List<User>? get assignees => throw _privateConstructorUsedError;
  TaskStatus get taskStatus => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<ProjectState, String>> get successOrFail =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewTaskStateCopyWith<NewTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTaskStateCopyWith<$Res> {
  factory $NewTaskStateCopyWith(
          NewTaskState value, $Res Function(NewTaskState) then) =
      _$NewTaskStateCopyWithImpl<$Res, NewTaskState>;
  @useResult
  $Res call(
      {String name,
      SpaceState? space,
      ProjectState? project,
      String? description,
      DateTime? startDate,
      DateTime? dueDate,
      List<User>? assignees,
      TaskStatus taskStatus,
      bool isSubmitting,
      Option<Either<ProjectState, String>> successOrFail});
}

/// @nodoc
class _$NewTaskStateCopyWithImpl<$Res, $Val extends NewTaskState>
    implements $NewTaskStateCopyWith<$Res> {
  _$NewTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? space = freezed,
    Object? project = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? dueDate = freezed,
    Object? assignees = freezed,
    Object? taskStatus = null,
    Object? isSubmitting = null,
    Object? successOrFail = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      space: freezed == space
          ? _value.space
          : space // ignore: cast_nullable_to_non_nullable
              as SpaceState?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectState?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignees: freezed == assignees
          ? _value.assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      taskStatus: null == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<ProjectState, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewTaskStateCopyWith<$Res>
    implements $NewTaskStateCopyWith<$Res> {
  factory _$$_NewTaskStateCopyWith(
          _$_NewTaskState value, $Res Function(_$_NewTaskState) then) =
      __$$_NewTaskStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      SpaceState? space,
      ProjectState? project,
      String? description,
      DateTime? startDate,
      DateTime? dueDate,
      List<User>? assignees,
      TaskStatus taskStatus,
      bool isSubmitting,
      Option<Either<ProjectState, String>> successOrFail});
}

/// @nodoc
class __$$_NewTaskStateCopyWithImpl<$Res>
    extends _$NewTaskStateCopyWithImpl<$Res, _$_NewTaskState>
    implements _$$_NewTaskStateCopyWith<$Res> {
  __$$_NewTaskStateCopyWithImpl(
      _$_NewTaskState _value, $Res Function(_$_NewTaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? space = freezed,
    Object? project = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? dueDate = freezed,
    Object? assignees = freezed,
    Object? taskStatus = null,
    Object? isSubmitting = null,
    Object? successOrFail = null,
  }) {
    return _then(_$_NewTaskState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      space: freezed == space
          ? _value.space
          : space // ignore: cast_nullable_to_non_nullable
              as SpaceState?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectState?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignees: freezed == assignees
          ? _value._assignees
          : assignees // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      taskStatus: null == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      successOrFail: null == successOrFail
          ? _value.successOrFail
          : successOrFail // ignore: cast_nullable_to_non_nullable
              as Option<Either<ProjectState, String>>,
    ));
  }
}

/// @nodoc

class _$_NewTaskState implements _NewTaskState {
  const _$_NewTaskState(
      {required this.name,
      this.space,
      this.project,
      this.description,
      this.startDate,
      this.dueDate,
      final List<User>? assignees,
      required this.taskStatus,
      required this.isSubmitting,
      required this.successOrFail})
      : _assignees = assignees;

  @override
  final String name;
  @override
  final SpaceState? space;
  @override
  final ProjectState? project;
  @override
  final String? description;
  @override
  final DateTime? startDate;
  @override
  final DateTime? dueDate;
  final List<User>? _assignees;
  @override
  List<User>? get assignees {
    final value = _assignees;
    if (value == null) return null;
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TaskStatus taskStatus;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<ProjectState, String>> successOrFail;

  @override
  String toString() {
    return 'NewTaskState(name: $name, space: $space, project: $project, description: $description, startDate: $startDate, dueDate: $dueDate, assignees: $assignees, taskStatus: $taskStatus, isSubmitting: $isSubmitting, successOrFail: $successOrFail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewTaskState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.space, space) || other.space == space) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality()
                .equals(other._assignees, _assignees) &&
            (identical(other.taskStatus, taskStatus) ||
                other.taskStatus == taskStatus) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.successOrFail, successOrFail) ||
                other.successOrFail == successOrFail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      space,
      project,
      description,
      startDate,
      dueDate,
      const DeepCollectionEquality().hash(_assignees),
      taskStatus,
      isSubmitting,
      successOrFail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewTaskStateCopyWith<_$_NewTaskState> get copyWith =>
      __$$_NewTaskStateCopyWithImpl<_$_NewTaskState>(this, _$identity);
}

abstract class _NewTaskState implements NewTaskState {
  const factory _NewTaskState(
          {required final String name,
          final SpaceState? space,
          final ProjectState? project,
          final String? description,
          final DateTime? startDate,
          final DateTime? dueDate,
          final List<User>? assignees,
          required final TaskStatus taskStatus,
          required final bool isSubmitting,
          required final Option<Either<ProjectState, String>> successOrFail}) =
      _$_NewTaskState;

  @override
  String get name;
  @override
  SpaceState? get space;
  @override
  ProjectState? get project;
  @override
  String? get description;
  @override
  DateTime? get startDate;
  @override
  DateTime? get dueDate;
  @override
  List<User>? get assignees;
  @override
  TaskStatus get taskStatus;
  @override
  bool get isSubmitting;
  @override
  Option<Either<ProjectState, String>> get successOrFail;
  @override
  @JsonKey(ignore: true)
  _$$_NewTaskStateCopyWith<_$_NewTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
