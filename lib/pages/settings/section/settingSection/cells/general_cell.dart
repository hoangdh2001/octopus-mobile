import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/settings/settings_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';

class GeneralCell extends StatelessWidget {
  const GeneralCell({super.key});

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
          UserAvatar(
            user: currentUser!,
            constraints: const BoxConstraints.tightFor(width: 35, height: 35),
            showOnlineStatus: false,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            currentUser.name,
            style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
          ),
        ],
      ),
    );
  }
}
