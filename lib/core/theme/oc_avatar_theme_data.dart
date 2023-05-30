import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AvatarThemeData with Diagnosticable {
  const AvatarThemeData({
    BoxConstraints? constraints,
    BorderRadius? borderRadius,
  })  : _constraints = constraints,
        _borderRadius = borderRadius;

  final BoxConstraints? _constraints;
  final BorderRadius? _borderRadius;

  BoxConstraints get constraints =>
      _constraints ??
      const BoxConstraints.tightFor(
        height: 32,
        width: 32,
      );

  BorderRadius get borderRadius => _borderRadius ?? BorderRadius.circular(20);

  AvatarThemeData copyWith({
    BoxConstraints? constraints,
    BorderRadius? borderRadius,
  }) =>
      AvatarThemeData(
        constraints: constraints ?? _constraints,
        borderRadius: borderRadius ?? _borderRadius,
      );

  AvatarThemeData lerp(
    AvatarThemeData a,
    AvatarThemeData b,
    double t,
  ) =>
      AvatarThemeData(
        borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t),
        constraints: BoxConstraints.lerp(a.constraints, b.constraints, t),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvatarThemeData &&
          runtimeType == other.runtimeType &&
          _constraints == other._constraints &&
          _borderRadius == other._borderRadius;

  @override
  int get hashCode => _constraints.hashCode ^ _borderRadius.hashCode;

  AvatarThemeData merge(AvatarThemeData? other) {
    if (other == null) return this;
    return copyWith(
      constraints: other._constraints,
      borderRadius: other._borderRadius,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}
