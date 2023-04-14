import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  const ScreenHeader({
    Key? key,
    required this.title,
    required this.leading,
    this.actions,
  }) : super(key: key);

  final String title;
  final Widget leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      shadowColor: Colors.transparent,
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title,
        style: OctopusTheme.of(context).textTheme.navigationTitle,
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(42.h);
}
