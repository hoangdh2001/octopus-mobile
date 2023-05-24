import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/settings/settings_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';

class AppVerCell extends StatelessWidget {
  const AppVerCell({super.key});

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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: OctopusTheme.of(context).colorTheme.border,
                width: 1,
              ),
            ),
            child: SvgPicture.asset('assets/icons/info.svg'),
          ),
          const Spacer(),
          Text(
            'v0.1',
            style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
          ),
        ],
      ),
    );
  }
}
