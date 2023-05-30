import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

const appId = '509316ca45954759bbbc95c5a7186933';
const token =
    '007eJxTYJhw9PMR0zRGjiZvzplp9rY+lvuufC+4/vFL55GLQT6p6VcVGEwNLI0NzZITTUwtTU3MTS2TkpKSLU2TTRPNDS3MLI2NbebkpDQEMjL8EOtkZWSAQBCfnSE/uSS/oLSYgQEAxoUg6g==';

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

String fileSize(dynamic size, [int round = 2]) {
  if (size == null) return 'Size N/A';

  /**
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number
   * of digits after comma/point (default is 2)
   */
  const divider = 1024;
  int _size;
  try {
    _size = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError('Can not parse the size parameter: $e');
  }

  if (_size < divider) {
    return '$_size B';
  }

  if (_size < divider * divider && _size % divider == 0) {
    return '${(_size / divider).toStringAsFixed(0)} KB';
  }

  if (_size < divider * divider) {
    return '${(_size / divider).toStringAsFixed(round)} KB';
  }

  if (_size < divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
  }

  if (_size < divider * divider * divider) {
    return '${(_size / divider / divider).toStringAsFixed(round)} MB';
  }

  if (_size < divider * divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
  }

  if (_size < divider * divider * divider * divider) {
    return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
  }

  if (_size < divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    final num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} TB';
  }

  if (_size < divider * divider * divider * divider * divider) {
    final num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} TB';
  }

  if (_size < divider * divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    final num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} PB';
  } else {
    final num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} PB';
  }
}

///
SvgPicture getFileTypeImage(String? type) {
  switch (type) {
    case '7z':
      return SvgPicture.asset('assets/icons/file_7z.svg');
    case 'csv':
      return SvgPicture.asset('assets/icons/file_csv.svg');
    case 'doc':
    case 'docx':
    case 'vnd.openxmlformats-officedocument.wordprocessingml.document':
      return SvgPicture.asset('assets/icons/file_doc.svg');
    case 'html':
      return SvgPicture.asset('assets/icons/file_html.svg');
    case 'md':
      return SvgPicture.asset('assets/icons/file_MD.svg');
    case 'odt':
      return SvgPicture.asset('assets/icons/file_ODT.svg');
    case 'pdf':
      return SvgPicture.asset('assets/icons/file_pdf.svg');
    case 'ppt':
      return SvgPicture.asset('assets/icons/file_PPT.svg');
    case 'pptx':
      return SvgPicture.asset('assets/icons/file_PPTX.svg');
    case 'rar':
      return SvgPicture.asset('assets/icons/file_RAR.svg');
    case 'rtf':
      return SvgPicture.asset('assets/icons/file_RTF.svg');
    case 'tar':
      return SvgPicture.asset('assets/icons/file_TAR.svg');
    case 'txt':
      return SvgPicture.asset('assets/icons/file_TXT.svg');
    case 'xls':
      return SvgPicture.asset('assets/icons/file_XLS.svg');
    case 'xlsx':
      return SvgPicture.asset('assets/icons/file_XLSX.svg');
    case 'zip':
      return SvgPicture.asset('assets/icons/file_ZIP.svg');
    default:
      return SvgPicture.asset('assets/icons/file_Generic.svg');
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

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String okText,
  Widget? icon,
  String? question,
  String? cancelText,
}) {
  final chatThemeData = OctopusTheme.of(context);
  return showModalBottomSheet(
    useRootNavigator: false,
    backgroundColor: chatThemeData.colorTheme.contentView,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      final effect = chatThemeData.colorTheme.border;
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 26),
            if (icon != null) icon,
            const SizedBox(height: 26),
            Text(
              title,
              style: chatThemeData.textTheme.primaryGreyH1,
            ),
            const SizedBox(height: 7),
            if (question != null)
              Text(
                question,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 36),
            Container(
              color: effect,
              height: 1,
            ),
            Row(
              children: [
                if (cancelText != null)
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          cancelText,
                          style: chatThemeData.textTheme.primaryGreyBodyBold
                              .copyWith(
                            color: chatThemeData.colorTheme.primaryGrey
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        okText,
                        style: chatThemeData.textTheme.primaryGreyBody.copyWith(
                          color: chatThemeData.colorTheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

String generateHash(List<Object?> objects) {
  final payload = json.encode(objects);
  final payloadBytes = utf8.encode(payload);
  final payloadB64 = base64.encode(payloadBytes);
  return payloadB64;
}
