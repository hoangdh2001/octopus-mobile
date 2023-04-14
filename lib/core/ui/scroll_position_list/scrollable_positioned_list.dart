import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/core/ui/scroll_position_list/item_positions_listener.dart';
import 'package:octopus/core/ui/scroll_position_list/item_positions_notifier.dart';
import 'package:octopus/core/ui/scroll_position_list/positioned_list.dart';
import 'package:octopus/core/ui/scroll_position_list/post_mount_callback.dart';

const int _screenScrollCount = 2;

class ScrollablePositionedList extends StatefulWidget {
  const ScrollablePositionedList.builder({
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
    this.itemScrollController,
    ItemPositionsListener? itemPositionsListener,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.findChildIndexCallback,
    this.keyboardDismissBehavior,
  })  : itemPositionsNotifier = itemPositionsListener as ItemPositionsNotifier?,
        separatorBuilder = null,
        super(key: key);

  const ScrollablePositionedList.separated({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    Key? key,
    this.itemScrollController,
    ItemPositionsListener? itemPositionsListener,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.findChildIndexCallback,
    this.keyboardDismissBehavior,
  })  : assert(separatorBuilder != null, 'seperatorBuilder cannot be null'),
        itemPositionsNotifier = itemPositionsListener as ItemPositionsNotifier?,
        super(key: key);

  final ChildIndexGetter? findChildIndexCallback;

  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  final ItemScrollController? itemScrollController;

  final ItemPositionsNotifier? itemPositionsNotifier;

  final int initialScrollIndex;

  final double initialAlignment;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollPhysics? physics;

  final int? semanticChildCount;

  final EdgeInsets? padding;

  final bool addSemanticIndexes;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final double? minCacheExtent;

  @override
  State<StatefulWidget> createState() => _ScrollablePositionedListState();
}

class ItemScrollController {
  bool get isAttached => _scrollableListState != null;

  _ScrollablePositionedListState? _scrollableListState;

  void jumpTo({required int index, double alignment = 0}) {
    _scrollableListState!._jumpTo(index: index, alignment: alignment);
  }

  Future<void> scrollTo({
    required int index,
    double alignment = 0,
    required Duration duration,
    Curve curve = Curves.linear,
    List<double> opacityAnimationWeights = const [40, 20, 40],
  }) {
    assert(_scrollableListState != null, '_scrollableListState cannot be null');
    assert(opacityAnimationWeights.length == 3,
        'opacityAnimationWeights.length is not equal to 3');
    assert(duration > Duration.zero,
        'duration needs to be bigger than Duration.zero');
    return _scrollableListState!._scrollTo(
      index: index,
      alignment: alignment,
      duration: duration,
      curve: curve,
      opacityAnimationWeights: opacityAnimationWeights,
    );
  }

  void _attach(_ScrollablePositionedListState scrollableListState) {
    assert(
        _scrollableListState == null, '_scrollableListState needs to be null');
    _scrollableListState = scrollableListState;
  }

  void _detach() {
    _scrollableListState = null;
  }
}

