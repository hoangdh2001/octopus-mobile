import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/email/bloc/email_bloc.dart';
import 'package:octopus/pages/verify/login_page.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
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
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: OctopusTheme.of(context).colorTheme.icon,
          ),
        ),
        actions: [
          BlocConsumer<EmailBloc, EmailState>(
            bloc: getIt<EmailBloc>(),
            listener: (context, state) {
              state.successOrFail.fold(() => null, (result) {
                result.fold((verifyEmail) {
                  Navigator.pushNamed(
                    context,
                    Routes.VERIFY_LOGIN,
                    arguments: LoginPageArgs(
                      email: verifyEmail.email,
                      verificationType: verifyEmail.verificationType,
                    ),
                  );
                }, (error) => null);
              });
            },
            builder: (context, state) {
              final isEnabled = state.email.isValid;
              return TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: isEnabled
                    ? () {
                        getIt<EmailBloc>().add(const Submitted());
                      }
                    : null,
                child: Text(
                  'email_page.next'.tr(),
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
              'email_page.email_address_label'.tr(),
              style:
                  OctopusTheme.of(context).textTheme.secondaryGreyLabelPrimary,
            ),
            SizedBox(
              width: 0.9.sw,
              child: TextField(
                controller: _emailController,
                onChanged: (email) {
                  getIt<EmailBloc>().add(EmailChanged(email));
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: OctopusTheme.of(context).textTheme.primaryGreyInput,
                cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Text(
              "email_page.email_address_caption".tr(),
              style: OctopusTheme.of(context).textTheme.secondaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }
}
