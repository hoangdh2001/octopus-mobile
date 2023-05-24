import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/settings/settings_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ThemeCell extends StatefulWidget {
  const ThemeCell({super.key});

  @override
  State<ThemeCell> createState() => _ThemeCellState();
}

class _ThemeCellState extends State<ThemeCell> {
  @override
  Widget build(BuildContext context) {
    final currentUser = SettingsPage.of(context).currentUser;
    return Container(
      height: 42.h,
      margin: const EdgeInsets.symmetric(vertical: 5).h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
      ),
      padding: const EdgeInsets.all(6).r,
      child: PreferenceBuilder(
          preference: getIt<StreamingSharedPreferences>().getInt(
            'theme',
            defaultValue: 0,
          ),
          builder: (context, snapshot) {
            final theme = {
              -1: ThemeMode.dark,
              0: ThemeMode.system,
              1: ThemeMode.light,
            }[snapshot];

            return CupertinoSlidingSegmentedControl<ThemeMode>(
              backgroundColor:
                  OctopusTheme.of(context).colorTheme.contentViewSecondary,
              groupValue: theme,
              // Callback that sets the selected segmented control.
              onValueChanged: (ThemeMode? value) {
                if (value != null) {
                  getIt<StreamingSharedPreferences>().setInt(
                      'theme',
                      {
                        ThemeMode.dark: -1,
                        ThemeMode.system: 0,
                        ThemeMode.light: 1,
                      }[value]!);
                }
              },
              children: <ThemeMode, Widget>{
                ThemeMode.dark: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'On',
                    style: theme == ThemeMode.dark
                        ? OctopusTheme.of(context)
                            .textTheme
                            .brandPrimaryBodyBold
                        : OctopusTheme.of(context)
                            .textTheme
                            .primaryGreyBodyBold,
                  ),
                ),
                ThemeMode.light: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Off',
                    style: theme == ThemeMode.light
                        ? OctopusTheme.of(context).textTheme.primaryGreyBodyBold
                        : OctopusTheme.of(context)
                            .textTheme
                            .brandPrimaryBodyBold,
                  ),
                ),
                ThemeMode.system: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Auto',
                    style: theme == ThemeMode.system
                        ? OctopusTheme.of(context).textTheme.primaryGreyBodyBold
                        : OctopusTheme.of(context)
                            .textTheme
                            .brandPrimaryBodyBold,
                  ),
                ),
              },
            );
          }),
    );
  }
}
