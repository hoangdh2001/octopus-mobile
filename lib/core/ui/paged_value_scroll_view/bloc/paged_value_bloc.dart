import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';

part 'paged_value_bloc.freezed.dart';

const defaultInitialPagedLimitMultiplier = 3;

abstract class PagedValueBloc<K, V>
    extends Bloc<PagedValueEvent<K, V>, PagedValueState<K, V>> {
  final PagedValueState<K, V> _initialState;

  List<V> get currentItems => state.asSuccess.items;

  PagedValueBloc(this._initialState) : super(_initialState) {
    on<PagedValueEvent<K, V>>((event, emit) async {
      await event.map(appendPage: (value) async {
        await handleAppendPage(value, state, emit);
      }, appendLastPage: (value) async {
        await handleAppendLastPage(value, state, emit);
      }, retry: (value) async {
        await retry(state, emit);
      }, refresh: (value) async {
        await refresh(value, state, emit);
      }, doInitialLoad: (value) async {
        await doInitialLoad(state, emit);
      }, loadMore: (value) async {
        await loadMore(value.nextPageKey, state, emit);
      }, updateState: (value) async {
        emit(value.state);
      });
    });
  }

  @protected
  Future<void> handleAppendPage(
      AppendPage<K, V> event,
      PagedValueState<K, V> state,
      Emitter<PagedValueState<K, V>> emitter) async {
    emitter(state.asSuccess.copyWith(
        items: state.asSuccess.items + event.newItems,
        nextPageKey: event.nextPageKey));
  }

  @protected
  Future<void> handleAppendLastPage(
      AppendLastPage<K, V> event,
      PagedValueState<K, V> state,
      Emitter<PagedValueState<K, V>> emitter) async {
    emitter(state.asSuccess
        .copyWith(items: state.asSuccess.items + event.newItems));
  }

  @protected
  Future<void> retry(PagedValueState<K, V> state,
      Emitter<PagedValueState<K, V>> emitter) async {
    final lastValue = state.asSuccess;
    assert(lastValue.hasError, '');

    final nextPageKey = lastValue.nextPageKey;
    state = lastValue.copyWith(error: null);
    return loadMore(nextPageKey!, state, emitter);
  }

  @protected
  Future<void> refresh(Refresh event, PagedValueState<K, V> state,
      Emitter<PagedValueState<K, V>> emitter) async {
    if (event.resetValue ?? true) state = _initialState;
    return doInitialLoad(state, emitter);
  }

  @protected
  Future<void> doInitialLoad(
      PagedValueState<K, V> state, Emitter<PagedValueState<K, V>> emit);

  @protected
  Future<void> loadMore(K nextPageKey, PagedValueState<K, V> state,
      Emitter<PagedValueState<K, V>> emit);
}

@freezed
class PagedValueEvent<K, V> with _$PagedValueEvent<K, V> {
  const PagedValueEvent._();

  const factory PagedValueEvent.appendPage(
      {required List<V> newItems, required K nextPageKey}) = AppendPage;
  const factory PagedValueEvent.appendLastPage(List<V> newItems) =
      AppendLastPage;
  const factory PagedValueEvent.retry() = Retry;
  const factory PagedValueEvent.refresh({bool? resetValue}) = Refresh;
  const factory PagedValueEvent.doInitialLoad() = DoInitialLoad;
  const factory PagedValueEvent.loadMore(K nextPageKey) = LoadMore;
  const factory PagedValueEvent.updateState(PagedValueState<K, V> state) =
      UpdateState;
}

@freezed
class PagedValueState<K, V> with _$PagedValueState<K, V> {
  const factory PagedValueState({
    K? nextPageKey,
    required List<V> items,
    OCError? error,
  }) = Success<K, V>;

  const PagedValueState._();

  const factory PagedValueState.loading() = Loading;
  const factory PagedValueState.error(OCError error) = PagedValueError;

  bool get isSuccess => this is Success<K, V>;

  bool get isNotSuccess => !isSuccess;

  Success<K, V> get asSuccess {
    assert(
      isSuccess,
      'Cannot get asSuccess if the PagedValue is not in the Success state',
    );
    return this as Success<K, V>;
  }

  bool get hasNextPage => asSuccess.nextPageKey != null;

  bool get hasError => asSuccess.error != null;

  int get itemCount {
    final count = asSuccess.items.length;
    if (hasNextPage || hasError) return count + 1;
    return count;
  }
}
