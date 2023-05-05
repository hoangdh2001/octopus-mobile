import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class VisibleFootnote extends StatelessWidget {
  const VisibleFootnote({super.key});

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/eye-off.svg',
          color: chatThemeData.colorTheme.primaryGrey,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text('Only visible to you',
            style: chatThemeData.textTheme.primaryGreyFootnote),
      ],
    );
  }
}
