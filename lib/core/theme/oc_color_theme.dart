import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_style_guide.dart';

class OCColorTheme {
  final Color brandPrimary;

  final Color brandPrimarySelect;

  final Color accentInfo;

  final Color primaryGrey;

  final Color secondaryGrey;

  final Color mediumGrey;

  final Color lightGrey;

  final Color link;

  final Color hintColor;

  final Color contentView;

  final Color icon;

  final Color border;

  final Color cardBackgroundSecondary;

  final Color error;

  final Color errorBackgroundColor;

  final Color errorLightBackgroundColor;

  final Color overlay;

  final Color overlayDark;

  final Color disabled;

  final Color highlight;

  final Color contentViewSecondary;

  final Color iconBrandPrimary;

  const OCColorTheme({
    required this.brandPrimary,
    required this.brandPrimarySelect,
    required this.accentInfo,
    required this.primaryGrey,
    required this.secondaryGrey,
    required this.mediumGrey,
    required this.lightGrey,
    required this.link,
    required this.hintColor,
    required this.contentView,
    required this.icon,
    required this.border,
    required this.cardBackgroundSecondary,
    required this.error,
    required this.errorBackgroundColor,
    required this.errorLightBackgroundColor,
    required this.overlay,
    required this.overlayDark,
    required this.disabled,
    required this.highlight,
    required this.contentViewSecondary,
    required this.iconBrandPrimary,
  });

  factory OCColorTheme.light({required OCStyleGuide styleGuide}) =>
      OCColorTheme(
        brandPrimary: styleGuide.brandPrimary.lightAppearance,
        brandPrimarySelect: styleGuide.brandPrimarySelect.lightAppearance,
        accentInfo: styleGuide.accentInfo.lightAppearance,
        primaryGrey: styleGuide.primaryGrey.lightAppearance,
        secondaryGrey: styleGuide.primaryGrey.lightAppearance,
        mediumGrey: styleGuide.mediumGrey.lightAppearance,
        lightGrey: styleGuide.lightGrey.lightAppearance,
        link: styleGuide.link.lightAppearance,
        hintColor: styleGuide.hintColor.lightAppearance,
        contentView: styleGuide.contentView.lightAppearance,
        icon: styleGuide.icon.lightAppearance,
        border: styleGuide.border.lightAppearance,
        cardBackgroundSecondary:
            styleGuide.cardBackgroundSecondary.lightAppearance,
        error: styleGuide.errorColor.lightAppearance,
        errorBackgroundColor: styleGuide.errorBackgroundColor.lightAppearance,
        errorLightBackgroundColor:
            styleGuide.errorLightBackgroundColor.lightAppearance,
        overlay: styleGuide.overlay.lightAppearance,
        overlayDark: styleGuide.overlayDark.lightAppearance,
        disabled: styleGuide.disabled.lightAppearance,
        highlight: styleGuide.highlight.lightAppearance,
        contentViewSecondary: styleGuide.bgGray.lightAppearance,
        iconBrandPrimary: styleGuide.iconBrandPrimary.lightAppearance,
      );

  factory OCColorTheme.dark({required OCStyleGuide styleGuide}) => OCColorTheme(
        brandPrimary: styleGuide.brandPrimary.darkAppearance,
        brandPrimarySelect: styleGuide.brandPrimarySelect.darkAppearance,
        accentInfo: styleGuide.accentInfo.darkAppearance,
        primaryGrey: styleGuide.primaryGrey.darkAppearance,
        secondaryGrey: styleGuide.primaryGrey.darkAppearance,
        mediumGrey: styleGuide.primaryGrey.darkAppearance,
        lightGrey: styleGuide.primaryGrey.darkAppearance,
        link: styleGuide.link.darkAppearance,
        hintColor: styleGuide.hintColor.darkAppearance,
        contentView: styleGuide.contentView.darkAppearance,
        icon: styleGuide.icon.darkAppearance,
        border: styleGuide.border.darkAppearance,
        cardBackgroundSecondary:
            styleGuide.cardBackgroundSecondary.darkAppearance,
        error: styleGuide.errorColor.darkAppearance,
        errorBackgroundColor: styleGuide.errorBackgroundColor.darkAppearance,
        errorLightBackgroundColor:
            styleGuide.errorLightBackgroundColor.darkAppearance,
        overlay: styleGuide.overlay.darkAppearance,
        overlayDark: styleGuide.overlayDark.darkAppearance,
        disabled: styleGuide.disabled.darkAppearance,
        highlight: styleGuide.highlight.darkAppearance,
        contentViewSecondary: styleGuide.bgGray.darkAppearance,
        iconBrandPrimary: styleGuide.iconBrandPrimary.darkAppearance,
      );
}
