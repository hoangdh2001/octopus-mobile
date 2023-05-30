import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:octopus/widgets/attachment/image_attachment.dart';
import 'package:video_player/video_player.dart';

typedef QuotedMessageAttachmentThumbnailBuilder = Widget Function(
  BuildContext,
  Attachment,
);

class QuotedMessageInput extends StatelessWidget {
  /// Creates a new instance of the widget.
  const QuotedMessageInput({
    super.key,
    required this.message,
    required this.messageTheme,
    this.reverse = false,
    this.showBorder = false,
    this.textLimit = 40,
    this.attachmentThumbnailBuilders,
    this.padding = const EdgeInsets.all(8),
    this.onTap,
    this.onCancelReply,
  });

  /// The message
  final Message message;

  /// The message theme
  final OCMessageThemeData messageTheme;

  /// If true the widget will be mirrored
  final bool reverse;

  /// If true the message will show a grey border
  final bool showBorder;

  /// limit of the text message shown
  final int textLimit;

  /// Map that defines a thumbnail builder for an attachment type
  final Map<String, QuotedMessageAttachmentThumbnailBuilder>?
      attachmentThumbnailBuilders;

  /// Padding around the widget
  final EdgeInsetsGeometry padding;

  /// Callback for tap on widget
  final GestureTapCallback? onTap;

  final GestureTapCallback? onCancelReply;

  bool get _hasAttachments => message.attachments.isNotEmpty;

  bool get _containsLinkAttachment =>
      message.attachments.any((element) => element.url != null);

  bool get _containsText => message.text?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final children = [
      _buildMessage(context),
      _buildRightReply(context),
    ];
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    // final isOnlyEmoji = message.text!.isOnlyEmoji;
    var msg = _hasAttachments && !_containsText
        ? message.copyWith(text: message.attachments.last.originalName ?? '')
        : message;
    if (msg.text!.length > textLimit) {
      msg = msg.copyWith(text: '${msg.text!.substring(0, textLimit - 3)}...');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reply to ${message.sender?.firstName} ${message.sender?.lastName}',
          style: OctopusTheme.of(context).textTheme.primaryGreyBody,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          msg.text ?? "",
          style: OctopusTheme.of(context)
              .textTheme
              .primaryGreyFootnote
              .copyWith(color: OctopusTheme.of(context).colorTheme.disabled),
        ),
      ],
    );
  }

  Widget _buildRightReply(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (_hasAttachments) _parseAttachments(context),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: SvgPicture.asset('assets/icons/close.svg'),
            onPressed: onCancelReply,
          ),
        ],
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
    if (_containsLinkAttachment) {
      attachment = message.attachments.firstWhere(
        (element) => element.url != null,
      );
      child = _buildUrlAttachment(attachment);
    } else {
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
    }
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

  // Widget _buildUserAvatar() => StreamUserAvatar(
  //       user: message.user!,
  //       constraints: const BoxConstraints.tightFor(
  //         height: 24,
  //         width: 24,
  //       ),
  //       showOnlineStatus: false,
  //     );

  Map<String, QuotedMessageAttachmentThumbnailBuilder>
      get _defaultAttachmentBuilder => {
            'image': (_, attachment) => ImageAttachment(
                  attachment: attachment,
                  message: message,
                  messageTheme: messageTheme,
                  size: const Size(32, 32),
                ),
            'video': (_, attachment) => _VideoAttachmentThumbnail(
                  key: ValueKey(attachment.url),
                  attachment: attachment,
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

  // Color? _getBackgroundColor(BuildContext context) {
  //   if (_containsLinkAttachment) {
  //     return messageTheme.linkBackgroundColor;
  //   }
  //   return messageTheme.messageBackgroundColor;
  // }
}

class _VideoAttachmentThumbnail extends StatefulWidget {
  const _VideoAttachmentThumbnail({
    super.key,
    required this.attachment,
  });

  final Attachment attachment;

  @override
  _VideoAttachmentThumbnailState createState() =>
      _VideoAttachmentThumbnailState();
}

class _VideoAttachmentThumbnailState extends State<_VideoAttachmentThumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.attachment.url!)
      ..initialize().then((_) {
        // ignore: no-empty-block
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 32,
        width: 32,
        child: _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : _getIndicatorWidget(Theme.of(context).platform),
      );

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
  }
}
