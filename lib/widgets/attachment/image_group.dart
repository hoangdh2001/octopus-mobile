import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/extensions/extension_message.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/attachment/image_attachment.dart';
import 'package:octopus/widgets/fullscreen_media/fullscreen_media.dart';

class ImageGroup extends StatelessWidget {
  /// Constructor for creating [ImageGroup] widget
  const ImageGroup({
    super.key,
    required this.images,
    required this.message,
    required this.messageTheme,
    required this.size,
    this.onReturnAction,
    this.onShowMessage,
    this.onAttachmentTap,
    this.imageThumbnailSize = const Size(400, 400),
    this.imageThumbnailResizeType = 'crop',
    this.imageThumbnailCropType = 'center',
    this.reverse = false,
  });

  /// List of attachments to show
  final List<Attachment> images;

  /// Callback when attachment is returned to from other screens
  final ValueChanged<ReturnActionType>? onReturnAction;

  /// Callback when attachment is tapped
  final void Function(Message message, Attachment attachment)? onAttachmentTap;

  /// Message which images are attached to
  final Message message;

  /// [StreamMessageThemeData] to apply to message
  final OCMessageThemeData messageTheme;

  /// Size of images
  final Size size;

  /// Callback for when show message is tapped
  final ShowMessageCallback? onShowMessage;

  /// Size of the attachment image thumbnail.
  final Size imageThumbnailSize;

  /// Resize type of the image attachment thumbnail.
  ///
  /// Defaults to [crop]
  final String /*clip|crop|scale|fill*/ imageThumbnailResizeType;

  /// Crop type of the image attachment thumbnail.
  ///
  /// Defaults to [center]
  final String /*center|top|bottom|left|right*/ imageThumbnailCropType;

  final bool reverse;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 0.8.sw,
        child: LayoutBuilder(
          builder: (context, constraints) => Wrap(
            alignment: reverse ? WrapAlignment.end : WrapAlignment.start,
            direction: Axis.horizontal,
            runSpacing: 5,
            spacing: 5,
            children: images
                .map((attachment) =>
                    _buildImage(attachment, context, constraints))
                .toList(),
          ),
        ),
      );

  void _onTap(
    Attachment attachment,
    BuildContext context,
  ) async {
    if (onAttachmentTap != null) {
      return onAttachmentTap!(message, attachment);
    }

    final channel = OctopusChannel.of(context).channel;

    final res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OctopusChannel(
          channel: channel,
          child: FullScreenMedia(
            mediaAttachmentPackages: message.getAttachmentPackageList(),
            startIndex: 0,
            userName: message.sender?.name,
            onShowMessage: onShowMessage,
          ),
        ),
      ),
    );
    if (res != null) onReturnAction?.call(res);
  }

  Widget _buildImage(Attachment attachment, BuildContext context,
          BoxConstraints constraints) =>
      SizedBox(
        width: constraints.maxWidth / 3 - 4,
        height: constraints.maxWidth / 3 - 4,
        child: ImageAttachment(
          attachment: attachment,
          size:
              Size(constraints.maxWidth / 3 - 4, constraints.maxWidth / 3 - 4),
          message: message,
          messageTheme: messageTheme,
          onAttachmentTap: () => _onTap(attachment, context),
          imageThumbnailSize: imageThumbnailSize,
          imageThumbnailResizeType: imageThumbnailResizeType,
          imageThumbnailCropType: imageThumbnailCropType,
        ),
      );
}
