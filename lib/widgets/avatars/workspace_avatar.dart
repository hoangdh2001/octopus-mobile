import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/extensions/extension_string.dart';
import 'package:octopus/core/theme/oc_theme.dart';

const randomImageBaseUrl = 'https://getstream.io/random_png/';

class WorkspaceAvatar extends StatelessWidget {
  const WorkspaceAvatar({
    super.key,
    required this.name,
    this.constraints,
    this.onlineIndicatorConstraints,
    this.onTap,
    this.onLongPress,
    this.showOnlineStatus = true,
    this.borderRadius,
    this.onlineIndicatorAlignment = Alignment.topRight,
    this.selected = false,
    this.selectionColor,
    this.selectionThickness = 4,
    this.placeholder,
  });

  final String name;

  final Alignment onlineIndicatorAlignment;

  final BoxConstraints? constraints;

  final BorderRadius? borderRadius;

  final BoxConstraints? onlineIndicatorConstraints;

  final void Function(String)? onTap;

  final void Function(String)? onLongPress;

  final bool showOnlineStatus;

  final bool selected;

  final Color? selectionColor;

  final double selectionThickness;

  final Widget Function(BuildContext, String)? placeholder;

  _getInitials(String fullName) {
    final names = fullName.split(' ');
    if (names.length == 1) {
      return names[0].charAt(0);
    } else {
      return names.sublist(0, 2).map((name) => name.charAt(0)).join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final hasImage = user.avatar != null && user.avatar!.isNotEmpty;
    final streamChatTheme = OctopusTheme.of(context);

    final placeholder = this.placeholder;

    // final backupGradientAvatar = ClipRRect(
    //   borderRadius: borderRadius ??
    //       streamChatTheme.ownMessageTheme.avatarTheme?.borderRadius,
    //   child: GradientAvatar(name: name, userId: user.id),
    // );

    Widget avatar = FittedBox(
      fit: BoxFit.cover,
      child: Container(
        constraints: constraints ??
            streamChatTheme.ownMessageTheme.avatarTheme?.constraints,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageUrl:
              "$randomImageBaseUrl?name=${_getInitials(name)}&size=${constraints?.maxWidth}",
          errorWidget: (context, __, ___) => Container(),
          placeholder: placeholder != null
              ? (context, __) => placeholder(context, name)
              : null,
          imageBuilder: (context, imageProvider) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius ??
                  streamChatTheme.ownMessageTheme.avatarTheme?.borderRadius,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );

    if (selected) {
      avatar = ClipRRect(
        borderRadius: (borderRadius ??
                streamChatTheme.ownMessageTheme.avatarTheme?.borderRadius ??
                BorderRadius.zero) +
            BorderRadius.circular(selectionThickness),
        child: Container(
          constraints: constraints ??
              streamChatTheme.ownMessageTheme.avatarTheme?.constraints,
          color: selectionColor ?? streamChatTheme.colorTheme.brandPrimary,
          child: Padding(
            padding: EdgeInsets.all(selectionThickness),
            child: avatar,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(name) : null,
      onLongPress: onLongPress != null ? () => onLongPress!(name) : null,
      child: Stack(
        children: <Widget>[
          avatar,
        ],
      ),
    );
  }
}
