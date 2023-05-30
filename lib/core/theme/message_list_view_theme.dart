import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class MessageListViewTheme extends InheritedTheme {
  const MessageListViewTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MessageListViewThemeData data;

  /// ```
  static MessageListViewThemeData of(BuildContext context) {
    final messageListViewTheme =
        context.dependOnInheritedWidgetOfExactType<MessageListViewTheme>();
    return messageListViewTheme?.data ??
        OctopusTheme.of(context).messageListViewTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) =>
      MessageListViewTheme(data: data, child: child);

  @override
  bool updateShouldNotify(MessageListViewTheme oldWidget) =>
      data != oldWidget.data;
}

class MessageListViewThemeData with Diagnosticable {
  const MessageListViewThemeData({
    this.backgroundColor,
    this.backgroundImage,
  });

  final Color? backgroundColor;

  final DecorationImage? backgroundImage;

  MessageListViewThemeData copyWith({
    Color? backgroundColor,
    DecorationImage? backgroundImage,
  }) =>
      MessageListViewThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundImage: backgroundImage ?? this.backgroundImage,
      );

  MessageListViewThemeData lerp(
    MessageListViewThemeData a,
    MessageListViewThemeData b,
    double t,
  ) =>
      MessageListViewThemeData(
        backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
        backgroundImage: t < 0.5 ? a.backgroundImage : b.backgroundImage,
      );

  /// Merges one [MessageListViewThemeData] with another.
  MessageListViewThemeData merge(MessageListViewThemeData? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      backgroundImage: other.backgroundImage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageListViewThemeData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          backgroundImage == other.backgroundImage;

  @override
  int get hashCode => backgroundColor.hashCode + backgroundImage.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(
        DiagnosticsProperty<DecorationImage>(
          'backgroundImage',
          backgroundImage,
          defaultValue: null,
        ),
      );
  }
}
