import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/screens/otp_confirm_screen.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
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
                  'Enter your new password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                  child: TextFormField(
                    initialValue: 'huyhoang14901@gmail.com',
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'name@company',
                      hintStyle: TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
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
                  child: TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'New password (8 - 32 char)',
                      hintStyle: const TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    style: const TextStyle(
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
                  child: TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      hintStyle: const TextStyle(color: Color(0xffa6a6a6)),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.only(top: 20),
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
                    child: const Text('Change password'),
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
                          return const Color(0x3dEBEAE8);
                        }
                        return const Color(0xffEBEAE8);
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
                    child: const Text('Cancel'),
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
