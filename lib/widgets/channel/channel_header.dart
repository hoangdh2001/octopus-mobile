import 'package:flutter/material.dart' hide BackButton;
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/channel/channel_info.dart';
import 'package:octopus/widgets/channel/channel_name.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';

class ChannelHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChannelHeader({
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

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final effectiveCenterTitle = getEffectiveCenterTitle(
      Theme.of(context),
      actions: actions,
      centerTitle: centerTitle,
    );
    final channel = OctopusChannel.of(context).channel;
    final channelHeaderTheme = OctopusTheme.of(context).channelHeaderTheme;

    final leadingWidget = leading ??
        (showBackButton
            ? BackButton(
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
      title: GestureDetector(
        onTap: onTitleTap,
        child: SizedBox(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: ChannelAvatar(
                    constraints: OctopusTheme.of(context)
                        .channelHeaderTheme
                        .avatarTheme
                        ?.constraints,
                    channel: channel,
                    borderRadius: OctopusTheme.of(context)
                        .channelHeaderTheme
                        .avatarTheme
                        ?.borderRadius,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title ??
                      ChannelName(
                        channel: channel,
                        textStyle: channelHeaderTheme.titleStyle,
                      ),
                  const SizedBox(height: 2),
                  subtitle ??
                      ChannelInfo(
                        channel: channel,
                        showTypingIndicator: showTypingIndicator,
                        textStyle: channelHeaderTheme.subtitleStyle,
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
