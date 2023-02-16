import 'package:octopus/config/theme/oc_brand_font.dart';
import 'package:octopus/config/theme/oc_color.dart';

abstract class OCStyleGuide {
  // MARK: Generic fonts
  OCFont get h1;
  OCFont get h2;
  OCFont get body;
  OCFont get bodyBold;
  OCFont get bodyItalic;
  OCFont get label;

  // MARK: Generic colors
  OCColor get brandPrimary;
  OCColor get brandPrimarySelect;
  OCColor get primaryGrey;
  OCColor get primaryGreyDisible;
  OCColor get secondaryGrey;
  OCColor get link;
  OCColor get hintColor;
  OCColor get contentView;
  OCColor get icon;
}
