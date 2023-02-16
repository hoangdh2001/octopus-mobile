import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';
import 'package:octopus/config/theme/oc_text_style.dart';

class OCTextTheme {
  final TextStyle primaryGreyH1;
  final TextStyle primaryGreyH2;
  final TextStyle primaryGreyBody;
  final TextStyle primaryGreyDisableBody;
  final TextStyle primaryGreyBodyBold;
  final TextStyle primaryGreyBodyItalic;
  final TextStyle primaryGreyLabelPrimary;
  final TextStyle hint;

  const OCTextTheme({
    required this.primaryGreyH1,
    required this.primaryGreyH2,
    required this.primaryGreyBody,
    required this.primaryGreyDisableBody,
    required this.primaryGreyBodyBold,
    required this.primaryGreyBodyItalic,
    required this.primaryGreyLabelPrimary,
    required this.hint,
  });

  factory OCTextTheme.light({required OCStyleGuide styleGuide}) => OCTextTheme(
        primaryGreyH1: OCTextStyle(
          font: styleGuide.h1,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyH2: OCTextStyle(
          font: styleGuide.h2,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyDisableBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.primaryGreyDisible.lightAppearance,
        ),
        primaryGreyBodyBold: OCTextStyle(
          font: styleGuide.bodyBold,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyBodyItalic: OCTextStyle(
          font: styleGuide.bodyItalic,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.label,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        hint: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.hintColor.lightAppearance,
        ),
      );

  factory OCTextTheme.dark({required OCStyleGuide styleGuide}) => OCTextTheme(
        primaryGreyH1: OCTextStyle(
          font: styleGuide.h1,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyH2: OCTextStyle(
          font: styleGuide.h2,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyBodyBold: OCTextStyle(
          font: styleGuide.bodyBold,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyDisableBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.primaryGreyDisible.darkAppearance,
        ),
        primaryGreyBodyItalic: OCTextStyle(
          font: styleGuide.bodyItalic,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.label,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        hint: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.hintColor.darkAppearance,
        ),
      );
}
