import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ScrollViewErrorWidget extends StatelessWidget {
  const ScrollViewErrorWidget({
    super.key,
    this.errorTitle,
    this.errorTitleStyle,
    this.errorIcon,
    this.retryButtonText,
    this.retryButtonTextStyle,
    required this.onRetryPressed,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget? errorTitle;

  final TextStyle? errorTitleStyle;

  final Widget? errorIcon;

  final Widget? retryButtonText;

  final TextStyle? retryButtonTextStyle;

  final VoidCallback onRetryPressed;

  final MainAxisSize mainAxisSize;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);

    final errorIcon = AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: this.errorIcon ??
          Icon(
            Icons.error_outline_rounded,
            size: 148,
            color: chatThemeData.colorTheme.disabled,
          ),
    );

    final titleText = AnimatedDefaultTextStyle(
      style: errorTitleStyle ?? chatThemeData.textTheme.primaryGreyH1,
      duration: kThemeChangeDuration,
      child: errorTitle ?? const SizedBox(),
    );

    final retryButtonText = AnimatedDefaultTextStyle(
      style: errorTitleStyle ??
          chatThemeData.textTheme.primaryGreyH1.copyWith(
            color: Colors.white,
          ),
      duration: kThemeChangeDuration,
      child: this.retryButtonText ?? const Text('Retry'),
    );

    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        errorIcon,
        titleText,
        ElevatedButton(
          onPressed: onRetryPressed,
          child: retryButtonText,
        ),
      ],
    );
  }
}
