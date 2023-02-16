import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_style_guide.dart';

class OCButtonTheme {
  final ButtonStyle brandPrimaryButton;
  final ButtonStyle secondaryPrimaryButton;

  const OCButtonTheme(
      {required this.brandPrimaryButton, required this.secondaryPrimaryButton});

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
              borderRadius: BorderRadius.circular(20),
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
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
              borderRadius: BorderRadius.circular(20),
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
          shape: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20));
            }
            return RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20));
          }),
        ),
      );
}
