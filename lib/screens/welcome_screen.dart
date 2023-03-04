import 'package:flutter/material.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        width: double.infinity,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 0.9.sw,
              height: 40.h,
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOGIN);
                },
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
