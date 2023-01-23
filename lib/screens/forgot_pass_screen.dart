import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
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
              child: SvgPicture.asset('assets/icons/arrow-left.svg'),
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
                const Text(
                  'Password Recovery',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To restore please enter your registered email',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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
                    onPressed: () {},
                    child: const Text('Continue with email'),
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
