import 'package:flutter/material.dart' hide TextTheme;
import 'package:octopus/core/theme/mutipleTheme/oc_base_style_guide.dart';
import 'package:octopus/core/theme/oc_button_theme.dart';
import 'package:octopus/core/theme/oc_color_theme.dart';
import 'package:octopus/core/theme/oc_style_guide.dart';
import 'package:octopus/core/theme/oc_text_theme.dart';

/// {@template octopusTheme}
/// Inherited widget providing the [OctopusThemeData] to the widget tree
/// {@endtemplate}
class OctopusTheme extends InheritedWidget {
  /// {@macro octopusTheme}
  const OctopusTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// {@macro octopusThemeData}
  final OctopusThemeData data;

  @override
  bool updateShouldNotify(OctopusTheme oldWidget) => data != oldWidget.data;

  /// Use this method to get the current [OctopusThemeData] instance
  static OctopusThemeData of(BuildContext context) {
    final ocTheme = context.dependOnInheritedWidgetOfExactType<OctopusTheme>();

    assert(
      ocTheme != null,
      'You must have a StreamChatTheme widget at the top of your widget tree',
    );

    return ocTheme!.data;
  }
}

/// {@template octopusTheme}
/// Theme data for Octopus
/// {@endtemplate}
class OctopusThemeData {
  /// Creates a theme from scratch
  final String logo;
  final OCColorTheme colorTheme;
  final OCTextTheme textTheme;
  final OCButtonTheme buttonTheme;
  final OCStyleGuide styleGuide;

  factory OctopusThemeData({
    Brightness? brightness,
    OCStyleGuide? styleGuide,
    OCColorTheme? colorTheme,
    OCTextTheme? textTheme,
    OCButtonTheme? buttonTheme,
  }) {
    brightness ??= Brightness.light;
    final isDark = brightness == Brightness.dark;
    styleGuide ??= OCBaseStyleGuide();
    final logo = isDark
        ? 'assets/logo/logo-text-dark.png'
        : 'assets/logo/logo-text-light.png';
    colorTheme ??= isDark
        ? OCColorTheme.dark(styleGuide: styleGuide)
        : OCColorTheme.light(styleGuide: styleGuide);
    textTheme ??= isDark
        ? OCTextTheme.dark(styleGuide: styleGuide)
        : OCTextTheme.light(styleGuide: styleGuide);
    buttonTheme ??= isDark
        ? OCButtonTheme.dark(styleGuide: styleGuide)
        : OCButtonTheme.light(styleGuide: styleGuide);

    final defaultTheme = OctopusThemeData.fromTextTheme(
      logo,
      colorTheme,
      textTheme,
      buttonTheme,
      styleGuide,
    );
    return defaultTheme;
  }

  const OctopusThemeData.raw({
    required this.logo,
    required this.colorTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.styleGuide,
  });

  factory OctopusThemeData.fromTextTheme(
    String logo,
    OCColorTheme colorTheme,
    OCTextTheme textTheme,
    OCButtonTheme buttonTheme,
    OCStyleGuide styleGuide,
  ) {
    return OctopusThemeData.raw(
      logo: logo,
      colorTheme: colorTheme,
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      styleGuide: styleGuide,
    );
  }
}
