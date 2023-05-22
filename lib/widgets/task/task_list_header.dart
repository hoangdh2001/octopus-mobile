import 'package:flutter/material.dart' hide BackButton;
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/avatars/space_avatar.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

class TaskListHeader extends StatelessWidget implements PreferredSizeWidget {
  const TaskListHeader({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
    this.onTitleTap,
    this.title,
    this.subtitle,
    this.centerTitle,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 1,
    this.showTypingIndicator = true,
    this.subtitleWidget,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final bool showBackButton;

  final VoidCallback? onBackPressed;

  final VoidCallback? onTitleTap;

  final Widget? title;

  final Widget? subtitle;

  final bool? centerTitle;

  final Widget? leading;

  final List<Widget>? actions;

  final Color? backgroundColor;

  final double elevation;

  final bool showTypingIndicator;

  final Widget? subtitleWidget;

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
            ? BackButton(
                onPressed: onBackPressed,
                showUnreads: false,
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
      title: GestureDetector(
        onTap: onTitleTap,
        child: SizedBox(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: SpaceAvatar(
                    name: 'To do app',
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: preferredSize.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'To Do app',
                        style:
                            OctopusTheme.of(context).textTheme.navigationTitle,
                      ),
                      const SizedBox(height: 2),
                      subtitleWidget ??
                          Text(
                            'List',
                            style: OctopusTheme.of(context)
                                .textTheme
                                .mediumGreyCaption2,
                          )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
