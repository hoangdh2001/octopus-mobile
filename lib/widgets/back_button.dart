import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class OCBackButton extends StatelessWidget {
  const OCBackButton({
    super.key,
    this.onPressed,
    this.showUnreads = false,
    this.cid,
  });

  final VoidCallback? onPressed;

  final bool showUnreads;

  final String? cid;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              } else {
                Navigator.maybePop(context);
              }
            },
            icon: SvgPicture.asset(
              "assets/icons/arrow-left.svg",
              color: OctopusTheme.of(context).colorTheme.icon,
            ),
          ),
          // if (showUnreads)
          //   Positioned(
          //     top: 7,
          //     right: 7,
          //     child: StreamUnreadIndicator(
          //       cid: cid,
          //     ),
          //   ),
        ],
      );
}
