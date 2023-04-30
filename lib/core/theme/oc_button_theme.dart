import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_style_guide.dart';

class OCButtonTheme {
  final ButtonStyle brandPrimaryButton;
  final ButtonStyle secondaryPrimaryButton;
  final ButtonStyle buttonBrandPrimary;
  final ButtonStyle buttonPrimaryGreyBorder;
  final ButtonStyle buttonStyleIOS;

  const OCButtonTheme({
    required this.brandPrimaryButton,
    required this.secondaryPrimaryButton,
    required this.buttonBrandPrimary,
    required this.buttonPrimaryGreyBorder,
    required this.buttonStyleIOS,
  });

  factory OCButtonTheme.light({required OCStyleGuide styleGuide}) =>
      OCButtonTheme(
        brandPrimaryButton: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return styleGuide.brandPrimarySelect.lightAppearance;
            }
            return styleGuide.brandPrimary.lightAppearance;
          }),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        secondaryPrimaryButton: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return Colors.white;
          }),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        buttonBrandPrimary: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return styleGuide.brandPrimary.lightAppearance;
          }),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        ),
        buttonPrimaryGreyBorder: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor:
              MaterialStatePropertyAll(styleGuide.primaryGrey.lightAppearance),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(
                color: styleGuide.border.lightAppearance,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        buttonStyleIOS: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: MaterialStatePropertyAll(CupertinoColors.activeBlue),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
      );
  factory OCButtonTheme.dark({required OCStyleGuide styleGuide}) =>
      OCButtonTheme(
        brandPrimaryButton: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return styleGuide.brandPrimarySelect.lightAppearance;
            }
            return styleGuide.brandPrimary.lightAppearance;
          }),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        secondaryPrimaryButton: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return Colors.white;
          }),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10));
              }
              return RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10));
            },
          ),
        ),
        buttonBrandPrimary: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return styleGuide.brandPrimary.darkAppearance;
            },
          ),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        ),
        buttonPrimaryGreyBorder: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor:
              MaterialStatePropertyAll(styleGuide.border.darkAppearance),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(
                color: styleGuide.border.darkAppearance,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        buttonStyleIOS: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: MaterialStatePropertyAll(CupertinoColors.activeBlue),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
      );
}
