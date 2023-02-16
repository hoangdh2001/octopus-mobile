import 'package:flutter/material.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';

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
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
          color: Color(0xffdfdeda),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SIGN_UP);
                },
                child: const Text('Sign up'),
              ),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: TextButton(
                style:
                    OctopusTheme.of(context).buttonTheme.secondaryPrimaryButton,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOGIN);
                },
                child: const Text('Log in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
