import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/extensions/extension_string.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:octopus/widgets/attachment/video_thumbnail.dart';
import 'package:octopus/widgets/indicator/upload_progress_indicator.dart';

class FileAttachment extends AttachmentWidget {
  const FileAttachment({
    super.key,
    required super.message,
    required super.attachment,
    required super.size,
    this.title,
    this.trailing,
    this.onAttachmentTap,
  });

  final Widget? title;

  final Widget? trailing;

  final VoidCallback? onAttachmentTap;

  bool get isVideoAttachment => attachment.title?.mimeType?.type == 'video';

  bool get isImageAttachment => attachment.title?.mimeType?.type == 'image';

  @override
  Widget build(BuildContext context) {
    final colorTheme = OctopusTheme.of(context).colorTheme;
    return Material(
      child: GestureDetector(
        onTap: onAttachmentTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 33.33,
              margin: const EdgeInsets.all(8),
              child: _getFileTypeImage(context),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.title ?? "File",
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                _buildSubtitle(context),
              ],
            ),
            const SizedBox(width: 8),
            _buildTrailing(context),
          ],
        ),
      ),
    );
  }

  ShapeBorder _getDefaultShape(BuildContext context) => RoundedRectangleBorder(
        side: const BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      );

  Widget _getFileTypeImage(BuildContext context) {
    if (isVideoAttachment) {
      return Material(
        clipBehavior: Clip.hardEdge,
        type: MaterialType.transparency,
        shape: _getDefaultShape(context),
        child: source.when(
          local: () => VideoThumbnailImage(
            fit: BoxFit.cover,
            video: attachment.file!.path!,
            placeholderBuilder: (_) => const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          network: () => VideoThumbnailImage(
            fit: BoxFit.cover,
            video: attachment.url!,
            placeholderBuilder: (_) => const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      );
    }
    return getFileTypeImage(attachment.mimeType?.split("/").last);
  }

  Widget _buildButton({
    Widget? icon,
    double iconSize = 24.0,
    VoidCallback? onPressed,
    Color? fillColor,
  }) =>
      SizedBox(
        height: iconSize,
        width: iconSize,
        child: RawMaterialButton(
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          onPressed: onPressed,
          fillColor: fillColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: icon,
        ),
      );

  Widget _buildTrailing(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final channel = OctopusChannel.of(context).channel;
    final attachmentId = attachment.id;
    var trailingWidget = trailing;
    trailingWidget ??= attachment.uploadState.when(
      preparing: () => Padding(
        padding: const EdgeInsets.all(8),
        child: _buildButton(
          icon: SvgPicture.asset('assets/icons/close.svg',
              color: theme.colorTheme.contentView),
          fillColor: theme.colorTheme.overlayDark,
          onPressed: () => channel.cancelAttachmentUpload(attachmentId),
        ),
      ),
      inProgress: (_, __) => Padding(
        padding: const EdgeInsets.all(8),
        child: _buildButton(
          icon: SvgPicture.asset('assets/icons/close.svg',
              color: theme.colorTheme.contentView),
          fillColor: theme.colorTheme.overlayDark,
          onPressed: () => channel.cancelAttachmentUpload(attachmentId),
        ),
      ),
      success: () => Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: theme.colorTheme.brandPrimary,
          maxRadius: 12,
          child: SvgPicture.asset('assets/icons/check.svg',
              color: theme.colorTheme.contentView),
        ),
      ),
      failed: (_) => Padding(
        padding: const EdgeInsets.all(8),
        child: _buildButton(
          icon: SvgPicture.asset('assets/icons/retry.svg',
              color: theme.colorTheme.contentView),
          fillColor: theme.colorTheme.overlayDark,
          onPressed: () => channel.retryAttachmentUpload(
            message.id,
            attachmentId,
          ),
        ),
      ),
    );

    if (message.status == MessageStatus.ready) {
      trailingWidget = IconButton(
        icon: SvgPicture.asset(
          'assets/icons/cloud_download.svg',
          color: theme.colorTheme.primaryGrey,
        ),
        visualDensity: VisualDensity.compact,
        splashRadius: 16,
        onPressed: () {
          final assetUrl = attachment.url;
          if (assetUrl != null) launchURL(context, assetUrl);
        },
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: trailingWidget,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final size = attachment.file?.size ?? attachment.fileSize;
    final textStyle = theme.textTheme.primaryGreyBody;
    return attachment.uploadState.when(
      preparing: () => Text(fileSize(size), style: textStyle),
      inProgress: (sent, total) => UploadProgressIndicator(
        uploaded: sent,
        total: total,
        showBackground: false,
        padding: EdgeInsets.zero,
        textStyle: textStyle,
        progressIndicatorColor: theme.colorTheme.brandPrimary,
      ),
      success: () => Text(fileSize(size), style: textStyle),
      failed: (_) => Text(
        "Error",
        style: textStyle,
      ),
    );
  }
}
