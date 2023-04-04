import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({
    super.key,
    this.isIdle = true,
    this.isEditEnabled = false,
    required this.onSendMessage,
  });

  final bool isIdle;

  final bool isEditEnabled;

  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    late Widget sendButton;
    if (isIdle) {
      sendButton = _buildIdleSendButton(context);
    } else {
      sendButton = _buildSendButton(context);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: sendButton,
    );
  }

  Widget _buildIdleSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(
        _getIdleSendIcon(),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: onSendMessage,
        padding: EdgeInsets.zero,
        splashRadius: 24,
        constraints: const BoxConstraints.tightFor(
          height: 24,
          width: 24,
        ),
        icon: SvgPicture.asset(
          _getSendIcon(),
        ),
      ),
    );
  }

  String _getIdleSendIcon() {
    return 'assets/icons/send_right.svg';
  }

  String _getSendIcon() {
    if (isEditEnabled) {
      return 'assets/icons/send_up.svg';
    } else {
      return 'assets/icons/send_up.svg';
    }
  }
}
