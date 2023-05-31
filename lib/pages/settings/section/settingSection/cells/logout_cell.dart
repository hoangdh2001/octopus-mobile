import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/settings/bloc/settings_bloc.dart';
import 'package:octopus/pages/settings/settings_page.dart';
import 'package:octopus/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutCell extends StatelessWidget {
  const LogoutCell({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final client = SettingsPage.of(context).client;
        _logout(client).then((value) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.WELCOME, (route) => false);
        });
      },
      child: Container(
        height: 42.h,
        margin: const EdgeInsets.symmetric(vertical: 5).h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
        ),
        padding: const EdgeInsets.all(6).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/circle_right.svg'),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'setting_page.logout_option'.tr(),
              style: OctopusTheme.of(context).textTheme.logoutColorBody,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(Client client) async {
    await getIt<SettingsBloc>().handleRemoveToken();
    final token = await getIt<FirebaseMessaging>().getToken();
    await getIt<FirebaseMessaging>().deleteToken();
    if (token != null) {
      await client.removeDevice(token);
    }
    getIt<SharedPreferences>().remove(workspaceLocal);
    await client.disconnectUser();
    // await client.dispose();
  }
}
