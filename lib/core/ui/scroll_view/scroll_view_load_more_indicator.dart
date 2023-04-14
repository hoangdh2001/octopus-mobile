import 'package:flutter/material.dart';

class ScrollViewLoadMoreIndicator extends StatelessWidget {
  const ScrollViewLoadMoreIndicator({
    super.key,
    this.height = 16,
    this.width = 16,
  });

  final double height;

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator.adaptive(),
      );
}
