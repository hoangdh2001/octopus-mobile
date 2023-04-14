import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class OCMenuItem extends StatelessWidget {
  const OCMenuItem({
    Key? key,
    required this.title,
    required this.urlIcon,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final String urlIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0).r,
      decoration: isSelected
          ? BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: OctopusTheme.of(context).colorTheme.brandPrimary,
                ),
              ),
              color: OctopusTheme.of(context)
                  .colorTheme
                  .brandPrimary
                  .withOpacity(0.2),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: OctopusTheme.of(context).colorTheme.brandPrimary,
            width: 5,
          ),
          SvgPicture.asset(
            urlIcon,
            color: isSelected
                ? OctopusTheme.of(context).colorTheme.brandPrimary
                : OctopusTheme.of(context).colorTheme.icon,
            width: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              title,
              style: isSelected
                  ? OctopusTheme.of(context).textTheme.brandPrimaryBodyBold
                  : OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
            ),
          ),
        ],
      ),
    );
  }
}
