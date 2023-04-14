import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_brand_font.dart';

class OCTextStyle extends TextStyle {
  OCTextStyle({required OCFont font, required Color color})
      : super(
          fontFamily: font.fontName,
          fontSize: font.fontSize,
          fontWeight: font.fontWeight,
          fontStyle: font.fontStyle,
          color: color,
        );
}
