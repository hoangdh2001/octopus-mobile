import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/sign_up/bloc/sign_up_bloc.dart';
import 'package:octopus/widgets/screen_header.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.email});

  final String email;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscureText = true;

  @override
  void initState() {
    getIt<SignUpBloc>().add(Init(widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "Sign up",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First name',
                    style: OctopusTheme.of(context)
                        .textTheme
                        .secondaryGreyLabelSecondary,
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'First name',
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
                      ),
                      cursorColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      enableSuggestions: true,
                      autocorrect: false,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                      onChanged: (value) {
                        getIt<SignUpBloc>().add(FirstNameChanged(value));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last name',
                    style: OctopusTheme.of(context)
                        .textTheme
                        .secondaryGreyLabelSecondary,
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Last name',
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
                      ),
                      cursorColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      enableSuggestions: true,
                      autocorrect: false,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                      onChanged: (value) {
                        getIt<SignUpBloc>().add(LastNameChanged(value));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
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
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                        bloc: getIt<SignUpBloc>(),
                        builder: (context, state) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                                  OctopusTheme.of(context).textTheme.hint,
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
                                    color: OctopusTheme.of(context)
                                        .colorTheme
                                        .icon,
                                  ),
                                ),
                              ),
                              errorText: state.passwordError
                                  .fold(() => null, (text) => text),
                            ),
                            cursorColor: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                            obscureText: _isObscureText,
                            onChanged: (value) {
                              getIt<SignUpBloc>().add(PasswordChanged(value));
                            },
                            obscuringCharacter: '*',
                            enableSuggestions: false,
                            autocorrect: false,
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody,
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm password',
                    style: OctopusTheme.of(context)
                        .textTheme
                        .secondaryGreyLabelSecondary,
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                        bloc: getIt<SignUpBloc>(),
                        builder: (context, state) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                                  OctopusTheme.of(context).textTheme.hint,
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
                                    color: OctopusTheme.of(context)
                                        .colorTheme
                                        .icon,
                                  ),
                                ),
                              ),
                              errorText: state.confirmPasswordError
                                  .fold(() => null, (text) => text),
                            ),
                            onChanged: (value) {
                              getIt<SignUpBloc>()
                                  .add(ConfirmPasswordChanged(value));
                            },
                            cursorColor: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                            obscureText: _isObscureText,
                            obscuringCharacter: '*',
                            enableSuggestions: false,
                            autocorrect: false,
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody,
                          );
                        }),
                  ),
                ],
              ),
              Container(
                width: 0.9.sw,
                height: 40.h,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: BlocListener<SignUpBloc, SignUpState>(
                  bloc: getIt<SignUpBloc>(),
                  listener: (context, state) {
                    state.successOrFail.fold(() => null, (result) {
                      result.fold((user) {
                        context.go('/');
                      }, (error) => null);
                    });
                  },
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    onPressed: () {
                      getIt<SignUpBloc>().add(const Submitted());
                    },
                    child: const Text('Sign up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
