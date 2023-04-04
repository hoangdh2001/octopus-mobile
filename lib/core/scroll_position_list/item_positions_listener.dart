import 'package:flutter/foundation.dart';
import 'package:octopus/core/scroll_position_list/item_positions_notifier.dart';

abstract class ItemPositionsListener {
  factory ItemPositionsListener.create() => ItemPositionsNotifier();

  ValueListenable<Iterable<ItemPosition>> get itemPositions;
}

class ItemPosition {
  const ItemPosition({
    required this.index,
    required this.itemLeadingEdge,
    required this.itemTrailingEdge,
  });

  final int index;

  final double itemLeadingEdge;

  final double itemTrailingEdge;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final ItemPosition otherPosition = other;
    return otherPosition.index == index &&
        otherPosition.itemLeadingEdge == itemLeadingEdge &&
        otherPosition.itemTrailingEdge == itemTrailingEdge;
  }

  @override
  int get hashCode =>
      31 * (31 * (index.hashCode + 7) + itemLeadingEdge.hashCode) +
      itemTrailingEdge.hashCode;

  @override
  String toString() =>
      '''ItemPosition(index: $index, itemLeadingEdge: $itemLeadingEdge, itemTrailingEdge: $itemTrailingEdge)''';
}
