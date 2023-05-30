import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class OptionListTile extends StatelessWidget {
  const OptionListTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.tileColor,
    this.separatorColor,
    this.titleTextStyle,
  });

  final String title;

  final Widget? leading;

  final Widget? trailing;

  final VoidCallback? onTap;

  final Color? titleColor;

  final Color? tileColor;

  final Color? separatorColor;

  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = OctopusTheme.of(context);
    return Column(
      children: [
        Container(
          height: 1,
          color: separatorColor ?? chatThemeData.colorTheme.disabled,
        ),
        Material(
          color: tileColor ?? chatThemeData.colorTheme.contentView,
          child: SizedBox(
            height: 63,
            child: InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  if (leading != null)
                    Center(child: leading)
                  else
                    const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: Text(
                      title,
                      style: titleTextStyle ??
                          (titleColor == null
                              ? chatThemeData.textTheme.primaryGreyBody
                              : chatThemeData.textTheme.primaryGreyBody
                                  .copyWith(
                                  color: titleColor,
                                )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: trailing ?? Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
