import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeparatorText extends StatelessWidget {
  const SeparatorText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: (0.5).h,
            color: OctopusTheme.of(context).colorTheme.border,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: Text(
            text,
            style: OctopusTheme.of(context).textTheme.primaryGreyBody,
          ),
        ),
        Expanded(
          child: Container(
            height: (0.5).h,
            color: OctopusTheme.of(context).colorTheme.border,
          ),
        ),
      ],
    );
  }
}
