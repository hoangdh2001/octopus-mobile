import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/extensions/extension_message.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/attachment/attachment_title.dart';
import 'package:octopus/widgets/attachment/attachment_upload_state_builder.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:octopus/widgets/fullscreen_media/fullscreen_media.dart';
import 'package:shimmer/shimmer.dart';

class ImageAttachment extends AttachmentWidget {
  const ImageAttachment({
    super.key,
    required super.message,
    required super.attachment,
    required this.messageTheme,
    required super.size,
    this.showTitle = false,
    this.onShowMessage,
    this.onReturnAction,
    this.onAttachmentTap,
    this.imageThumbnailSize = const Size(400, 400),
    this.imageThumbnailResizeType = 'crop',
    this.imageThumbnailCropType = 'center',
    this.scale = 1,
  });

  final OCMessageThemeData messageTheme;

  final bool showTitle;

  final ShowMessageCallback? onShowMessage;

  final ValueChanged<ReturnActionType>? onReturnAction;

  final VoidCallback? onAttachmentTap;

  final Size imageThumbnailSize;

  final String /*clip|crop|scale|fill*/ imageThumbnailResizeType;

  final String /*center|top|bottom|left|right*/ imageThumbnailCropType;

  final double scale;

  @override
  Widget build(BuildContext context) => source.when(
        local: () {
          if (attachment.localUri == null || attachment.file?.bytes == null) {
            return AttachmentError(size: size);
          }
          return _buildImageAttachment(
            context,
            Image.memory(
              attachment.file!.bytes!,
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
              errorBuilder: (context, _, __) => Image.asset(
                'assets/images/placeholder.png',
              ),
            ),
          );
        },
        network: () {
          var imageUrl = attachment.url ?? attachment.thumbnailUrl;
          debugPrint(imageUrl);
          if (imageUrl == null) {
            return AttachmentError(size: size);
          }
          return _buildImageAttachment(
            context,
            AspectRatio(
              aspectRatio: size.aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, __) {
                    final image = Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    );
                    final colorTheme = OctopusTheme.of(context).colorTheme;
                    return Shimmer.fromColors(
                      baseColor: colorTheme.disabled,
                      highlightColor: colorTheme.brandPrimary,
                      child: image,
                    );
                  },
                  errorWidget: (context, url, error) =>
                      AttachmentError(size: size),
                ),
              ),
            ),
          );
        },
      );

  Widget _buildImageAttachment(BuildContext context, Widget imageWidget) =>
      SizedBox(
        width: (size.width > size.height
                ? (size.height / size.width).sw
                : (size.width / size.height).sw) *
            scale,
        child: AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: onAttachmentTap ??
                          () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  final channel =
                                      OctopusChannel.of(context).channel;
                                  return OctopusChannel(
                                    channel: channel,
                                    child: FullScreenMedia(
                                      mediaAttachmentPackages:
                                          message.getAttachmentPackageList(),
                                      startIndex: message.attachments
                                          .indexOf(attachment),
                                      userName: message.sender?.name,
                                      onShowMessage: onShowMessage,
                                    ),
                                  );
                                },
                              ),
                            );
                            if (result != null) onReturnAction?.call(result);
                          },
                      child: imageWidget,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: AttachmentUploadStateBuilder(
                        message: message,
                        attachment: attachment,
                      ),
                    ),
                  ],
                ),
              ),
              if (showTitle && attachment.title != null)
                Material(
                  color: messageTheme.messageBackgroundColor,
                  child: AttachmentTitle(
                    messageTheme: messageTheme,
                    attachment: attachment,
                  ),
                ),
            ],
          ),
        ),
      );
}