class _ScrollablePositionedListState extends State<ScrollablePositionedList>
    with TickerProviderStateMixin {
  _ListDisplayDetails primary = _ListDisplayDetails(const ValueKey('Ping'));

  _ListDisplayDetails secondary = _ListDisplayDetails(const ValueKey('Pong'));

  final opacity = ProxyAnimation(const AlwaysStoppedAnimation<double>(0));

  void Function() startAnimationCallback = () {};

  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    final ItemPosition? initialPosition =
        PageStorage.of(context)!.readState(context);
    primary
      ..target = initialPosition?.index ?? widget.initialScrollIndex
      ..alignment = initialPosition?.itemLeadingEdge ?? widget.initialAlignment;
    if (widget.itemCount > 0 && primary.target > widget.itemCount - 1) {
      primary.target = widget.itemCount - 1;
    }
    widget.itemScrollController?._attach(this);
    primary.itemPositionsNotifier.itemPositions.addListener(_updatePositions);
    secondary.itemPositionsNotifier.itemPositions.addListener(_updatePositions);
  }

  @override
  void deactivate() {
    widget.itemScrollController?._detach();
    super.deactivate();
  }

  @override
  void dispose() {
    primary.itemPositionsNotifier.itemPositions
        .removeListener(_updatePositions);
    secondary.itemPositionsNotifier.itemPositions
        .removeListener(_updatePositions);
    super.dispose();
  }

  @override
  void didUpdateWidget(ScrollablePositionedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemScrollController?._scrollableListState == this) {
      oldWidget.itemScrollController?._detach();
    }
    if (widget.itemScrollController?._scrollableListState != this) {
      widget.itemScrollController?._detach();
      widget.itemScrollController?._attach(this);
    }

    if (widget.itemCount == 0) {
      primary.target = 0;
      secondary.target = 0;
    } else {
      if (primary.target > widget.itemCount - 1) {
        primary.target = widget.itemCount - 1;
      }
      if (secondary.target > widget.itemCount - 1) {
        secondary.target = widget.itemCount - 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final cacheExtent = _cacheExtent(constraints);
          return GestureDetector(
            onPanDown: (_) => _stopScroll(canceled: true),
            excludeFromSemantics: true,
            child: Stack(
              children: <Widget>[
                PostMountCallback(
                  key: primary.key,
                  callback: startAnimationCallback,
                  child: FadeTransition(
                    opacity: ReverseAnimation(opacity),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (_) => _isTransitioning,
                      child: PositionedList(
                        keyboardDismissBehavior: widget.keyboardDismissBehavior,
                        itemBuilder: widget.itemBuilder,
                        separatorBuilder: widget.separatorBuilder,
                        itemCount: widget.itemCount,
                        positionedIndex: primary.target,
                        controller: primary.scrollController,
                        itemPositionsNotifier: primary.itemPositionsNotifier,
                        scrollDirection: widget.scrollDirection,
                        reverse: widget.reverse,
                        cacheExtent: cacheExtent,
                        alignment: primary.alignment,
                        physics: widget.physics,
                        addSemanticIndexes: widget.addSemanticIndexes,
                        semanticChildCount: widget.semanticChildCount,
                        padding: widget.padding,
                        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                        addRepaintBoundaries: widget.addRepaintBoundaries,
                        findChildIndexCallback: widget.findChildIndexCallback,
                      ),
                    ),
                  ),
                ),
                if (_isTransitioning)
                  PostMountCallback(
                    key: secondary.key,
                    callback: startAnimationCallback,
                    child: FadeTransition(
                      opacity: opacity,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (_) => false,
                        child: PositionedList(
                          keyboardDismissBehavior:
                              widget.keyboardDismissBehavior,
                          itemBuilder: widget.itemBuilder,
                          separatorBuilder: widget.separatorBuilder,
                          itemCount: widget.itemCount,
                          itemPositionsNotifier:
                              secondary.itemPositionsNotifier,
                          positionedIndex: secondary.target,
                          controller: secondary.scrollController,
                          scrollDirection: widget.scrollDirection,
                          reverse: widget.reverse,
                          cacheExtent: cacheExtent,
                          alignment: secondary.alignment,
                          physics: widget.physics,
                          addSemanticIndexes: widget.addSemanticIndexes,
                          semanticChildCount: widget.semanticChildCount,
                          padding: widget.padding,
                          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                          addRepaintBoundaries: widget.addRepaintBoundaries,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      );

  double _cacheExtent(BoxConstraints constraints) => max(
        constraints.maxHeight * _screenScrollCount,
        widget.minCacheExtent ?? 0,
      );

  void _jumpTo({required int index, required double alignment}) {
    _stopScroll(canceled: true);
    if (index > widget.itemCount - 1) {
      index = widget.itemCount - 1;
    }
    setState(() {
      primary.scrollController.jumpTo(0);
      primary
        ..target = index
        ..alignment = alignment;
    });
  }

  Future<void> _scrollTo({
    required int index,
    required double alignment,
    required Duration duration,
    Curve curve = Curves.linear,
    required List<double> opacityAnimationWeights,
  }) async {
    if (index > widget.itemCount - 1) {
      index = widget.itemCount - 1;
    }
    if (_isTransitioning) {
      _stopScroll(canceled: true);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _startScroll(
          index: index,
          alignment: alignment,
          duration: duration,
          curve: curve,
          opacityAnimationWeights: opacityAnimationWeights,
        );
      });
    } else {
      await _startScroll(
        index: index,
        alignment: alignment,
        duration: duration,
        curve: curve,
        opacityAnimationWeights: opacityAnimationWeights,
      );
    }
  }

  Future<void> _startScroll({
    required int index,
    required double alignment,
    required Duration duration,
    Curve curve = Curves.linear,
    required List<double> opacityAnimationWeights,
  }) async {
    final direction = index > primary.target ? 1 : -1;
    final itemPosition =
        primary.itemPositionsNotifier.itemPositions.value.firstWhereOrNull(
      (ItemPosition itemPosition) => itemPosition.index == index,
    );
    if (itemPosition != null) {
      final localScrollAmount = itemPosition.itemLeadingEdge *
          primary.scrollController.position.viewportDimension;
      await primary.scrollController.animateTo(
        primary.scrollController.offset +
            localScrollAmount -
            alignment * primary.scrollController.position.viewportDimension,
        duration: duration,
        curve: curve,
      );
    } else {
      final scrollAmount = _screenScrollCount *
          primary.scrollController.position.viewportDimension;
      final startCompleter = Completer<void>();
      final endCompleter = Completer<void>();
      startAnimationCallback = () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          startAnimationCallback = () {};

          opacity.parent = _opacityAnimation(opacityAnimationWeights).animate(
            AnimationController(vsync: this, duration: duration)..forward(),
          );
          secondary.scrollController.jumpTo(-direction *
              (_screenScrollCount *
                      primary.scrollController.position.viewportDimension -
                  alignment *
                      secondary.scrollController.position.viewportDimension));

          startCompleter.complete(primary.scrollController.animateTo(
            primary.scrollController.offset + direction * scrollAmount,
            duration: duration,
            curve: curve,
          ));
          endCompleter.complete(secondary.scrollController
              .animateTo(0, duration: duration, curve: curve));
        });
      };
      setState(() {
        secondary
          ..target = index
          ..alignment = alignment;
        _isTransitioning = true;
      });
      await Future.wait<void>([startCompleter.future, endCompleter.future]);
      _stopScroll();
    }
  }

  void _stopScroll({bool canceled = false}) {
    if (!_isTransitioning) {
      return;
    }

    if (canceled) {
      if (primary.scrollController.hasClients) {
        primary.scrollController.jumpTo(primary.scrollController.offset);
      }
      if (secondary.scrollController.hasClients) {
        secondary.scrollController.jumpTo(secondary.scrollController.offset);
      }
    }

    setState(() {
      if (opacity.value >= 0.5) {
        final temp = primary;
        primary = secondary;
        secondary = temp;
      }
      _isTransitioning = false;
      opacity.parent = const AlwaysStoppedAnimation<double>(0);
    });
  }

  Animatable<double> _opacityAnimation(List<double> opacityAnimationWeights) {
    const startOpacity = 0.0;
    const endOpacity = 1.0;
    return TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(startOpacity),
        weight: opacityAnimationWeights[0],
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: startOpacity, end: endOpacity),
        weight: opacityAnimationWeights[1],
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(endOpacity),
        weight: opacityAnimationWeights[2],
      ),
    ]);
  }

  void _updatePositions() {
    final itemPositions = primary.itemPositionsNotifier.itemPositions.value
        .where((ItemPosition position) =>
            position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0);
    if (itemPositions.isNotEmpty) {
      PageStorage.of(context)!.writeState(
        context,
        itemPositions.reduce((value, element) =>
            value.itemLeadingEdge < element.itemLeadingEdge ? value : element),
      );
    }
    widget.itemPositionsNotifier?.itemPositions.value = itemPositions;
  }
}

class _ListDisplayDetails {
  _ListDisplayDetails(this.key);

  final itemPositionsNotifier = ItemPositionsNotifier();
  final scrollController = ScrollController(keepScrollOffset: false);

  int target = 0;

  double alignment = 0;

  final Key key;
}
