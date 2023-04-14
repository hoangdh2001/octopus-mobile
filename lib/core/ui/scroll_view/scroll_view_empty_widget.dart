import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ScrollViewEmptyWidget extends StatelessWidget {
  const ScrollViewEmptyWidget({
    super.key,
    required this.emptyIcon,
    required this.emptyTitle,
    this.emptyTitleStyle,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget emptyTitle;

  final TextStyle? emptyTitleStyle;

  final Widget emptyIcon;

  final MainAxisSize mainAxisSize;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);

    final emptyIcon = AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: this.emptyIcon,
    );

    final emptyTitleText = AnimatedDefaultTextStyle(
      style: emptyTitleStyle ?? chatThemeData.textTheme.primaryGreyH1,
      duration: kThemeChangeDuration,
      child: emptyTitle,
    );

    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        emptyIcon,
        emptyTitleText,
      ],
    );
  }
}
