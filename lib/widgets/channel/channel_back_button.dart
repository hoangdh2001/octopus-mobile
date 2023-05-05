import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/unread_indicator.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    this.onPressed,
    this.showUnreads = false,
    this.id,
  });

  final VoidCallback? onPressed;

  final bool showUnreads;

  final String? id;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
            highlightElevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              } else {
                Navigator.maybePop(context);
              }
            },
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              'assets/icons/chevron-left.svg',
              width: 24,
              height: 24,
              color: OctopusTheme.of(context).colorTheme.icon,
            ),
          ),
          if (showUnreads)
            Positioned(
              top: 7,
              right: 7,
              child: UnreadIndicator(
                id: id,
              ),
            ),
        ],
      );
}
