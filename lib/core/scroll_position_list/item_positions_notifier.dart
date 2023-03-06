import 'package:flutter/foundation.dart';
import 'package:octopus/core/scroll_position_list/item_positions_listener.dart';

class ItemPositionsNotifier implements ItemPositionsListener {
  @override
  final ValueNotifier<Iterable<ItemPosition>> itemPositions = ValueNotifier([]);
}
