import 'package:flutter/material.dart';

class OCFont {
  final String fontName;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  const OCFont({
    required this.fontName,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
  });
}

abstract class OCBrandFont {
  OCFont main(double size);
  OCFont bold(double size);
  OCFont medium(double size);
  OCFont italic(double size);
  OCFont boldItalic(double size);
}

class _OCBaseBrandFont extends OCBrandFont {
  @override
  OCFont bold(double size) =>
      OCFont(fontName: 'Inter', fontSize: size, fontWeight: FontWeight.bold);

  @override
  OCFont boldItalic(double size) => OCFont(fontName: 'Inter', fontSize: size, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

  @override
  OCFont italic(double size) => OCFont(fontName: 'Inter', fontSize: size, fontStyle: FontStyle.italic);

  @override
  OCFont main(double size) => OCFont(fontName: 'Inter', fontSize: size);

  @override
  OCFont medium(double size) => OCFont(fontName: 'Inter', fontSize: size, fontWeight: FontWeight.w500);
}

class OCBrandFontFactory {
  OCBrandFont base() => _OCBaseBrandFont();
}
