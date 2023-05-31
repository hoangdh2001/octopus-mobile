import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/verify/bloc/login_bloc.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWithPassScreen extends StatefulWidget {
  const LoginWithPassScreen({super.key});

  @override
  State<LoginWithPassScreen> createState() => _LoginWithPassScreenState();
}

class _LoginWithPassScreenState extends State<LoginWithPassScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "sign_in_page.sign_in".tr(),
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
                  'sign_in_page.password_label'.tr(),
                  style: OctopusTheme.of(context)
                      .textTheme
                      .secondaryGreyLabelSecondary,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  child: BlocBuilder<LoginBloc, LoginState>(
                    bloc: getIt<LoginBloc>(),
                    builder: (context, state) {
                      return TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'sign_in_page.password_placeholder'.tr(),
                          hintStyle: OctopusTheme.of(context).textTheme.hint,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .brandPrimary,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscureText = !_isObscureText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                      right: 12, top: 10, bottom: 10)
                                  .r,
                              child: SvgPicture.asset(
                                _isObscureText
                                    ? "assets/icons/visibility_off.svg"
                                    : 'assets/icons/visibility.svg',
                                color: OctopusTheme.of(context).colorTheme.icon,
                              ),
                            ),
                          ),
                          errorText: state.passwordError
                              .fold(() => null, (text) => text),
                        ),
                        cursorColor:
                            OctopusTheme.of(context).colorTheme.brandPrimary,
                        obscureText: _isObscureText,
                        obscuringCharacter: '*',
                        enableSuggestions: false,
                        autocorrect: false,
                        style:
                            OctopusTheme.of(context).textTheme.primaryGreyBody,
                      );
                    },
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
                  getIt<LoginBloc>().add(
                    LoginWithPass(getIt<LoginBloc>().state.email,
                        _passwordController.text),
                  );
                },
                child: Text("sign_in_page.sign_in".tr()),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: () {},
                child: Text("sign_in_page.dont_have_account".tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
