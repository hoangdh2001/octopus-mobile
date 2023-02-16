import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/screens/forgot_pass_screen.dart';
import 'package:octopus/screens/notification_email_screen.dart';

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
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                color: OctopusTheme.of(context).colorTheme.icon,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.5,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    OctopusTheme.of(context).logo,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: OctopusTheme.of(context)
                          .textTheme
                          .primaryGreyLabelPrimary,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: size.width * 0.8,
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffeaeaea)),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          hintStyle: OctopusTheme.of(context).textTheme.hint,
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        obscuringCharacter: '*',
                        enableSuggestions: false,
                        autocorrect: false,
                        style:
                            OctopusTheme.of(context).textTheme.primaryGreyBody,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Text(
                          'Forgot password?',
                          style:
                              TextStyle(color: Color(0xFF1F9BE1), fontSize: 12),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ForgotPassScreen()));
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          'Log in with email',
                          style:
                              TextStyle(color: Color(0xFF1F9BE1), fontSize: 12),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationEmailScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.HOME);
                    },
                    child: const Text('Log in'),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8d8c8c),
                      ),
                      children: [
                        TextSpan(
                          text: 'By continuing, you agree to the ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8d8c8c),
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff8d8c8c),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
