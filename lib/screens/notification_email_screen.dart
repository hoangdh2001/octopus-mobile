import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/screens/options_signin_screen.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/widgets/separator_text.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NotificationEmailScreen extends StatefulWidget {
  const NotificationEmailScreen({super.key});

  @override
  State<NotificationEmailScreen> createState() =>
      _NotificationEmailScreenState();
}

class _NotificationEmailScreenState extends State<NotificationEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "",
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
      bottomNavigationBar: Container(
        height: 80.h,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
          border: Border(
            top: BorderSide(
              color: OctopusTheme.of(context).colorTheme.border,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OptionsSignInScreen(),
              ),
            );
          },
          style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
          child: const Text("Other sign in options"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                'assets/images/email.png',
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "We've sent you an email",
                style: OctopusTheme.of(context).textTheme.primaryGreyH1,
              ),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  children: [
                    const TextSpan(text: 'Go to your email to open link in '),
                    TextSpan(
                      text: 'huyhoang14901@gmail.com',
                      style: OctopusTheme.of(context)
                          .textTheme
                          .primaryGreyBodyBold,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                width: 0.9.sw,
                height: 40.h,
                child: TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                  onPressed: () async {
                    var result = await OpenMailApp.getMailApps();
                    showDialog(
                      context: context,
                      builder: (_) {
                        return MailAppPickerDialog(
                          mailApps: result,
                          title: 'Choose Mail App',
                        );
                      },
                    );
                  },
                  child: const Text('Open Email App'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15).r,
                child: const SeparatorText(text: "OR"),
              ),
              SizedBox(
                width: 0.9.sw,
                height: 40.h,
                child: TextButton(
                  style: OctopusTheme.of(context)
                      .buttonTheme
                      .buttonPrimaryGreyBorder,
                  onPressed: () {},
                  child: const Text('Enter code'),
                ),
              ),
              SizedBox(
                child: TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                  onPressed: () {},
                  child: const Text('Resend code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
