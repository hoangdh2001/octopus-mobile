import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/extensions/extension_string.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/avatars/gradient_avatar.dart';

const randomImageBaseUrl = 'https://getstream.io/random_png/';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
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

  final User user;

  final Alignment onlineIndicatorAlignment;

  final BoxConstraints? constraints;

  final BorderRadius? borderRadius;

  final BoxConstraints? onlineIndicatorConstraints;

  final void Function(User)? onTap;

  final void Function(User)? onLongPress;

  final bool showOnlineStatus;

  final bool selected;

  final Color? selectionColor;

  final double selectionThickness;

  final Widget Function(BuildContext, User)? placeholder;

  _getInitials(String fullName) =>
      fullName.split(' ').sublist(0, 2).map((name) => name.charAt(0)).join(' ');

  @override
  Widget build(BuildContext context) {
    final hasImage = user.avatar != null && user.avatar!.isNotEmpty;
    final streamChatTheme = OctopusTheme.of(context);

    final placeholder = this.placeholder;

    final backupGradientAvatar = ClipRRect(
      borderRadius: borderRadius ??
          streamChatTheme.ownMessageTheme.avatarTheme?.borderRadius,
      child: GradientAvatar(name: user.name, userId: user.id),
    );

    Widget avatar = FittedBox(
      fit: BoxFit.cover,
      child: Container(
        constraints: constraints ??
            streamChatTheme.ownMessageTheme.avatarTheme?.constraints,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageUrl: user.avatar ??
              "$randomImageBaseUrl?name=${_getInitials(user.name)}&size=${constraints?.maxWidth}",
          errorWidget: (context, __, ___) => backupGradientAvatar,
          placeholder: placeholder != null
              ? (context, __) => placeholder(context, user)
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
      onTap: onTap != null ? () => onTap!(user) : null,
      onLongPress: onLongPress != null ? () => onLongPress!(user) : null,
      child: Stack(
        children: <Widget>[
          avatar,
          if (showOnlineStatus && (user.active ?? false))
            Positioned.fill(
              child: Align(
                alignment: onlineIndicatorAlignment,
                child: Material(
                  type: MaterialType.circle,
                  color: streamChatTheme.colorTheme.contentView,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    constraints: onlineIndicatorConstraints ??
                        const BoxConstraints.tightFor(
                          width: 8,
                          height: 8,
                        ),
                    child: Material(
                      shape: const CircleBorder(),
                      color: streamChatTheme.colorTheme.accentInfo,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
