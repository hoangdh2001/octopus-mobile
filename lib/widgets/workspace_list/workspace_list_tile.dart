import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/avatars/workspace_avatar.dart';

class WorkspaceListTile extends StatelessWidget {
  const WorkspaceListTile({
    super.key,
    required this.workspace,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.title,
    this.subtitle,
    this.selectedWidget,
    this.selected = false,
    this.tileColor,
    this.visualDensity = VisualDensity.compact,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.showSelectWidget = false,
  });

  final Workspace workspace;

  final GestureTapCallback? onTap;

  final GestureLongPressCallback? onLongPress;

  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? selectedWidget;

  final bool selected;

  final Color? tileColor;

  final VisualDensity visualDensity;

  final EdgeInsetsGeometry contentPadding;

  final bool showSelectWidget;

  WorkspaceListTile copyWith({
    Key? key,
    Workspace? workspace,
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
  }) =>
      WorkspaceListTile(
        key: key ?? this.key,
        workspace: workspace ?? this.workspace,
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
      );

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);
    final leading = this.leading ??
        WorkspaceAvatar(
          name: workspace.name,
          constraints: const BoxConstraints.tightFor(width: 35, height: 35),
        );
    final title = this.title ??
        Text(
          workspace.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: chatThemeData.textTheme.primaryGreyBodyBold,
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
      leading: leading,
      title: title,
      tileColor: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
      trailing: showSelectWidget ? selectedWidget : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      visualDensity: visualDensity,
      contentPadding: contentPadding,
    );
  }
}


// Container(
//       height: 42.h,
//       margin: const EdgeInsets.symmetric(vertical: 5).h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
//       ),
//       padding: const EdgeInsets.all(6).r,
//       child: Row(
//         children: [
//           const WorkspaceAvatar(
//             name: "Khóa luận tốt nghiệp",
//             constraints: BoxConstraints.tightFor(width: 35, height: 35),
//             showOnlineStatus: false,
//           ),
//           SizedBox(
//             width: 10.w,
//           ),
//           Text(
//             "Khóa luận tốt nghiệp",
//             style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
//           ),
//         ],
//       ),
//     );