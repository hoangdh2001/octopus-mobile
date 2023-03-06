import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/core/scroll_position_list/element_registry.dart';
import 'package:octopus/core/scroll_position_list/indexed_key.dart';
import 'package:octopus/core/scroll_position_list/item_positions_listener.dart';
import 'package:octopus/core/scroll_position_list/item_positions_notifier.dart';
import 'package:octopus/core/scroll_position_list/scroll_view.dart';

class PositionedList extends StatefulWidget {
  const PositionedList({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.controller,
    this.itemPositionsNotifier,
    this.positionedIndex = 0,
    this.alignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.padding,
    this.cacheExtent,
    this.semanticChildCount,
    this.findChildIndexCallback,
    this.addSemanticIndexes = true,
    this.addRepaintBoundaries = true,
    this.addAutomaticKeepAlives = true,
    this.keyboardDismissBehavior,
  })  : assert((positionedIndex == 0) || (positionedIndex < itemCount),
            'positionedIndex cannot be 0 and must be smaller than itemCount'),
        super(key: key);

  final ChildIndexGetter? findChildIndexCallback;

  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  final ScrollController? controller;

  final ItemPositionsNotifier? itemPositionsNotifier;

  final int positionedIndex;

  final double alignment;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollPhysics? physics;

  final double? cacheExtent;

  final int? semanticChildCount;

  final bool addSemanticIndexes;

  final EdgeInsets? padding;

  final bool addRepaintBoundaries;

  final bool addAutomaticKeepAlives;

  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  @override
  State<StatefulWidget> createState() => _PositionedListState();
}

class _PositionedListState extends State<PositionedList> {
  final Key _centerKey = UniqueKey();

  final registeredElements = ValueNotifier<Set<Element>?>(null);
  late final ScrollController scrollController;

  bool updateScheduled = false;

  @override
  void initState() {
    super.initState();
    scrollController = widget.controller ?? ScrollController();
    scrollController.addListener(_schedulePositionNotificationUpdate);
    _schedulePositionNotificationUpdate();
  }

  @override
  void dispose() {
    scrollController.removeListener(_schedulePositionNotificationUpdate);
    super.dispose();
  }

  @override
  void didUpdateWidget(PositionedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _schedulePositionNotificationUpdate();
  }

