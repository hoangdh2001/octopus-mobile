import 'package:octopus/core/theme/oc_brand_font.dart';
import 'package:octopus/core/theme/oc_color.dart';

abstract class OCStyleGuide {
  // MARK: Generic fonts
  OCFont get h1;
  OCFont get h2;
  OCFont get title;
  OCFont get body;
  OCFont get bodyBold;
  OCFont get bodyItalic;
  OCFont get caption1;
  OCFont get caption2;
  OCFont get labelPrimary;
  OCFont get labelSecondary;
  OCFont get input;
  OCFont get footnote;
  OCFont get footnoteBold;
  OCFont get hintLarge;

  // MARK: Generic colors
  OCColor get brandPrimary;
  OCColor get brandPrimarySelect;
  OCColor get accentInfo;
  OCColor get primaryGrey;
  OCColor get primaryGreyDisible;
  OCColor get secondaryGrey;
  OCColor get mediumGrey;
  OCColor get lightGrey;
  OCColor get link;
  OCColor get hintColor;
  OCColor get contentView;
  OCColor get icon;
  OCColor get iconBrandPrimary;
  OCColor get navigationTitle;
  OCColor get border;
  OCColor get cardBackgroundSecondary;
  OCColor get errorColor;
  OCColor get errorBackgroundColor;
  OCColor get errorLightBackgroundColor;
  OCColor get logoutColor;
  OCColor get overlay;
  OCColor get overlayDark;
  OCColor get disabled;
  OCColor get highlight;
  OCColor get bgGray;
}
