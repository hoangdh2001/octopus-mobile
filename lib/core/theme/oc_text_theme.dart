import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_style_guide.dart';
import 'package:octopus/core/theme/oc_text_style.dart';

class OCTextTheme {
  final TextStyle brandPrimaryBodyBold;
  final TextStyle primaryGreyH1;
  final TextStyle primaryGreyH2;
  final TextStyle primaryGreyBody;
  final TextStyle primaryGreyDisableBody;
  final TextStyle navigationTitle;
  final TextStyle primaryGreyBodyBold;
  final TextStyle primaryGreyBodyItalic;
  final TextStyle secondaryGreyBody;
  final TextStyle mediumGreyBody;
  final TextStyle primaryGreyLabelPrimary;
  final TextStyle secondaryGreyLabelPrimary;
  final TextStyle secondaryGreyLabelSecondary;
  final TextStyle secondaryGreyCaption2;
  final TextStyle mediumGreyCaption2;
  final TextStyle hint;
  final TextStyle primaryGreyInput;
  final TextStyle logoutColorBody;

  const OCTextTheme({
    required this.brandPrimaryBodyBold,
    required this.primaryGreyH1,
    required this.primaryGreyH2,
    required this.navigationTitle,
    required this.primaryGreyBody,
    required this.primaryGreyDisableBody,
    required this.primaryGreyBodyBold,
    required this.primaryGreyBodyItalic,
    required this.secondaryGreyBody,
    required this.mediumGreyBody,
    required this.primaryGreyLabelPrimary,
    required this.secondaryGreyLabelPrimary,
    required this.secondaryGreyLabelSecondary,
    required this.secondaryGreyCaption2,
    required this.mediumGreyCaption2,
    required this.hint,
    required this.primaryGreyInput,
    required this.logoutColorBody,
  });

  factory OCTextTheme.light({required OCStyleGuide styleGuide}) => OCTextTheme(
        brandPrimaryBodyBold: OCTextStyle(
          font: styleGuide.bodyBold,
          color: styleGuide.brandPrimary.lightAppearance,
        ),
        primaryGreyH1: OCTextStyle(
          font: styleGuide.h1,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        primaryGreyH2: OCTextStyle(
          font: styleGuide.h2,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        navigationTitle: OCTextStyle(
          font: styleGuide.title,
          color: styleGuide.navigationTitle.lightAppearance,
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
        secondaryGreyBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.secondaryGrey.lightAppearance,
        ),
        mediumGreyBody: OCTextStyle(
            font: styleGuide.body,
            color: styleGuide.mediumGrey.lightAppearance),
        primaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.labelPrimary,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        secondaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.labelPrimary,
          color: styleGuide.secondaryGrey.lightAppearance,
        ),
        secondaryGreyLabelSecondary: OCTextStyle(
          font: styleGuide.labelSecondary,
          color: styleGuide.secondaryGrey.lightAppearance,
        ),
        secondaryGreyCaption2: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.secondaryGrey.lightAppearance,
        ),
        mediumGreyCaption2: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.mediumGrey.lightAppearance,
        ),
        hint: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.hintColor.lightAppearance,
        ),
        primaryGreyInput: OCTextStyle(
          font: styleGuide.input,
          color: styleGuide.primaryGrey.lightAppearance,
        ),
        logoutColorBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.logoutColor.lightAppearance,
        ),
      );

  factory OCTextTheme.dark({required OCStyleGuide styleGuide}) => OCTextTheme(
        brandPrimaryBodyBold: OCTextStyle(
          font: styleGuide.bodyBold,
          color: styleGuide.brandPrimary.darkAppearance,
        ),
        primaryGreyH1: OCTextStyle(
          font: styleGuide.h1,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        primaryGreyH2: OCTextStyle(
          font: styleGuide.h2,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        navigationTitle: OCTextStyle(
          font: styleGuide.title,
          color: styleGuide.navigationTitle.darkAppearance,
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
        secondaryGreyBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.secondaryGrey.darkAppearance,
        ),
        mediumGreyBody: OCTextStyle(
            font: styleGuide.body, color: styleGuide.mediumGrey.darkAppearance),
        primaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.labelPrimary,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        secondaryGreyLabelPrimary: OCTextStyle(
          font: styleGuide.labelPrimary,
          color: styleGuide.secondaryGrey.darkAppearance,
        ),
        secondaryGreyLabelSecondary: OCTextStyle(
          font: styleGuide.labelSecondary,
          color: styleGuide.secondaryGrey.darkAppearance,
        ),
        secondaryGreyCaption2: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.secondaryGrey.darkAppearance,
        ),
        mediumGreyCaption2: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.mediumGrey.darkAppearance,
        ),
        hint: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.hintColor.darkAppearance,
        ),
        primaryGreyInput: OCTextStyle(
          font: styleGuide.input,
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        logoutColorBody: OCTextStyle(
          font: styleGuide.body,
          color: styleGuide.logoutColor.darkAppearance,
        ),
      );
}
