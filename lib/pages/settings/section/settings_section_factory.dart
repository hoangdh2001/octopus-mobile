import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/pages/settings/bloc/settings_bloc.dart';
import 'package:octopus/pages/settings/section/settingSection/settings_section.dart';

@singleton
class SettingsSectionFactory {
  Widget createSection(SettingSection section) {
    switch (section) {
      case SettingSection.general:
      case SettingSection.logout:
        return SettingsSection(section: section);
      default:
        return Container();
    }
  }
}
