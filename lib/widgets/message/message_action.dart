import 'package:flutter/widgets.dart';
import 'package:octopus/widgets/message_list/message_list_view.dart';

class MessageAction {
  MessageAction({
    this.leading,
    this.title,
    this.onTap,
  });

  final Widget? leading;

  final Widget? title;

  final OnMessageTap? onTap;
}
