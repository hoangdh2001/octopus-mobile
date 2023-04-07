import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/blocs/verify_email/bloc/verify_email_bloc.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/screens/notification_email_screen.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "Email",
        leading: IconButton(
          splashColor: Colors.transparent,
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: OctopusTheme.of(context).colorTheme.icon,
          ),
        ),
        actions: [
          BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
            bloc: getIt<VerifyEmailBloc>(),
            builder: (context, state) {
              final isEnabled =
                  state is VerifyEmailChangedState && state.email.isValid;
              return TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: isEnabled
                    ? () {
                        getIt<VerifyEmailBloc>()
                            .add(VerifyEmailSubmited(_emailController.text));
                        context.push('/login/verify');
                      }
                    : null,
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 13.sp),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your email address',
              style:
                  OctopusTheme.of(context).textTheme.secondaryGreyLabelPrimary,
            ),
            SizedBox(
              width: 0.9.sw,
              child: TextField(
                controller: _emailController,
                onChanged: (email) =>
                    getIt<VerifyEmailBloc>().add(VerifyEmailChanged(email)),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: OctopusTheme.of(context).textTheme.primaryGreyInput,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Text(
              "We'll send you an email to confirm you address",
              style: OctopusTheme.of(context).textTheme.secondaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }
}
