import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_avatar_theme_data.dart';

class ChannelHeaderTheme with Diagnosticable {
  const ChannelHeaderTheme({
    this.titleStyle,
    this.subtitleStyle,
    this.avatarTheme,
    this.color,
  });

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  final AvatarThemeData? avatarTheme;

  final Color? color;

  ChannelHeaderTheme copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    AvatarThemeData? avatarTheme,
    Color? color,
  }) =>
      ChannelHeaderTheme(
        titleStyle: titleStyle ?? this.titleStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        avatarTheme: avatarTheme ?? this.avatarTheme,
        color: color ?? this.color,
      );

  ChannelHeaderTheme lerp(
    ChannelHeaderTheme a,
    ChannelHeaderTheme b,
    double t,
  ) =>
      ChannelHeaderTheme(
        titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
        subtitleStyle: TextStyle.lerp(a.subtitleStyle, b.subtitleStyle, t),
        avatarTheme:
            const AvatarThemeData().lerp(a.avatarTheme!, b.avatarTheme!, t),
        color: Color.lerp(a.color, b.color, t),
      );

  ChannelHeaderTheme merge(ChannelHeaderTheme? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
      subtitleStyle:
          subtitleStyle?.merge(other.subtitleStyle) ?? other.subtitleStyle,
      avatarTheme: avatarTheme?.merge(other.avatarTheme) ?? other.avatarTheme,
      color: other.color,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelHeaderTheme &&
          runtimeType == other.runtimeType &&
          titleStyle == other.titleStyle &&
          subtitleStyle == other.subtitleStyle &&
          avatarTheme == other.avatarTheme &&
          color == other.color;

  @override
  int get hashCode =>
      titleStyle.hashCode ^
      subtitleStyle.hashCode ^
      avatarTheme.hashCode ^
      color.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', titleStyle))
      ..add(DiagnosticsProperty('subtitle', subtitleStyle))
      ..add(DiagnosticsProperty('avatarTheme', avatarTheme))
      ..add(ColorProperty('color', color));
  }
}
