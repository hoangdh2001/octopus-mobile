import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class SendingIndicator extends StatelessWidget {
  const SendingIndicator({
    super.key,
    required this.message,
    this.isMessageRead = false,
    this.size = 12,
  });

  final Message message;

  final bool isMessageRead;

  final double? size;

  @override
  Widget build(BuildContext context) {
    if (isMessageRead) {
      return SvgPicture.asset(
        'assets/icons/check-all.svg',
        width: size,
        height: size,
        color: OctopusTheme.of(context).colorTheme.brandPrimary,
      );
    }
    if (message.status == MessageStatus.ready) {
      return SvgPicture.asset(
        'assets/icons/check.svg',
        width: size,
        height: size,
        color: IconTheme.of(context).color!.withOpacity(0.5),
      );
    }
    if (message.status == MessageStatus.sending ||
        message.status == MessageStatus.updating) {
      return Icon(
        Icons.access_time,
        size: size,
      );
    }
    return const SizedBox();
  }
}
