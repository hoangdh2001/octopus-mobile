import 'package:flutter/material.dart';

typedef ScrollViewIndexedWidgetBuilder<ItemType, WidgetType extends Widget>
    = Widget Function(
  BuildContext context,
  List<ItemType> items,
  int index,
  WidgetType defaultWidget,
);
