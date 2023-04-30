import 'package:flutter/material.dart';

class MessageDeleted extends StatelessWidget {
  const MessageDeleted({
    super.key,
    this.borderRadiusGeometry,
    this.shape,
    this.borderSide,
    this.reverse = false,
  });

  /// The border radius of the message text
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// The shape of the message text
  final ShapeBorder? shape;

  /// The borderside of the message text
  final BorderSide? borderSide;

  /// If true the widget will be mirrored
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    // final chatThemeData = StreamChatTheme.of(context);
    return Material(
      // color: messageTheme.messageBackgroundColor,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadiusGeometry ?? BorderRadius.zero,
            side: borderSide ??
                BorderSide(
                    // color: Theme.of(context).brightness == Brightness.dark
                    //     ? chatThemeData.colorTheme.barsBg.withAlpha(24)
                    //     : chatThemeData.colorTheme.textHighEmphasis.withAlpha(24),
                    ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Text(
          "Message deleted",
          // style: messageTheme.messageTextStyle?.copyWith(
          //   fontStyle: FontStyle.italic,
          //   color: messageTheme.createdAtStyle?.color,
          // ),
        ),
      ),
    );
  }
}
