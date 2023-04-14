import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/settings/bloc/settings_bloc.dart';

class LogoutCell extends StatelessWidget {
  const LogoutCell({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<SettingsBloc>().handleRemoveToken().then((value) {
          Navigator.pop(
            context,
          );
          context.replace('/welcome');
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
              'Logout',
              style: OctopusTheme.of(context).textTheme.logoutColorBody,
            ),
          ],
        ),
      ),
    );
  }
}
