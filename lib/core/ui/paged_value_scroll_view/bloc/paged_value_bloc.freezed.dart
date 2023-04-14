// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_value_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PagedValueEvent<K, V> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedValueEventCopyWith<K, V, $Res> {
  factory $PagedValueEventCopyWith(PagedValueEvent<K, V> value,
          $Res Function(PagedValueEvent<K, V>) then) =
      _$PagedValueEventCopyWithImpl<K, V, $Res, PagedValueEvent<K, V>>;
}

/// @nodoc
class _$PagedValueEventCopyWithImpl<K, V, $Res,
        $Val extends PagedValueEvent<K, V>>
    implements $PagedValueEventCopyWith<K, V, $Res> {
  _$PagedValueEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppendPageCopyWith<K, V, $Res> {
  factory _$$AppendPageCopyWith(
          _$AppendPage<K, V> value, $Res Function(_$AppendPage<K, V>) then) =
      __$$AppendPageCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({List<V> newItems, K nextPageKey});
}

/// @nodoc
class __$$AppendPageCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$AppendPage<K, V>>
    implements _$$AppendPageCopyWith<K, V, $Res> {
  __$$AppendPageCopyWithImpl(
      _$AppendPage<K, V> _value, $Res Function(_$AppendPage<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newItems = null,
    Object? nextPageKey = freezed,
  }) {
    return _then(_$AppendPage<K, V>(
      newItems: null == newItems
          ? _value._newItems
          : newItems // ignore: cast_nullable_to_non_nullable
              as List<V>,
      nextPageKey: freezed == nextPageKey
          ? _value.nextPageKey
          : nextPageKey // ignore: cast_nullable_to_non_nullable
              as K,
    ));
  }
}

/// @nodoc

class _$AppendPage<K, V> extends AppendPage<K, V> {
  const _$AppendPage(
      {required final List<V> newItems, required this.nextPageKey})
      : _newItems = newItems,
        super._();

  final List<V> _newItems;
  @override
  List<V> get newItems {
    if (_newItems is EqualUnmodifiableListView) return _newItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newItems);
  }

  @override
  final K nextPageKey;

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.appendPage(newItems: $newItems, nextPageKey: $nextPageKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppendPage<K, V> &&
            const DeepCollectionEquality().equals(other._newItems, _newItems) &&
            const DeepCollectionEquality()
                .equals(other.nextPageKey, nextPageKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_newItems),
      const DeepCollectionEquality().hash(nextPageKey));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppendPageCopyWith<K, V, _$AppendPage<K, V>> get copyWith =>
      __$$AppendPageCopyWithImpl<K, V, _$AppendPage<K, V>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return appendPage(newItems, nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return appendPage?.call(newItems, nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (appendPage != null) {
      return appendPage(newItems, nextPageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return appendPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return appendPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (appendPage != null) {
      return appendPage(this);
    }
    return orElse();
  }
}

abstract class AppendPage<K, V> extends PagedValueEvent<K, V> {
  const factory AppendPage(
      {required final List<V> newItems,
      required final K nextPageKey}) = _$AppendPage<K, V>;
  const AppendPage._() : super._();

  List<V> get newItems;
  K get nextPageKey;
  @JsonKey(ignore: true)
  _$$AppendPageCopyWith<K, V, _$AppendPage<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppendLastPageCopyWith<K, V, $Res> {
  factory _$$AppendLastPageCopyWith(_$AppendLastPage<K, V> value,
          $Res Function(_$AppendLastPage<K, V>) then) =
      __$$AppendLastPageCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({List<V> newItems});
}

/// @nodoc
class __$$AppendLastPageCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$AppendLastPage<K, V>>
    implements _$$AppendLastPageCopyWith<K, V, $Res> {
  __$$AppendLastPageCopyWithImpl(_$AppendLastPage<K, V> _value,
      $Res Function(_$AppendLastPage<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newItems = null,
  }) {
    return _then(_$AppendLastPage<K, V>(
      null == newItems
          ? _value._newItems
          : newItems // ignore: cast_nullable_to_non_nullable
              as List<V>,
    ));
  }
}

/// @nodoc

class _$AppendLastPage<K, V> extends AppendLastPage<K, V> {
  const _$AppendLastPage(final List<V> newItems)
      : _newItems = newItems,
        super._();

  final List<V> _newItems;
  @override
  List<V> get newItems {
    if (_newItems is EqualUnmodifiableListView) return _newItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newItems);
  }

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.appendLastPage(newItems: $newItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppendLastPage<K, V> &&
            const DeepCollectionEquality().equals(other._newItems, _newItems));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_newItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppendLastPageCopyWith<K, V, _$AppendLastPage<K, V>> get copyWith =>
      __$$AppendLastPageCopyWithImpl<K, V, _$AppendLastPage<K, V>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return appendLastPage(newItems);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return appendLastPage?.call(newItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (appendLastPage != null) {
      return appendLastPage(newItems);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return appendLastPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return appendLastPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (appendLastPage != null) {
      return appendLastPage(this);
    }
    return orElse();
  }
}

abstract class AppendLastPage<K, V> extends PagedValueEvent<K, V> {
  const factory AppendLastPage(final List<V> newItems) = _$AppendLastPage<K, V>;
  const AppendLastPage._() : super._();

  List<V> get newItems;
  @JsonKey(ignore: true)
  _$$AppendLastPageCopyWith<K, V, _$AppendLastPage<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RetryCopyWith<K, V, $Res> {
  factory _$$RetryCopyWith(
          _$Retry<K, V> value, $Res Function(_$Retry<K, V>) then) =
      __$$RetryCopyWithImpl<K, V, $Res>;
}

/// @nodoc
class __$$RetryCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$Retry<K, V>>
    implements _$$RetryCopyWith<K, V, $Res> {
  __$$RetryCopyWithImpl(
      _$Retry<K, V> _value, $Res Function(_$Retry<K, V>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Retry<K, V> extends Retry<K, V> {
  const _$Retry() : super._();

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.retry()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Retry<K, V>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return retry();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return retry?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return retry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return retry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry(this);
    }
    return orElse();
  }
}

abstract class Retry<K, V> extends PagedValueEvent<K, V> {
  const factory Retry() = _$Retry<K, V>;
  const Retry._() : super._();
}

/// @nodoc
abstract class _$$RefreshCopyWith<K, V, $Res> {
  factory _$$RefreshCopyWith(
          _$Refresh<K, V> value, $Res Function(_$Refresh<K, V>) then) =
      __$$RefreshCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({bool? resetValue});
}

/// @nodoc
class __$$RefreshCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$Refresh<K, V>>
    implements _$$RefreshCopyWith<K, V, $Res> {
  __$$RefreshCopyWithImpl(
      _$Refresh<K, V> _value, $Res Function(_$Refresh<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resetValue = freezed,
  }) {
    return _then(_$Refresh<K, V>(
      resetValue: freezed == resetValue
          ? _value.resetValue
          : resetValue // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$Refresh<K, V> extends Refresh<K, V> {
  const _$Refresh({this.resetValue}) : super._();

  @override
  final bool? resetValue;

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.refresh(resetValue: $resetValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Refresh<K, V> &&
            (identical(other.resetValue, resetValue) ||
                other.resetValue == resetValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resetValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshCopyWith<K, V, _$Refresh<K, V>> get copyWith =>
      __$$RefreshCopyWithImpl<K, V, _$Refresh<K, V>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return refresh(resetValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return refresh?.call(resetValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(resetValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class Refresh<K, V> extends PagedValueEvent<K, V> {
  const factory Refresh({final bool? resetValue}) = _$Refresh<K, V>;
  const Refresh._() : super._();

  bool? get resetValue;
  @JsonKey(ignore: true)
  _$$RefreshCopyWith<K, V, _$Refresh<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DoInitialLoadCopyWith<K, V, $Res> {
  factory _$$DoInitialLoadCopyWith(_$DoInitialLoad<K, V> value,
          $Res Function(_$DoInitialLoad<K, V>) then) =
      __$$DoInitialLoadCopyWithImpl<K, V, $Res>;
}

/// @nodoc
class __$$DoInitialLoadCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$DoInitialLoad<K, V>>
    implements _$$DoInitialLoadCopyWith<K, V, $Res> {
  __$$DoInitialLoadCopyWithImpl(
      _$DoInitialLoad<K, V> _value, $Res Function(_$DoInitialLoad<K, V>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DoInitialLoad<K, V> extends DoInitialLoad<K, V> {
  const _$DoInitialLoad() : super._();

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.doInitialLoad()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DoInitialLoad<K, V>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return doInitialLoad();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return doInitialLoad?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (doInitialLoad != null) {
      return doInitialLoad();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return doInitialLoad(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return doInitialLoad?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (doInitialLoad != null) {
      return doInitialLoad(this);
    }
    return orElse();
  }
}

abstract class DoInitialLoad<K, V> extends PagedValueEvent<K, V> {
  const factory DoInitialLoad() = _$DoInitialLoad<K, V>;
  const DoInitialLoad._() : super._();
}

/// @nodoc
abstract class _$$LoadMoreCopyWith<K, V, $Res> {
  factory _$$LoadMoreCopyWith(
          _$LoadMore<K, V> value, $Res Function(_$LoadMore<K, V>) then) =
      __$$LoadMoreCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({K nextPageKey});
}

/// @nodoc
class __$$LoadMoreCopyWithImpl<K, V, $Res>
    extends _$PagedValueEventCopyWithImpl<K, V, $Res, _$LoadMore<K, V>>
    implements _$$LoadMoreCopyWith<K, V, $Res> {
  __$$LoadMoreCopyWithImpl(
      _$LoadMore<K, V> _value, $Res Function(_$LoadMore<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextPageKey = freezed,
  }) {
    return _then(_$LoadMore<K, V>(
      freezed == nextPageKey
          ? _value.nextPageKey
          : nextPageKey // ignore: cast_nullable_to_non_nullable
              as K,
    ));
  }
}

/// @nodoc

class _$LoadMore<K, V> extends LoadMore<K, V> {
  const _$LoadMore(this.nextPageKey) : super._();

  @override
  final K nextPageKey;

  @override
  String toString() {
    return 'PagedValueEvent<$K, $V>.loadMore(nextPageKey: $nextPageKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMore<K, V> &&
            const DeepCollectionEquality()
                .equals(other.nextPageKey, nextPageKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(nextPageKey));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMoreCopyWith<K, V, _$LoadMore<K, V>> get copyWith =>
      __$$LoadMoreCopyWithImpl<K, V, _$LoadMore<K, V>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<V> newItems, K nextPageKey) appendPage,
    required TResult Function(List<V> newItems) appendLastPage,
    required TResult Function() retry,
    required TResult Function(bool? resetValue) refresh,
    required TResult Function() doInitialLoad,
    required TResult Function(K nextPageKey) loadMore,
  }) {
    return loadMore(nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult? Function(List<V> newItems)? appendLastPage,
    TResult? Function()? retry,
    TResult? Function(bool? resetValue)? refresh,
    TResult? Function()? doInitialLoad,
    TResult? Function(K nextPageKey)? loadMore,
  }) {
    return loadMore?.call(nextPageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<V> newItems, K nextPageKey)? appendPage,
    TResult Function(List<V> newItems)? appendLastPage,
    TResult Function()? retry,
    TResult Function(bool? resetValue)? refresh,
    TResult Function()? doInitialLoad,
    TResult Function(K nextPageKey)? loadMore,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(nextPageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppendPage<K, V> value) appendPage,
    required TResult Function(AppendLastPage<K, V> value) appendLastPage,
    required TResult Function(Retry<K, V> value) retry,
    required TResult Function(Refresh<K, V> value) refresh,
    required TResult Function(DoInitialLoad<K, V> value) doInitialLoad,
    required TResult Function(LoadMore<K, V> value) loadMore,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppendPage<K, V> value)? appendPage,
    TResult? Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult? Function(Retry<K, V> value)? retry,
    TResult? Function(Refresh<K, V> value)? refresh,
    TResult? Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult? Function(LoadMore<K, V> value)? loadMore,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppendPage<K, V> value)? appendPage,
    TResult Function(AppendLastPage<K, V> value)? appendLastPage,
    TResult Function(Retry<K, V> value)? retry,
    TResult Function(Refresh<K, V> value)? refresh,
    TResult Function(DoInitialLoad<K, V> value)? doInitialLoad,
    TResult Function(LoadMore<K, V> value)? loadMore,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class LoadMore<K, V> extends PagedValueEvent<K, V> {
  const factory LoadMore(final K nextPageKey) = _$LoadMore<K, V>;
  const LoadMore._() : super._();

  K get nextPageKey;
  @JsonKey(ignore: true)
  _$$LoadMoreCopyWith<K, V, _$LoadMore<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PagedValueState<K, V> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error) $default, {
    required TResult Function() loading,
    required TResult Function(Error error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult? Function()? loading,
    TResult? Function(Error error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult Function()? loading,
    TResult Function(Error error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<K, V> value) $default, {
    required TResult Function(Loading<K, V> value) loading,
    required TResult Function(PagedValueError<K, V> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<K, V> value)? $default, {
    TResult? Function(Loading<K, V> value)? loading,
    TResult? Function(PagedValueError<K, V> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<K, V> value)? $default, {
    TResult Function(Loading<K, V> value)? loading,
    TResult Function(PagedValueError<K, V> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedValueStateCopyWith<K, V, $Res> {
  factory $PagedValueStateCopyWith(PagedValueState<K, V> value,
          $Res Function(PagedValueState<K, V>) then) =
      _$PagedValueStateCopyWithImpl<K, V, $Res, PagedValueState<K, V>>;
}

/// @nodoc
class _$PagedValueStateCopyWithImpl<K, V, $Res,
        $Val extends PagedValueState<K, V>>
    implements $PagedValueStateCopyWith<K, V, $Res> {
  _$PagedValueStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessCopyWith<K, V, $Res> {
  factory _$$SuccessCopyWith(
          _$Success<K, V> value, $Res Function(_$Success<K, V>) then) =
      __$$SuccessCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({K? nextPageKey, List<V> items, Error? error});

  $ErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$SuccessCopyWithImpl<K, V, $Res>
    extends _$PagedValueStateCopyWithImpl<K, V, $Res, _$Success<K, V>>
    implements _$$SuccessCopyWith<K, V, $Res> {
  __$$SuccessCopyWithImpl(
      _$Success<K, V> _value, $Res Function(_$Success<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextPageKey = freezed,
    Object? items = null,
    Object? error = freezed,
  }) {
    return _then(_$Success<K, V>(
      nextPageKey: freezed == nextPageKey
          ? _value.nextPageKey
          : nextPageKey // ignore: cast_nullable_to_non_nullable
              as K?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<V>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$Success<K, V> extends Success<K, V> {
  const _$Success({this.nextPageKey, required final List<V> items, this.error})
      : _items = items,
        super._();

  @override
  final K? nextPageKey;
  final List<V> _items;
  @override
  List<V> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final Error? error;

  @override
  String toString() {
    return 'PagedValueState<$K, $V>(nextPageKey: $nextPageKey, items: $items, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Success<K, V> &&
            const DeepCollectionEquality()
                .equals(other.nextPageKey, nextPageKey) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nextPageKey),
      const DeepCollectionEquality().hash(_items),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessCopyWith<K, V, _$Success<K, V>> get copyWith =>
      __$$SuccessCopyWithImpl<K, V, _$Success<K, V>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error) $default, {
    required TResult Function() loading,
    required TResult Function(Error error) error,
  }) {
    return $default(nextPageKey, items, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult? Function()? loading,
    TResult? Function(Error error)? error,
  }) {
    return $default?.call(nextPageKey, items, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult Function()? loading,
    TResult Function(Error error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(nextPageKey, items, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<K, V> value) $default, {
    required TResult Function(Loading<K, V> value) loading,
    required TResult Function(PagedValueError<K, V> value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<K, V> value)? $default, {
    TResult? Function(Loading<K, V> value)? loading,
    TResult? Function(PagedValueError<K, V> value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<K, V> value)? $default, {
    TResult Function(Loading<K, V> value)? loading,
    TResult Function(PagedValueError<K, V> value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Success<K, V> extends PagedValueState<K, V> {
  const factory Success(
      {final K? nextPageKey,
      required final List<V> items,
      final Error? error}) = _$Success<K, V>;
  const Success._() : super._();

  K? get nextPageKey;
  List<V> get items;
  Error? get error;
  @JsonKey(ignore: true)
  _$$SuccessCopyWith<K, V, _$Success<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingCopyWith<K, V, $Res> {
  factory _$$LoadingCopyWith(
          _$Loading<K, V> value, $Res Function(_$Loading<K, V>) then) =
      __$$LoadingCopyWithImpl<K, V, $Res>;
}

/// @nodoc
class __$$LoadingCopyWithImpl<K, V, $Res>
    extends _$PagedValueStateCopyWithImpl<K, V, $Res, _$Loading<K, V>>
    implements _$$LoadingCopyWith<K, V, $Res> {
  __$$LoadingCopyWithImpl(
      _$Loading<K, V> _value, $Res Function(_$Loading<K, V>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Loading<K, V> extends Loading<K, V> {
  const _$Loading() : super._();

  @override
  String toString() {
    return 'PagedValueState<$K, $V>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Loading<K, V>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error) $default, {
    required TResult Function() loading,
    required TResult Function(Error error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult? Function()? loading,
    TResult? Function(Error error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult Function()? loading,
    TResult Function(Error error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<K, V> value) $default, {
    required TResult Function(Loading<K, V> value) loading,
    required TResult Function(PagedValueError<K, V> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<K, V> value)? $default, {
    TResult? Function(Loading<K, V> value)? loading,
    TResult? Function(PagedValueError<K, V> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<K, V> value)? $default, {
    TResult Function(Loading<K, V> value)? loading,
    TResult Function(PagedValueError<K, V> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<K, V> extends PagedValueState<K, V> {
  const factory Loading() = _$Loading<K, V>;
  const Loading._() : super._();
}

/// @nodoc
abstract class _$$PagedValueErrorCopyWith<K, V, $Res> {
  factory _$$PagedValueErrorCopyWith(_$PagedValueError<K, V> value,
          $Res Function(_$PagedValueError<K, V>) then) =
      __$$PagedValueErrorCopyWithImpl<K, V, $Res>;
  @useResult
  $Res call({Error error});

  $ErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$PagedValueErrorCopyWithImpl<K, V, $Res>
    extends _$PagedValueStateCopyWithImpl<K, V, $Res, _$PagedValueError<K, V>>
    implements _$$PagedValueErrorCopyWith<K, V, $Res> {
  __$$PagedValueErrorCopyWithImpl(_$PagedValueError<K, V> _value,
      $Res Function(_$PagedValueError<K, V>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$PagedValueError<K, V>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ErrorCopyWith<$Res> get error {
    return $ErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$PagedValueError<K, V> extends PagedValueError<K, V> {
  const _$PagedValueError(this.error) : super._();

  @override
  final Error error;

  @override
  String toString() {
    return 'PagedValueState<$K, $V>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagedValueError<K, V> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedValueErrorCopyWith<K, V, _$PagedValueError<K, V>> get copyWith =>
      __$$PagedValueErrorCopyWithImpl<K, V, _$PagedValueError<K, V>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error) $default, {
    required TResult Function() loading,
    required TResult Function(Error error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult? Function()? loading,
    TResult? Function(Error error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(K? nextPageKey, List<V> items, Error? error)? $default, {
    TResult Function()? loading,
    TResult Function(Error error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Success<K, V> value) $default, {
    required TResult Function(Loading<K, V> value) loading,
    required TResult Function(PagedValueError<K, V> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Success<K, V> value)? $default, {
    TResult? Function(Loading<K, V> value)? loading,
    TResult? Function(PagedValueError<K, V> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Success<K, V> value)? $default, {
    TResult Function(Loading<K, V> value)? loading,
    TResult Function(PagedValueError<K, V> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PagedValueError<K, V> extends PagedValueState<K, V> {
  const factory PagedValueError(final Error error) = _$PagedValueError<K, V>;
  const PagedValueError._() : super._();

  Error get error;
  @JsonKey(ignore: true)
  _$$PagedValueErrorCopyWith<K, V, _$PagedValueError<K, V>> get copyWith =>
      throw _privateConstructorUsedError;
}
