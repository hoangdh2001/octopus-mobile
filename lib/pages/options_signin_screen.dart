import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsSignInScreen extends StatefulWidget {
  const OptionsSignInScreen({super.key});

  @override
  State<OptionsSignInScreen> createState() => _OptionsSignInScreenState();
}

class _OptionsSignInScreenState extends State<OptionsSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "SSO Login",
        leading: IconButton(
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: OctopusTheme.of(context).colorTheme.icon,
          ),
        ),
      ),
      body: Container(
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Other sign in methods available",
              style: OctopusTheme.of(context).textTheme.primaryGreyBody,
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: 0.9.sw,
              height: 40.h,
              child: TextButton(
                style: OctopusTheme.of(context)
                    .buttonTheme
                    .buttonPrimaryGreyBorder,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOGIN_WITH_PASS);
                },
                child: const Text('Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
