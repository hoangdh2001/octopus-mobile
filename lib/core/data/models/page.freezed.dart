// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Page<T> {
  int? get skip => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  int? get totalItem => throw _privateConstructorUsedError;
  int? get totalPage => throw _privateConstructorUsedError;
  List<T> get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageCopyWith<T, Page<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageCopyWith<T, $Res> {
  factory $PageCopyWith(Page<T> value, $Res Function(Page<T>) then) =
      _$PageCopyWithImpl<T, $Res, Page<T>>;
  @useResult
  $Res call(
      {int? skip, int? limit, int? totalItem, int? totalPage, List<T> data});
}

/// @nodoc
class _$PageCopyWithImpl<T, $Res, $Val extends Page<T>>
    implements $PageCopyWith<T, $Res> {
  _$PageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? totalItem = freezed,
    Object? totalPage = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItem: freezed == totalItem
          ? _value.totalItem
          : totalItem // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPage: freezed == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PageCopyWith<T, $Res> implements $PageCopyWith<T, $Res> {
  factory _$$_PageCopyWith(_$_Page<T> value, $Res Function(_$_Page<T>) then) =
      __$$_PageCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {int? skip, int? limit, int? totalItem, int? totalPage, List<T> data});
}

/// @nodoc
class __$$_PageCopyWithImpl<T, $Res>
    extends _$PageCopyWithImpl<T, $Res, _$_Page<T>>
    implements _$$_PageCopyWith<T, $Res> {
  __$$_PageCopyWithImpl(_$_Page<T> _value, $Res Function(_$_Page<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skip = freezed,
    Object? limit = freezed,
    Object? totalItem = freezed,
    Object? totalPage = freezed,
    Object? data = null,
  }) {
    return _then(_$_Page<T>(
      skip: freezed == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as int?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItem: freezed == totalItem
          ? _value.totalItem
          : totalItem // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPage: freezed == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_Page<T> implements _Page<T> {
  const _$_Page(
      {this.skip,
      this.limit,
      this.totalItem,
      this.totalPage,
      required final List<T> data})
      : _data = data;

  @override
  final int? skip;
  @override
  final int? limit;
  @override
  final int? totalItem;
  @override
  final int? totalPage;
  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'Page<$T>(skip: $skip, limit: $limit, totalItem: $totalItem, totalPage: $totalPage, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Page<T> &&
            (identical(other.skip, skip) || other.skip == skip) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalItem, totalItem) ||
                other.totalItem == totalItem) &&
            (identical(other.totalPage, totalPage) ||
                other.totalPage == totalPage) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, skip, limit, totalItem,
      totalPage, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PageCopyWith<T, _$_Page<T>> get copyWith =>
      __$$_PageCopyWithImpl<T, _$_Page<T>>(this, _$identity);
}

abstract class _Page<T> implements Page<T> {
  const factory _Page(
      {final int? skip,
      final int? limit,
      final int? totalItem,
      final int? totalPage,
      required final List<T> data}) = _$_Page<T>;

  @override
  int? get skip;
  @override
  int? get limit;
  @override
  int? get totalItem;
  @override
  int? get totalPage;
  @override
  List<T> get data;
  @override
  @JsonKey(ignore: true)
  _$$_PageCopyWith<T, _$_Page<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
