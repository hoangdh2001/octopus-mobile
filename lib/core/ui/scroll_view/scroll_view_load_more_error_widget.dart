import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ScrollViewLoadMoreError extends StatelessWidget {
  const ScrollViewLoadMoreError.list({
    super.key,
    this.error,
    this.errorStyle,
    this.errorIcon,
    this.backgroundColor,
    required this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : _isList = true;

  const ScrollViewLoadMoreError.grid({
    super.key,
    this.error,
    this.errorStyle,
    this.errorIcon,
    this.backgroundColor,
    required this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : _isList = false;

  final Widget? error;

  final TextStyle? errorStyle;

  final Widget? errorIcon;

  final Color? backgroundColor;

  final GestureTapCallback onTap;

  final EdgeInsetsGeometry padding;

  final MainAxisSize mainAxisSize;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  final bool _isList;

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);

    final errorText = AnimatedDefaultTextStyle(
      style: errorStyle ??
          theme.textTheme.primaryGreyBody.copyWith(color: Colors.white),
      duration: kThemeChangeDuration,
      child: error ?? const SizedBox(),
    );

    final errorIcon = AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: this.errorIcon ??
          SvgPicture.asset('assets/icons/retry.dart', color: Colors.white),
    );

    final backgroundColor =
        this.backgroundColor ?? theme.colorTheme.primaryGrey.withOpacity(0.9);

    final children = [errorText, errorIcon];

    return InkWell(
      onTap: onTap,
      child: ColoredBox(
        color: backgroundColor,
        child: Padding(
          padding: padding,
          child: _isList
              ? Row(
                  mainAxisSize: mainAxisSize,
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                )
              : Column(
                  mainAxisSize: mainAxisSize,
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
        ),
      ),
    );
  }
}
