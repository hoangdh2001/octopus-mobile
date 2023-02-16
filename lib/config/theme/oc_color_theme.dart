import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';

class OCColorTheme {
  final Color brandPrimary;

  final Color brandPrimarySelect;

  final Color primaryGrey;

  final Color secondaryGrey;

  final Color link;

  final Color hintColor;

  final Color contentView;

  final Color icon;

  const OCColorTheme({
    required this.brandPrimary,
    required this.brandPrimarySelect,
    required this.primaryGrey,
    required this.secondaryGrey,
    required this.link,
    required this.hintColor,
    required this.contentView,
    required this.icon,
  });

  factory OCColorTheme.light({required OCStyleGuide styleGuide}) =>
      OCColorTheme(
        brandPrimary: styleGuide.brandPrimary.lightAppearance,
        brandPrimarySelect: styleGuide.brandPrimarySelect.lightAppearance,
        primaryGrey: styleGuide.primaryGrey.lightAppearance,
        secondaryGrey: styleGuide.primaryGrey.lightAppearance,
        link: styleGuide.link.lightAppearance,
        hintColor: styleGuide.hintColor.lightAppearance,
        contentView: styleGuide.contentView.lightAppearance,
        icon: styleGuide.icon.lightAppearance,
      );

  factory OCColorTheme.dark({required OCStyleGuide styleGuide}) => OCColorTheme(
        brandPrimary: styleGuide.brandPrimary.darkAppearance,
        brandPrimarySelect: styleGuide.brandPrimarySelect.darkAppearance,
        primaryGrey: styleGuide.primaryGrey.darkAppearance,
        secondaryGrey: styleGuide.primaryGrey.darkAppearance,
        link: styleGuide.link.darkAppearance,
        hintColor: styleGuide.hintColor.darkAppearance,
        contentView: styleGuide.contentView.darkAppearance,
        icon: styleGuide.icon.darkAppearance,
      );
}
