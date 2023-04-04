import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_color.dart';
import 'package:octopus/config/theme/oc_brand_font.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OCBaseStyleGuide extends OCStyleGuide {
  final OCBrandFont _brandFont = OCBrandFontFactory().base();

  @override
  OCFont get h1 => _brandFont.medium(18.sp);

  @override
  OCFont get h2 => _brandFont.bold(15.sp);

  @override
  OCFont get title => _brandFont.medium(16.sp);

  @override
  OCFont get body => _brandFont.main(13.sp);

  @override
  OCFont get bodyBold => _brandFont.bold(13.sp);

  @override
  OCFont get bodyItalic => _brandFont.italic(13.sp);

  @override
  OCFont get caption1 => _brandFont.main(11.sp);

  @override
  OCFont get caption2 => _brandFont.main(10.sp);

  @override
  OCFont get labelPrimary => _brandFont.main(15.sp);

  @override
  OCFont get labelSecondary => _brandFont.main(12.sp);

  @override
  OCFont get input => _brandFont.main(16.sp);

  @override
  OCColor get brandPrimary => const OCColor(
      lightAppearance: Color(0xFF7C68EC), darkAppearance: Color(0xFF7C68EC));

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
  OCColor get mediumGrey => const OCColor(
      lightAppearance: Color(0xFFCCCCCC), darkAppearance: Color(0xFFCCCCCC));

  @override
  OCColor get lightGrey => const OCColor(
      lightAppearance: Color(0xFFEDEDED), darkAppearance: Color(0xFFEDEDED));

  @override
  OCColor get link => const OCColor(
      lightAppearance: Color(0xFF1F9BE1), darkAppearance: Color(0xFF77C8ED));

  @override
  OCColor get hintColor => const OCColor(
      lightAppearance: Color(0xffa6a6a6), darkAppearance: Color(0xffa6a6a6));

  @override
  OCColor get contentView => const OCColor(
      lightAppearance: Colors.white, darkAppearance: Color(0xFF121212));

  @override
  OCColor get icon => const OCColor(
      lightAppearance: Colors.black, darkAppearance: Colors.white);

  @override
  OCColor get navigationTitle => const OCColor(
      lightAppearance: Color(0xFF404040), darkAppearance: Color(0xFFF5F5F5));

  @override
  OCColor get border => const OCColor(
      lightAppearance: Color(0xFFC8C8C8),
      darkAppearance: Color.fromARGB(255, 131, 131, 131));

  @override
  OCColor get cardBackgroundSecondary => const OCColor(
      lightAppearance: Color(0xFFF6F8FA), darkAppearance: Color(0xFF121212));
}
