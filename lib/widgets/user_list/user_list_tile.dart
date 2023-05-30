import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
    this.leading,
    this.title,
    this.subtitle,
    this.selected = false,
    this.selectedWidget,
    this.onTap,
    this.onLongPress,
    this.tileColor,
    this.visualDensity = VisualDensity.compact,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.showSelectWidget = false,
    this.showSubtitle = false,
    this.showOnlineStatus = false,
    this.shape,
  });

  final User user;

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? selectedWidget;

  final bool selected;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final Color? tileColor;

  final VisualDensity visualDensity;

  final EdgeInsetsGeometry contentPadding;

  final bool showSelectWidget;

  final bool showSubtitle;

  final bool showOnlineStatus;

  final ShapeBorder? shape;

  UserListTile copyWith({
    Key? key,
    User? user,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? selectedWidget,
    bool? selected,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    Color? tileColor,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? contentPadding,
    bool? showSelectWidget,
    bool? showSubtitle,
  }) =>
      UserListTile(
        key: key ?? this.key,
        user: user ?? this.user,
        leading: leading ?? this.leading,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        selectedWidget: selectedWidget ?? this.selectedWidget,
        selected: selected ?? this.selected,
        onTap: onTap ?? this.onTap,
        onLongPress: onLongPress ?? this.onLongPress,
        tileColor: tileColor ?? this.tileColor,
        visualDensity: visualDensity ?? this.visualDensity,
        contentPadding: contentPadding ?? this.contentPadding,
        showSelectWidget: showSelectWidget ?? this.showSelectWidget,
        showSubtitle: showSubtitle ?? this.showSubtitle,
      );

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);

    final leading = this.leading ??
        UserAvatar(
          user: user,
          constraints: const BoxConstraints.tightFor(width: 50, height: 50),
          borderRadius: BorderRadius.circular(25),
          showOnlineStatus: showOnlineStatus,
        );

    final title = this.title ??
        Text(
          '${user.firstName} ${user.lastName}',
          style: chatThemeData.textTheme.primaryGreyBodyBold,
        );

    final subtitle = this.subtitle ??
        UserLastActive(
          user: user,
        );

    final selectedWidget = Transform.scale(
      scale: 1.3,
      child: this.selectedWidget ??
          Checkbox(
            value: selected,
            onChanged: (value) {},
            shape: const CircleBorder(),
            activeColor: chatThemeData.colorTheme.brandPrimary,
            checkColor: Colors.white,
            side: BorderSide(width: 2, color: chatThemeData.colorTheme.border),
          ),
    );

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      trailing: showSelectWidget ? selectedWidget : null,
      title: title,
      subtitle: showSubtitle ? subtitle : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      shape: shape,
    );
  }
}

class UserLastActive extends StatelessWidget {
  const UserLastActive({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final chatTheme = OctopusTheme.of(context);
    return Text(
      user.active ?? false
          ? 'online'
          : 'online '
              '${Jiffy(user.lastActive).fromNow()}',
      style: chatTheme.textTheme.primaryGreyBody,
    );
  }
}
