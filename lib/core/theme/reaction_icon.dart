import 'package:flutter/material.dart';

class ReactionIcon {
  ReactionIcon({
    required this.type,
    required this.builder,
  });

  final String type;

  final Widget Function(
    BuildContext,
    bool highlighted,
    double size,
  ) builder;
}
