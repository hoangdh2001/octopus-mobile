import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/screens/notification_email_screen.dart';
import 'package:octopus/widgets/oc_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: OCHeader(
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
          TextButton(
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationEmailScreen(),
                  ));
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 13.sp),
            ),
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
              style: OctopusTheme.of(context).textTheme.secondaryGreyCaption1,
            ),
          ],
        ),
      ),
    );
  }
}
