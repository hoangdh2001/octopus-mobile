import 'package:flutter/material.dart';
import 'package:octopus/config/routes/routers.dart';

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
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return const Color(0xff726bb8);
                  }),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SIGN_UP);
                },
                child: const Text('Sign up'),
              ),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white70;
                    }
                    return Colors.white;
                  }),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
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
