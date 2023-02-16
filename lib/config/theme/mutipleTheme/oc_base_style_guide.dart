import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_color.dart';
import 'package:octopus/config/theme/oc_brand_font.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';

class OCBaseStyleGuide extends OCStyleGuide {
  final OCBrandFont _brandFont = OCBrandFontFactory().base();

  @override
  OCFont get h1 => _brandFont.bold(18);

  @override
  OCFont get h2 => _brandFont.bold(15);

  @override
  OCFont get body => _brandFont.main(13);

  @override
  OCFont get bodyBold => _brandFont.bold(13);

  @override
  OCFont get bodyItalic => _brandFont.italic(13);

  @override
  OCFont get label => _brandFont.main(15);

  @override
  OCColor get brandPrimary => const OCColor(
      lightAppearance: Color(0xFF726BB8), darkAppearance: Color(0xFF726BB8));

  @override
  OCColor get brandPrimarySelect => const OCColor(
      lightAppearance: Color(0xFF584F89), darkAppearance: Color(0xFF584F89));

  @override
  OCColor get primaryGrey => const OCColor(
      lightAppearance: Color(0xFF404040), darkAppearance: Color(0xFFF5F5F5));

  @override
  OCColor get primaryGreyDisible => const OCColor(
      lightAppearance: Color(0xffa6a6a6), darkAppearance: Color(0xffa6a6a6));

  @override
  OCColor get secondaryGrey => const OCColor(
      lightAppearance: Color(0xFF6F6F6F), darkAppearance: Color(0xFF9B9B9B));

  @override
  OCColor get link => const OCColor(
      lightAppearance: Color(0xFF1F9BE1), darkAppearance: Color(0xFF77C8ED));

  @override
  OCColor get hintColor => const OCColor(
      lightAppearance: Color(0xffa6a6a6), darkAppearance: Color(0xffa6a6a6));

  @override
  OCColor get contentView => const OCColor(
      lightAppearance: Colors.white, darkAppearance: Color(0xFF1E1D22));

  @override
  OCColor get icon => const OCColor(
      lightAppearance: Colors.black, darkAppearance: Colors.white);
}