  @override
  Widget build(BuildContext context) => RegistryWidget(
        elementNotifier: registeredElements,
        child: UnboundedCustomScrollView(
          anchor: widget.alignment,
          center: _centerKey,
          controller: scrollController,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          cacheExtent: widget.cacheExtent,
          physics: widget.physics,
          semanticChildCount: widget.semanticChildCount ?? widget.itemCount,
          slivers: <Widget>[
            if (widget.positionedIndex > 0)
              SliverPadding(
                padding: _leadingSliverPadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => widget.separatorBuilder == null
                        ? _buildItem(widget.positionedIndex - (index + 1))
                        : _buildSeparatedListElement(
                            widget.positionedIndex * 2 - (index + 1),
                          ),
                    childCount: widget.separatorBuilder == null
                        ? widget.positionedIndex
                        : widget.positionedIndex * 2,
                    addSemanticIndexes: false,
                    findChildIndexCallback: widget.findChildIndexCallback,
                    addRepaintBoundaries: widget.addRepaintBoundaries,
                    addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                  ),
                ),
              ),
            SliverPadding(
              key: _centerKey,
              padding: _centerSliverPadding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => widget.separatorBuilder == null
                      ? _buildItem(index + widget.positionedIndex)
                      : _buildSeparatedListElement(
                          index + widget.positionedIndex * 2,
                        ),
                  childCount: widget.itemCount != 0 ? 1 : 0,
                  findChildIndexCallback: widget.findChildIndexCallback,
                  addSemanticIndexes: false,
                  addRepaintBoundaries: widget.addRepaintBoundaries,
                  addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                ),
              ),
            ),
            if (widget.positionedIndex >= 0 &&
                widget.positionedIndex < widget.itemCount - 1)
              SliverPadding(
                padding: _trailingSliverPadding,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => widget.separatorBuilder == null
                        ? _buildItem(index + widget.positionedIndex + 1)
                        : _buildSeparatedListElement(
                            index + widget.positionedIndex * 2 + 1,
                          ),
                    childCount: widget.separatorBuilder == null
                        ? widget.itemCount - widget.positionedIndex - 1
                        : 2 * (widget.itemCount - widget.positionedIndex - 1),
                    findChildIndexCallback: widget.findChildIndexCallback,
                    addSemanticIndexes: false,
                    addRepaintBoundaries: widget.addRepaintBoundaries,
                    addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                  ),
                ),
              ),
          ],
        ),
      );

  Widget _buildSeparatedListElement(int index) {
    if (index.isEven) {
      return _buildItem(index ~/ 2);
    } else {
      return widget.separatorBuilder!(context, index ~/ 2);
    }
  }

  Widget _buildItem(int index) {
    final child = widget.itemBuilder(context, index);
    return RegisteredElementWidget(
      key: IndexedKey(child.key, index),
      child: widget.addSemanticIndexes
          ? IndexedSemantics(index: index, child: child)
          : child,
    );
  }

  EdgeInsets get _leadingSliverPadding =>
      (widget.scrollDirection == Axis.vertical
          ? widget.reverse
              ? widget.padding?.copyWith(top: 0)
              : widget.padding?.copyWith(bottom: 0)
          : widget.reverse
              ? widget.padding?.copyWith(left: 0)
              : widget.padding?.copyWith(right: 0)) ??
      const EdgeInsets.all(0);

  EdgeInsets get _centerSliverPadding => widget.scrollDirection == Axis.vertical
      ? widget.reverse
          ? widget.padding?.copyWith(
                top: widget.positionedIndex == widget.itemCount - 1
                    ? widget.padding!.top
                    : 0,
                bottom:
                    widget.positionedIndex == 0 ? widget.padding!.bottom : 0,
              ) ??
              const EdgeInsets.all(0)
          : widget.padding?.copyWith(
                top: widget.positionedIndex == 0 ? widget.padding!.top : 0,
                bottom: widget.positionedIndex == widget.itemCount - 1
                    ? widget.padding!.bottom
                    : 0,
              ) ??
              const EdgeInsets.all(0)
      : widget.reverse
          ? widget.padding?.copyWith(
                left: widget.positionedIndex == widget.itemCount - 1
                    ? widget.padding!.left
                    : 0,
                right: widget.positionedIndex == 0 ? widget.padding!.right : 0,
              ) ??
              const EdgeInsets.all(0)
          : widget.padding?.copyWith(
                left: widget.positionedIndex == 0 ? widget.padding!.left : 0,
                right: widget.positionedIndex == widget.itemCount - 1
                    ? widget.padding!.right
                    : 0,
              ) ??
              const EdgeInsets.all(0);

  EdgeInsets get _trailingSliverPadding =>
      widget.scrollDirection == Axis.vertical
          ? widget.reverse
              ? widget.padding?.copyWith(bottom: 0) ?? const EdgeInsets.all(0)
              : widget.padding?.copyWith(top: 0) ?? const EdgeInsets.all(0)
          : widget.reverse
              ? widget.padding?.copyWith(right: 0) ?? const EdgeInsets.all(0)
              : widget.padding?.copyWith(left: 0) ?? const EdgeInsets.all(0);

  void _schedulePositionNotificationUpdate() {
    if (!updateScheduled) {
      updateScheduled = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (registeredElements.value == null) {
          updateScheduled = false;
          return;
        }
        final positions = <ItemPosition>[];
        RenderViewport? viewport;
        for (final element in registeredElements.value!) {
          final box = element.renderObject as RenderBox?;
          viewport ??= RenderAbstractViewport.of(box) as RenderViewport?;
          if (viewport == null || box == null) {
            break;
          }
          final key = element.widget.key as IndexedKey;
          if (widget.scrollDirection == Axis.vertical) {
            final reveal = viewport.getOffsetToReveal(box, 0).offset;
            if (!reveal.isFinite) continue;
            final itemOffset = reveal -
                viewport.offset.pixels +
                viewport.anchor * viewport.size.height;
            positions.add(ItemPosition(
              index: key.index,
              itemLeadingEdge: itemOffset.round() /
                  scrollController.position.viewportDimension,
              itemTrailingEdge: (itemOffset + box.size.height).round() /
                  scrollController.position.viewportDimension,
            ));
          } else {
            final itemOffset =
                box.localToGlobal(Offset.zero, ancestor: viewport).dx;
            positions.add(ItemPosition(
              index: key.index,
              itemLeadingEdge: (widget.reverse
                          ? scrollController.position.viewportDimension -
                              (itemOffset + box.size.width)
                          : itemOffset)
                      .round() /
                  scrollController.position.viewportDimension,
              itemTrailingEdge: (widget.reverse
                          ? scrollController.position.viewportDimension -
                              itemOffset
                          : (itemOffset + box.size.width))
                      .round() /
                  scrollController.position.viewportDimension,
            ));
          }
        }
        widget.itemPositionsNotifier?.itemPositions.value = positions;
        updateScheduled = false;
      });
    }
  }
}
