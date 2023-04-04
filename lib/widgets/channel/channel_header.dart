import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/back_button.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';

class ChannelHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChannelHeader({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
    this.onTitleTap,
    this.onImageTap,
    this.title,
    this.subtitle,
    this.centerTitle,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 1,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final bool showBackButton;

  final VoidCallback? onBackPressed;

  final VoidCallback? onTitleTap;

  final VoidCallback? onImageTap;

  final Widget? title;

  final Widget? subtitle;

  final bool? centerTitle;

  final Widget? leading;

  final List<Widget>? actions;

  final Color? backgroundColor;

  final double elevation;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final effectiveCenterTitle = getEffectiveCenterTitle(
      Theme.of(context),
      actions: actions,
      centerTitle: centerTitle,
    );
    final leadingWidget = leading ??
        (showBackButton
            ? OCBackButton(
                onPressed: onBackPressed,
                showUnreads: true,
              )
            : const SizedBox());
    return AppBar(
      toolbarTextStyle: OctopusTheme.of(context).textTheme.brandPrimaryBodyBold,
      elevation: elevation,
      leading: leadingWidget,
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      actions: actions ?? [],
      centerTitle: centerTitle,
      titleSpacing: 0,
      title: InkWell(
        onTap: () {},
        child: SizedBox(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: ChannelAvatar(
                    size: 40,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title ??
                      Text(
                        "Hoang Do",
                        style: OctopusTheme.of(context)
                            .textTheme
                            .primaryGreyBodyBold,
                      ),
                  const SizedBox(height: 2),
                  subtitle ??
                      Text(
                        "Active now",
                        style: OctopusTheme.of(context)
                            .textTheme
                            .secondaryGreyCaption2,
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
