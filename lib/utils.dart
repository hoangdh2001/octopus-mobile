import 'package:flutter/material.dart';
import 'package:octopus/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, String url) async {
  try {
    await launchUrl(
      Uri.parse(url).withScheme,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("")),
    );
  }
}

bool getEffectiveCenterTitle(
  ThemeData theme, {
  bool? centerTitle,
  List<Widget>? actions,
}) {
  if (centerTitle != null) return centerTitle;
  if (theme.appBarTheme.centerTitle != null) {
    return theme.appBarTheme.centerTitle!;
  }
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return false;
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return actions == null || actions.length < 2;
  }
}

Widget wrapAttachmentWidget(
  BuildContext context,
  Widget attachmentWidget,
  ShapeBorder attachmentShape,
  // ignore: avoid_positional_boolean_parameters
  bool reverse,
) =>
    Material(
      clipBehavior: Clip.hardEdge,
      shape: attachmentShape,
      type: MaterialType.transparency,
      child: attachmentWidget,
    );
