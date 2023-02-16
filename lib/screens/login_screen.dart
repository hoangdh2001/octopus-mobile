import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/screens/login_with_pass_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            left: 16.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/icons/close.svg',
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
                  width: 0.5.sw,
                  margin: const EdgeInsets.only(bottom: 30).w,
                  child: Image.asset(
                    OctopusTheme.of(context).logo,
                  ),
                ),
                SizedBox(
                  width: 0.8.sw,
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
                          borderRadius: BorderRadius.circular(20).r,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('assets/icons/google.svg'),
                        const Text('Log in with Google'),
                        Container(width: 20.w),
                      ],
                    ),
                  ),
                ),
                Container(height: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: OctopusTheme.of(context)
                          .textTheme
                          .primaryGreyLabelPrimary,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 0.8.sw,
                      height: 30.h,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffeaeaea)),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'name@company',
                          hintStyle: OctopusTheme.of(context).textTheme.hint,
                          border: InputBorder.none,
                        ),
                        style:
                            OctopusTheme.of(context).textTheme.primaryGreyBody,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 0.8.sw,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginWithPassScreen(),
                        ),
                      );
                    },
                    child: const Text('Continue with email'),
                  ),
                ),
                Container(
                  width: 0.8.sw,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8d8c8c),
                      ),
                      children: [
                        TextSpan(
                          text: 'By continuing, you agree to the ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff8d8c8c),
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff8d8c8c),
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
