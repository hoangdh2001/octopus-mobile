import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollViewLoadingWidget extends StatelessWidget {
  const ScrollViewLoadingWidget({
    super.key,
    this.height = 42,
    this.width = 42,
  });

  final double height;

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: _getIndicatorWidget(Theme.of(context).platform),
      );

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator.adaptive();
    }
  }
}
