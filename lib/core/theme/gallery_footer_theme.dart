import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class GalleryFooterTheme extends InheritedTheme {
  const GalleryFooterTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final GalleryFooterThemeData data;

  static GalleryFooterThemeData of(BuildContext context) {
    final imageFooterTheme =
        context.dependOnInheritedWidgetOfExactType<GalleryFooterTheme>();
    return imageFooterTheme?.data ??
        OctopusTheme.of(context).galleryFooterTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) =>
      GalleryFooterTheme(data: data, child: child);

  @override
  bool updateShouldNotify(GalleryFooterTheme oldWidget) =>
      data != oldWidget.data;
}

class GalleryFooterThemeData with Diagnosticable {
  const GalleryFooterThemeData({
    this.backgroundColor,
    this.shareIconColor,
    this.titleTextStyle,
    this.gridIconButtonColor,
    this.bottomSheetBarrierColor,
    this.bottomSheetBackgroundColor,
    this.bottomSheetPhotosTextStyle,
    this.bottomSheetCloseIconColor,
  });

  final Color? backgroundColor;

  final Color? shareIconColor;

  final TextStyle? titleTextStyle;

  final Color? gridIconButtonColor;

  final Color? bottomSheetBarrierColor;

  final Color? bottomSheetBackgroundColor;

  final TextStyle? bottomSheetPhotosTextStyle;

  final Color? bottomSheetCloseIconColor;

  GalleryFooterThemeData copyWith({
    Color? backgroundColor,
    Color? shareIconColor,
    TextStyle? titleTextStyle,
    Color? gridIconButtonColor,
    Color? bottomSheetBarrierColor,
    Color? bottomSheetBackgroundColor,
    TextStyle? bottomSheetPhotosTextStyle,
    Color? bottomSheetCloseIconColor,
  }) =>
      GalleryFooterThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        shareIconColor: shareIconColor ?? this.shareIconColor,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        gridIconButtonColor: gridIconButtonColor ?? this.gridIconButtonColor,
        bottomSheetBarrierColor:
            bottomSheetBarrierColor ?? this.bottomSheetBarrierColor,
        bottomSheetBackgroundColor:
            bottomSheetBackgroundColor ?? this.bottomSheetBackgroundColor,
        bottomSheetPhotosTextStyle:
            bottomSheetPhotosTextStyle ?? this.bottomSheetPhotosTextStyle,
        bottomSheetCloseIconColor:
            bottomSheetCloseIconColor ?? this.bottomSheetCloseIconColor,
      );

  GalleryFooterThemeData lerp(
    GalleryFooterThemeData a,
    GalleryFooterThemeData b,
    double t,
  ) =>
      GalleryFooterThemeData(
        backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
        shareIconColor: Color.lerp(a.shareIconColor, b.shareIconColor, t),
        titleTextStyle: TextStyle.lerp(a.titleTextStyle, b.titleTextStyle, t),
        gridIconButtonColor:
            Color.lerp(a.gridIconButtonColor, b.gridIconButtonColor, t),
        bottomSheetBarrierColor:
            Color.lerp(a.bottomSheetBarrierColor, b.bottomSheetBarrierColor, t),
        bottomSheetBackgroundColor: Color.lerp(
          a.bottomSheetBackgroundColor,
          b.bottomSheetBackgroundColor,
          t,
        ),
        bottomSheetPhotosTextStyle: TextStyle.lerp(
          a.bottomSheetPhotosTextStyle,
          b.bottomSheetPhotosTextStyle,
          t,
        ),
        bottomSheetCloseIconColor: Color.lerp(
          a.bottomSheetCloseIconColor,
          b.bottomSheetCloseIconColor,
          t,
        ),
      );

  GalleryFooterThemeData merge(GalleryFooterThemeData? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      bottomSheetBarrierColor: other.bottomSheetBarrierColor,
      bottomSheetBackgroundColor: other.bottomSheetBackgroundColor,
      bottomSheetCloseIconColor: other.bottomSheetCloseIconColor,
      bottomSheetPhotosTextStyle: other.bottomSheetPhotosTextStyle,
      gridIconButtonColor: other.gridIconButtonColor,
      titleTextStyle: other.titleTextStyle,
      shareIconColor: other.shareIconColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryFooterThemeData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          shareIconColor == other.shareIconColor &&
          titleTextStyle == other.titleTextStyle &&
          gridIconButtonColor == other.gridIconButtonColor &&
          bottomSheetBarrierColor == other.bottomSheetBarrierColor &&
          bottomSheetBackgroundColor == other.bottomSheetBackgroundColor &&
          bottomSheetPhotosTextStyle == other.bottomSheetPhotosTextStyle &&
          bottomSheetCloseIconColor == other.bottomSheetCloseIconColor;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      shareIconColor.hashCode ^
      titleTextStyle.hashCode ^
      gridIconButtonColor.hashCode ^
      bottomSheetBarrierColor.hashCode ^
      bottomSheetBackgroundColor.hashCode ^
      bottomSheetPhotosTextStyle.hashCode ^
      bottomSheetCloseIconColor.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('shareIconColor', shareIconColor))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(ColorProperty('gridIconButtonColor', gridIconButtonColor))
      ..add(ColorProperty('bottomSheetBarrierColor', bottomSheetBarrierColor))
      ..add(ColorProperty(
        'bottomSheetBackgroundColor',
        bottomSheetBackgroundColor,
      ))
      ..add(DiagnosticsProperty(
        'bottomSheetPhotosTextStyle',
        bottomSheetPhotosTextStyle,
      ))
      ..add(ColorProperty(
        'bottomSheetCloseIconColor',
        bottomSheetCloseIconColor,
      ));
  }
}
