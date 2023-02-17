import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/screens/notification_email_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/close.svg'),
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
                    'assets/logo/logo-text-light.png',
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white;
                        }
                        return const Color(0xFFEBEAE8);
                      }),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('assets/icons/google.svg'),
                        const Text('Sign up with Google'),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.8,
                  child: const Text(
                    "What's your email work?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffeaeaea)),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'name@company',
                      hintStyle: TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffeaeaea)),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Password (8 - 32 char)',
                      hintStyle: TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffeaeaea)),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      hintStyle: TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 20),
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
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationEmailScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign up'),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8d8c8c),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Already use Octopus? ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8d8c8c),
                          ),
                        ),
                        TextSpan(
                          text: 'Log in',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6b66a5),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, Routes.LOGIN),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
