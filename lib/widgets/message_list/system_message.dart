import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class SystemMessage extends StatelessWidget {
  const SystemMessage({
    super.key,
    required this.message,
    this.onMessageTap,
  });

  final Message message;

  final void Function(Message)? onMessageTap;

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final message = this.message;

    final messageText = message.text;
    if (messageText == null) return const SizedBox.shrink();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onMessageTap == null ? null : () => onMessageTap!(message),
      child: Text(
        messageText,
        textAlign: TextAlign.center,
        softWrap: true,
        // style: theme.textTheme.captionBold.copyWith(
        //   color: theme.colorTheme.textLowEmphasis,
        // ),
      ),
    );
  }
}
