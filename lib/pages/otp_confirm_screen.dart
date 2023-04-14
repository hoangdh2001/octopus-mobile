import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/pages/confirm_password_screen.dart';

class OTPConfirmScreen extends StatefulWidget {
  const OTPConfirmScreen({super.key});

  @override
  State<OTPConfirmScreen> createState() => _OTPConfirmScreenState();
}

class _OTPConfirmScreenState extends State<OTPConfirmScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode1.addListener(() => setState(() {}));
    focusNode2.addListener(() => setState(() {}));
    focusNode3.addListener(() => setState(() {}));
    focusNode4.addListener(() => setState(() {}));
    focusNode5.addListener(() => setState(() {}));

    focusNode1.requestFocus();
  }

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
                Text(
                  'Please enter verify code',
                  style: OctopusTheme.of(context).textTheme.primaryGreyH2,
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                      children: [
                        const TextSpan(
                          text: 'We sent an email with your OTP code to ',
                        ),
                        TextSpan(
                          text: 'huyhoang14901@gmail.com',
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBodyBold,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          width: 60,
                          height: 48,
                          duration: const Duration(milliseconds: 200),
                          decoration: focusNode1.hasFocus
                              ? const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3d6cb33e),
                                  ),
                                ])
                              : null,
                          child: TextFormField(
                            focusNode: focusNode1,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).requestFocus(focusNode2);
                              }
                            },
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          width: 60,
                          height: 48,
                          duration: const Duration(milliseconds: 200),
                          decoration: focusNode2.hasFocus
                              ? const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3d6cb33e),
                                  ),
                                ])
                              : null,
                          child: TextFormField(
                            focusNode: focusNode2,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          width: 60,
                          height: 48,
                          duration: const Duration(milliseconds: 200),
                          decoration: focusNode3.hasFocus
                              ? const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3d6cb33e),
                                  ),
                                ])
                              : null,
                          child: TextFormField(
                            focusNode: focusNode3,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          width: 60,
                          height: 48,
                          duration: const Duration(milliseconds: 200),
                          decoration: focusNode4.hasFocus
                              ? const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3d6cb33e),
                                  ),
                                ])
                              : null,
                          child: TextFormField(
                            focusNode: focusNode4,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          width: 60,
                          height: 48,
                          duration: const Duration(milliseconds: 200),
                          decoration: focusNode5.hasFocus
                              ? const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3d6cb33e),
                                  ),
                                ])
                              : null,
                          child: TextFormField(
                            focusNode: focusNode5,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffDAECCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ConfirmPasswordScreen()));
                    },
                    child: const Text('Verify'),
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
                          text: "Haven't received the code yet? ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8d8c8c),
                          ),
                        ),
                        TextSpan(
                          text: 'Resend',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6b66a5),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(
                          text: " after 60 seconds",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
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
