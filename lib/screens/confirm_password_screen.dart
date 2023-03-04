import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';

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
                  'Enter your new password',
                  style: OctopusTheme.of(context).textTheme.primaryGreyH1,
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
                    decoration: InputDecoration(
                      hintText: 'name@company',
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      border: InputBorder.none,
                    ),
                    style: OctopusTheme.of(context)
                        .textTheme
                        .primaryGreyDisableBody,
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
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
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
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    onPressed: () {},
                    child: const Text('Change password'),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextButton(
                    style: OctopusTheme.of(context)
                        .buttonTheme
                        .secondaryPrimaryButton,
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
