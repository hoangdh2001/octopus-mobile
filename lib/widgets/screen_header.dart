import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  const ScreenHeader({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.titleSpacing,
    this.backgroundColor,
    this.titleStyle,
    this.iconBackColor,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final bool centerTitle;
  final List<Widget>? actions;
  final double? titleSpacing;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final Color? iconBackColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          BackButton(
            showUnreads: false,
            iconColor: iconBackColor,
          ),
      shadowColor: Colors.transparent,
      backgroundColor:
          backgroundColor ?? OctopusTheme.of(context).colorTheme.contentView,
      elevation: 0.0,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      title: Text(
        title,
        style: titleStyle ?? OctopusTheme.of(context).textTheme.navigationTitle,
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(42.h);
}
