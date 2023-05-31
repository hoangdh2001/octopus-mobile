import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class MessageDeleted extends StatelessWidget {
  const MessageDeleted({
    super.key,
    required this.messageTheme,
    this.borderRadiusGeometry,
    this.shape,
    this.borderSide,
    this.reverse = false,
  });

  final OCMessageThemeData messageTheme;

  final BorderRadiusGeometry? borderRadiusGeometry;

  final ShapeBorder? shape;

  final BorderSide? borderSide;

  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);
    return Material(
      // color: messageTheme.messageBackgroundColor,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadiusGeometry ?? BorderRadius.zero,
            side: borderSide ??
                BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? chatThemeData.colorTheme.contentView.withAlpha(24)
                      : chatThemeData.colorTheme.primaryGrey.withAlpha(24),
                ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Text(
          "message_retrived".tr(),
          style: messageTheme.messageTextStyle?.copyWith(
            fontStyle: FontStyle.italic,
            color: messageTheme.createdAtStyle?.color,
          ),
        ),
      ),
    );
  }
}
