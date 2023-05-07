import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/enums/verification_type.dart';
import 'package:octopus/core/data/models/token.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/repositories/user_repository.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/home_page.dart';
import 'package:octopus/pages/options_signin_screen.dart';
import 'package:octopus/pages/verify/bloc/login_bloc.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/widgets/separator_text.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPageArgs {
  const LoginPageArgs({required this.email, required this.verificationType});

  final String email;

  final VerificationType verificationType;
}

class LoginPage extends StatefulWidget {
  const LoginPage(
      {super.key, required this.verificationType, required this.email});

  final VerificationType verificationType;

  final String email;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    getIt<LoginBloc>().add(Initial(widget.email));
    super.initState();
  }

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
            getIt<LoginBloc>().add(const Initial(''));
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: OctopusTheme.of(context).colorTheme.icon,
          ),
        ),
      ),
      bottomNavigationBar: widget.verificationType == VerificationType.login
          ? Container(
              height: 80.h,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              decoration: BoxDecoration(
                color:
                    OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
                border: Border(
                  top: BorderSide(
                    color: OctopusTheme.of(context).colorTheme.border,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOGIN_OPTION);
                },
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                child: const Text("Other sign in options"),
              ),
            )
          : null,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Padding(
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
                        text: widget.email,
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
                BlocConsumer<LoginBloc, LoginState>(
                  bloc: getIt<LoginBloc>(),
                  listener: (context, state) {
                    state.successOfFail.fold(() => null, (result) {
                      result.fold((token) {
                        if (widget.verificationType == VerificationType.login) {
                          _connectUser(token).then((client) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.HOME, (route) => false,
                                arguments: HomePageArgs(client));
                          }).catchError((error) {
                            print(error.toString());
                          });
                        } else {
                          Navigator.pushNamed(
                            context,
                            Routes.SIGNUP,
                            arguments: LoginPageArgs(
                              email: widget.email,
                              verificationType: widget.verificationType,
                            ),
                          );
                        }
                      }, (r) => null);
                    });
                  },
                  builder: (context, state) => state.isShow
                      ? PinCodeTextField(
                          autoFocus: true,
                          onCompleted: (value) {
                            getIt<LoginBloc>()
                                .add(LoginWithOTP(widget.email, value));
                          },
                          appContext: context,
                          length: 4,
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          cursorColor:
                              OctopusTheme.of(context).colorTheme.brandPrimary,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 40.h,
                            fieldWidth: 1.sw / 4 - (5 * 4),
                            borderRadius: BorderRadius.circular(8.r),
                            borderWidth: 1,
                            activeColor:
                                OctopusTheme.of(context).colorTheme.border,
                            inactiveColor:
                                OctopusTheme.of(context).colorTheme.border,
                            selectedColor: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                            errorBorderColor:
                                OctopusTheme.of(context).colorTheme.error,
                          ),
                        )
                      : SizedBox(
                          width: 0.9.sw,
                          height: 40.h,
                          child: TextButton(
                            style: OctopusTheme.of(context)
                                .buttonTheme
                                .buttonPrimaryGreyBorder,
                            onPressed: () {
                              getIt<LoginBloc>().add(const ShowOTPField());
                            },
                            child: const Text('Enter code'),
                          ),
                        ),
                ),
                SizedBox(
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                    onPressed: () {
                      getIt<LoginBloc>().add(ResendCode(widget.email));
                    },
                    child: const Text('Resend code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Client> _connectUser(Token token) async {
    final client = getIt<Client>();

    await client.connectUser(token);
    await getIt<LoginBloc>().handleStorageToken(token);
    final status = await _requestPermission();

    final isEnabled = status == AuthorizationStatus.authorized ||
        status == AuthorizationStatus.provisional;
    if (isEnabled) {
      final deviceInfoPlugin = getIt<DeviceInfoPlugin>();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      final fbToken = await getIt<FirebaseMessaging>().getToken();
      debugPrint(allInfo.toString());
      final platform = Theme.of(context).platform;
      String? name;
      if (platform == TargetPlatform.android) {
        name = '${allInfo['product']}-${allInfo['version']['baseOS']}';
      } else {
        name =
            '${allInfo['utsname']['nodename']}-${allInfo['systemName']}-${allInfo['model']}}';
      }

      debugPrint(name);

      if (fbToken != null) {
        await getIt<LoginBloc>().handleAddDevice(token.user.id, fbToken, name);
      }
    }
    return client;
  }

  Future<AuthorizationStatus> _requestPermission() async {
    final firebaseMessaging = getIt<FirebaseMessaging>();
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus;
  }
}
