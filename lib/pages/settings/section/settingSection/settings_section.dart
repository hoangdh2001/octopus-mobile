import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/pages/settings/bloc/settings_bloc.dart';
import 'package:octopus/pages/settings/section/settingSection/cells/app_ver_cell.dart';
import 'package:octopus/pages/settings/section/settingSection/cells/general_cell.dart';
import 'package:octopus/pages/settings/section/settingSection/cells/language_cell.dart';
import 'package:octopus/pages/settings/section/settingSection/cells/logout_cell.dart';
import 'package:octopus/pages/settings/section/settingSection/cells/theme_cell.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.section});

  final SettingSection section;

  String? _title() {
    switch (section) {
      case SettingSection.general:
        return 'setting_page.general_option'.tr();
      case SettingSection.theme:
        return 'setting_page.theme_option'.tr();
      case SettingSection.logout:
        return null;
      case SettingSection.appVer:
        return 'setting_page.more_info'.tr();
      case SettingSection.language:
        return 'setting_page.language_option'.tr();
    }
  }

  List<Widget> cell() {
    switch (section) {
      case SettingSection.general:
        return [const GeneralCell()];
      case SettingSection.theme:
        return [const ThemeCell()];
      case SettingSection.logout:
        return [const LogoutCell()];
      case SettingSection.appVer:
        return [const AppVerCell()];
      case SettingSection.language:
        return [const LanguageCell()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_title() != null)
          SizedBox(
            height: 20.h,
            child: Text(
              _title()!,
              style: OctopusTheme.of(context).textTheme.mediumGreyBody,
            ),
          ),
        ...cell(),
      ],
    );
  }
}
