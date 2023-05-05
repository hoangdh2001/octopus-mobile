import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/extensions/extension_message.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/attachment/attachment_upload_state_builder.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:octopus/widgets/attachment/video_thumbnail.dart';
import 'package:octopus/widgets/fullscreen_media/fullscreen_media.dart';

class VideoAttachment extends AttachmentWidget {
  const VideoAttachment(
      {super.key,
      required super.message,
      required super.attachment,
      required this.messageTheme,
      required super.size,
      this.onShowMessage,
      this.onReturnAction,
      this.onAttachmentTap,
      this.scale = 1,
      this.playIcon = 24,
      this.succeseBuilder});

  final OCMessageThemeData messageTheme;

  final ShowMessageCallback? onShowMessage;

  final ValueChanged<ReturnActionType>? onReturnAction;

  final VoidCallback? onAttachmentTap;

  final double scale;

  final double playIcon;

  final WidgetBuilder? succeseBuilder;

  @override
  Widget build(BuildContext context) => source.when(
        local: () {
          if (attachment.file == null) {
            return AttachmentError(size: size);
          }
          return _buildVideoAttachment(
            context,
            VideoThumbnailImage(
              video: attachment.file!.path!,
              fit: BoxFit.cover,
              errorBuilder: (_, __) => AttachmentError(size: size),
            ),
          );
        },
        network: () {
          if (attachment.url == null) {
            return AttachmentError(size: size);
          }
          return _buildVideoAttachment(
            context,
            VideoThumbnailImage(
              video: attachment.url!,
              fit: BoxFit.cover,
              errorBuilder: (_, __) => AttachmentError(size: size),
            ),
          );
        },
      );

  Widget _buildVideoAttachment(BuildContext context, Widget videoWidget) =>
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
                child: GestureDetector(
                  onTap: onAttachmentTap ??
                      () async {
                        final channel = OctopusChannel.of(context).channel;
                        final res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OctopusChannel(
                              channel: channel,
                              child: FullScreenMedia(
                                mediaAttachmentPackages:
                                    message.getAttachmentPackageList(),
                                startIndex:
                                    message.attachments.indexOf(attachment),
                                userName: message.sender?.name,
                                onShowMessage: onShowMessage,
                              ),
                            ),
                          ),
                        );
                        if (res != null) onReturnAction?.call(res);
                      },
                  child: Stack(
                    children: [
                      videoWidget,
                      Center(
                        child: Material(
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              Icons.play_arrow,
                              size: playIcon,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: AttachmentUploadStateBuilder(
                          message: message,
                          attachment: attachment,
                          successBuilder: succeseBuilder,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
