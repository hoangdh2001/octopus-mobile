import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LanguageCell extends StatefulWidget {
  const LanguageCell({super.key});

  @override
  State<LanguageCell> createState() => _LanguageCellState();
}

class _LanguageCellState extends State<LanguageCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5).h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
      ),
      padding: const EdgeInsets.all(5).r,
      child: CupertinoSlidingSegmentedControl<String>(
        backgroundColor:
            OctopusTheme.of(context).colorTheme.contentViewSecondary,
        groupValue: context.locale.languageCode,
        // Callback that sets the selected segmented control.
        onValueChanged: (String? value) {
          if (value != null) {
            context.setLocale(Locale(value));
          }
        },
        children: <String, Widget>{
          'en': Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'setting_page.english_segment'.tr(),
              style: context.locale.languageCode == 'en'
                  ? OctopusTheme.of(context).textTheme.brandPrimaryBodyBold
                  : OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
            ),
          ),
          'vi': Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'setting_page.vietnamese_segment'.tr(),
              style: context.locale.languageCode == 'vi'
                  ? OctopusTheme.of(context).textTheme.brandPrimaryBodyBold
                  : OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
            ),
          ),
        },
      ),
    );
  }
}
