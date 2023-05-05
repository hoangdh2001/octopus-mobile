import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_avatar_theme_data.dart';

class ChannelPreviewThemeData with Diagnosticable {
  const ChannelPreviewThemeData({
    this.titleStyle,
    this.subtitleStyle,
    this.lastMessageAtStyle,
    this.avatarTheme,
    this.unreadCounterColor,
    this.indicatorIconSize,
  });

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  final TextStyle? lastMessageAtStyle;

  final AvatarThemeData? avatarTheme;

  final Color? unreadCounterColor;

  final double? indicatorIconSize;

  ChannelPreviewThemeData copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? lastMessageAtStyle,
    AvatarThemeData? avatarTheme,
    Color? unreadCounterColor,
    double? indicatorIconSize,
  }) =>
      ChannelPreviewThemeData(
        titleStyle: titleStyle ?? this.titleStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        lastMessageAtStyle: lastMessageAtStyle ?? this.lastMessageAtStyle,
        avatarTheme: avatarTheme ?? this.avatarTheme,
        unreadCounterColor: unreadCounterColor ?? this.unreadCounterColor,
        indicatorIconSize: indicatorIconSize ?? this.indicatorIconSize,
      );

  ChannelPreviewThemeData lerp(
    ChannelPreviewThemeData a,
    ChannelPreviewThemeData b,
    double t,
  ) =>
      ChannelPreviewThemeData(
        avatarTheme:
            const AvatarThemeData().lerp(a.avatarTheme!, b.avatarTheme!, t),
        indicatorIconSize: a.indicatorIconSize,
        lastMessageAtStyle:
            TextStyle.lerp(a.lastMessageAtStyle, b.lastMessageAtStyle, t),
        subtitleStyle: TextStyle.lerp(a.subtitleStyle, b.subtitleStyle, t),
        titleStyle: TextStyle.lerp(a.titleStyle, b.titleStyle, t),
        unreadCounterColor:
            Color.lerp(a.unreadCounterColor, b.unreadCounterColor, t),
      );

  ChannelPreviewThemeData merge(ChannelPreviewThemeData? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
      subtitleStyle:
          subtitleStyle?.merge(other.subtitleStyle) ?? other.subtitleStyle,
      lastMessageAtStyle: lastMessageAtStyle?.merge(other.lastMessageAtStyle) ??
          other.lastMessageAtStyle,
      avatarTheme: avatarTheme?.merge(other.avatarTheme) ?? other.avatarTheme,
      unreadCounterColor: other.unreadCounterColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelPreviewThemeData &&
          runtimeType == other.runtimeType &&
          titleStyle == other.titleStyle &&
          subtitleStyle == other.subtitleStyle &&
          lastMessageAtStyle == other.lastMessageAtStyle &&
          avatarTheme == other.avatarTheme &&
          unreadCounterColor == other.unreadCounterColor &&
          indicatorIconSize == other.indicatorIconSize;

  @override
  int get hashCode =>
      titleStyle.hashCode ^
      subtitleStyle.hashCode ^
      lastMessageAtStyle.hashCode ^
      avatarTheme.hashCode ^
      unreadCounterColor.hashCode ^
      indicatorIconSize.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleStyle', titleStyle))
      ..add(DiagnosticsProperty('subtitleStyle', subtitleStyle))
      ..add(DiagnosticsProperty('lastMessageAtStyle', lastMessageAtStyle))
      ..add(DiagnosticsProperty('avatarTheme', avatarTheme))
      ..add(ColorProperty('unreadCounterColor', unreadCounterColor));
  }
}
