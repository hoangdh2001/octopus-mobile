import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWithPassScreen extends StatefulWidget {
  const LoginWithPassScreen({super.key});

  @override
  State<LoginWithPassScreen> createState() => _LoginWithPassScreenState();
}

class _LoginWithPassScreenState extends State<LoginWithPassScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "Sign in",
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: OctopusTheme.of(context)
                      .textTheme
                      .secondaryGreyLabelSecondary,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    enableSuggestions: false,
                    autocorrect: false,
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  ),
                ),
              ],
            ),
            Container(
              width: 0.9.sw,
              height: 40.h,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.HOME);
                },
                child: const Text('Sign in'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: () {},
                child: const Text("Don't have password or forgot password?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
