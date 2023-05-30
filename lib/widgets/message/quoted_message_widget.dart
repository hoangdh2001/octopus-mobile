import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:octopus/widgets/attachment/image_attachment.dart';
import 'package:octopus/widgets/attachment/video_attachment.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/message/message_text.dart';
import 'package:video_player/video_player.dart';

typedef QuotedMessageAttachmentThumbnailBuilder = Widget Function(
  BuildContext,
  Attachment,
);

class QuotedMessageWidget extends StatelessWidget {
  const QuotedMessageWidget({
    super.key,
    required this.message,
    required this.messageTheme,
    this.reverse = false,
    this.showBorder = false,
    this.textLimit = 170,
    this.attachmentThumbnailBuilders,
    this.padding = const EdgeInsets.all(8),
    this.onTap,
  });

  final Message message;

  final OCMessageThemeData messageTheme;

  final bool reverse;

  final bool showBorder;

  final int textLimit;

  final Map<String, QuotedMessageAttachmentThumbnailBuilder>?
      attachmentThumbnailBuilders;

  final EdgeInsetsGeometry padding;

  final GestureTapCallback? onTap;

  bool get _hasAttachments => message.attachments.isNotEmpty;

  bool get _containsLinkAttachment =>
      message.attachments.any((element) => element.url != null);

  bool get _containsText => message.text?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final children = [
      Flexible(child: _buildMessage(context)),
    ];
    return Container(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: reverse ? children.reversed.toList() : children,
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    // final isOnlyEmoji = message.text!.isOnlyEmoji;
    var msg = _hasAttachments && !_containsText
        ? message.copyWith(text: message.attachments.last.title ?? '')
        : message;
    if (msg.text!.length > textLimit) {
      msg = msg.copyWith(text: '${msg.text!.substring(0, textLimit - 3)}...');
    }

    final children = [
      if (_hasAttachments) _parseAttachments(context),
      if (msg.text!.isNotEmpty)
        Flexible(
          child: MessageText(
            message: msg,
            messageTheme:
                // isOnlyEmoji && _containsText
                //     ? messageTheme.copyWith(
                //         messageTextStyle: messageTheme.messageTextStyle?.copyWith(
                //           fontSize: 32,
                //         ),
                //       )
                //     :
                messageTheme,
          ),
        ),
    ].insertBetween(const SizedBox(width: 8));

    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(
        top: _hasAttachments ? 0 : 8,
        left: _hasAttachments && !reverse ? 0 : 8,
        right: _hasAttachments && reverse ? 0 : 8,
        bottom: _hasAttachments ? 0 : 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            reverse ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: reverse ? children.reversed.toList() : children,
      ),
    );
  }

  Widget _buildUrlAttachment(Attachment attachment) {
    const size = Size(32, 32);
    if (attachment.thumbnailUrl != null) {
      return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              attachment.thumbnailUrl!,
            ),
          ),
        ),
      );
    }
    return const AttachmentError(size: size);
  }

  Widget _parseAttachments(BuildContext context) {
    Widget child;
    Attachment attachment;
    // if (_containsLinkAttachment) {
    //   attachment = message.attachments.firstWhere(
    //     (element) => element.url != null,
    //   );
    //   child = _buildUrlAttachment(attachment);
    // } else {
    QuotedMessageAttachmentThumbnailBuilder? attachmentBuilder;
    attachment = message.attachments.last;
    if (attachmentThumbnailBuilders?.containsKey(attachment.type) == true) {
      attachmentBuilder = attachmentThumbnailBuilders![attachment.type];
    }
    attachmentBuilder = _defaultAttachmentBuilder[attachment.type];
    if (attachmentBuilder == null) {
      child = const Offstage();
    } else {
      child = attachmentBuilder(context, attachment);
    }
    // }
    child = AbsorbPointer(child: child);
    return Material(
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      shape: attachment.type == 'file' ? null : _getDefaultShape(context),
      child: child,
    );
  }

  ShapeBorder _getDefaultShape(BuildContext context) => RoundedRectangleBorder(
        side: const BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      );

  Map<String, QuotedMessageAttachmentThumbnailBuilder>
      get _defaultAttachmentBuilder => {
            'image': (_, attachment) => ImageAttachment(
                  attachment: attachment,
                  message: message,
                  messageTheme: messageTheme,
                  size: Size(
                    attachment.originalWidth?.toDouble() ?? 32,
                    attachment.originalHeight?.toDouble() ?? 32,
                  ),
                  scale: 0.6,
                ),
            'video': (_, attachment) => VideoAttachment(
                  key: ValueKey(attachment.url),
                  attachment: attachment,
                  size: Size(
                    attachment.originalWidth?.toDouble() ?? 32,
                    attachment.originalHeight?.toDouble() ?? 32,
                  ),
                  message: message,
                  messageTheme: messageTheme,
                  scale: 0.5,
                  playIcon: 15,
                  succeseBuilder: (context) => const Offstage(),
                ),
            // 'giphy': (_, attachment) {
            //   const size = Size(32, 32);
            //   return CachedNetworkImage(
            //     height: size.height,
            //     width: size.width,
            //     placeholder: (_, __) => SizedBox(
            //       width: size.width,
            //       height: size.height,
            //       child: const Center(
            //         child: CircularProgressIndicator(),
            //       ),
            //     ),
            //     imageUrl: attachment.thumbUrl ??
            //         attachment.imageUrl ??
            //         attachment.assetUrl!,
            //     errorWidget: (context, url, error) =>
            //         const AttachmentError(size: size),
            //     fit: BoxFit.cover,
            //   );
            // },
            'file': (_, attachment) => SizedBox(
                  height: 32,
                  width: 32,
                  child: getFileTypeImage(
                    attachment.mimeType?.split("/").last,
                  ),
                ),
          };

  Color? _getBackgroundColor(BuildContext context) {
    if (_containsLinkAttachment) {
      return messageTheme.linkBackgroundColor;
    }
    return OctopusTheme.of(context).colorTheme.disabled;
  }
}
