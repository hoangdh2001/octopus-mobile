import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

typedef TitleBuilder = Widget Function(
  BuildContext,
  Widget,
);

typedef SubtitleBuilder = Widget Function(
  BuildContext,
  Widget,
);

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  const ScreenHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.titleSpacing,
    this.backgroundColor,
    this.titleStyle,
    this.iconBackColor,
    this.subtitleStyle,
    this.leadingTitle,
    this.titleWidget,
    this.subtitleWidget,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool centerTitle;
  final List<Widget>? actions;
  final double? titleSpacing;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final Color? iconBackColor;
  final TextStyle? subtitleStyle;
  final Widget? leadingTitle;
  final TitleBuilder? titleWidget;
  final SubtitleBuilder? subtitleWidget;

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
      title: Column(
        children: [
          _buildTitle(context),
          if (subtitle != null) _buildSubtitle(context),
        ],
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(42.h);

  Widget _buildTitle(BuildContext context) {
    Widget child = Text(
      title,
      style: titleStyle ?? OctopusTheme.of(context).textTheme.navigationTitle,
    );

    return titleWidget?.call(context, child) ?? child;
  }

  Widget _buildSubtitle(BuildContext context) {
    Widget child = Text(
      subtitle!,
      style: subtitleStyle ??
          OctopusTheme.of(context).textTheme.secondaryGreyCaption2,
    );
    return subtitleWidget?.call(context, child) ?? child;
  }
}
