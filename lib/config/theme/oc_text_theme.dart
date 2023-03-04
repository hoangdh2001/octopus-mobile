import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';
import 'package:octopus/config/theme/oc_text_style.dart';

class OCTextTheme {
  final TextStyle primaryGreyH1;
  final TextStyle primaryGreyH2;
  final TextStyle primaryGreyBody;
  final TextStyle primaryGreyDisableBody;
  final TextStyle navigationTitle;
  final TextStyle primaryGreyBodyBold;
  final TextStyle primaryGreyBodyItalic;
  final TextStyle mediumGreyBody;
  final TextStyle primaryGreyLabelPrimary;
  final TextStyle secondaryGreyLabelPrimary;
  final TextStyle secondaryGreyLabelSecondary;
  final TextStyle secondaryGreyCaption1;
  final TextStyle mediumGreyCaption1;
  final TextStyle hint;
  final TextStyle primaryGreyInput;

  const OCTextTheme({
    required this.primaryGreyH1,
    required this.primaryGreyH2,
    required this.navigationTitle,
    required this.primaryGreyBody,
    required this.primaryGreyDisableBody,
    required this.primaryGreyBodyBold,
    required this.primaryGreyBodyItalic,
    required this.mediumGreyBody,
    required this.primaryGreyLabelPrimary,
    required this.secondaryGreyLabelPrimary,
    required this.secondaryGreyLabelSecondary,
    required this.secondaryGreyCaption1,
    required this.mediumGreyCaption1,
    required this.hint,
    required this.primaryGreyInput,
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
        secondaryGreyCaption1: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.secondaryGrey.lightAppearance,
        ),
        mediumGreyCaption1: OCTextStyle(
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
        secondaryGreyCaption1: OCTextStyle(
          font: styleGuide.caption2,
          color: styleGuide.secondaryGrey.darkAppearance,
        ),
        mediumGreyCaption1: OCTextStyle(
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
      );
}
