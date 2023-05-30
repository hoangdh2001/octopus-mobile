import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/indicator/upload_progress_indicator.dart';

typedef InProgressBuilder = Widget Function(BuildContext, int, int);

typedef FailedBuilder = Widget Function(BuildContext, String);

class AttachmentUploadStateBuilder extends StatelessWidget {
  const AttachmentUploadStateBuilder({
    super.key,
    required this.message,
    required this.attachment,
    this.failedBuilder,
    this.successBuilder,
    this.inProgressBuilder,
    this.preparingBuilder,
  });

  final Message message;

  final Attachment attachment;

  final FailedBuilder? failedBuilder;

  final WidgetBuilder? successBuilder;

  final InProgressBuilder? inProgressBuilder;

  final WidgetBuilder? preparingBuilder;

  @override
  Widget build(BuildContext context) {
    if (message.status == MessageStatus.ready) {
      return const Offstage();
    }

    final messageId = message.id;
    final attachmentId = attachment.id;

    final inProgress = inProgressBuilder ??
        (context, int sent, int total) => _InProgressState(
              sent: sent,
              total: total,
              attachmentId: attachmentId,
            );

    final failed = failedBuilder ??
        (context, error) => _FailedState(
              error: error,
              messageId: messageId,
              attachmentId: attachmentId,
            );

    final success = successBuilder ?? (context) => _SuccessState();

    final preparing = preparingBuilder ??
        (context) => _PreparingState(attachmentId: attachmentId);

    return attachment.uploadState.when(
      preparing: () => preparing(context),
      inProgress: (sent, total) => inProgress(context, sent, total),
      success: () => success(context),
      failed: (error) => failed(context, error),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    this.icon,
    this.onPressed,
  });

  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        width: 24,
        child: RawMaterialButton(
          elevation: 0,
          highlightElevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          onPressed: onPressed,
          fillColor: OctopusTheme.of(context).colorTheme.overlayDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: icon,
        ),
      );
}

class _PreparingState extends StatelessWidget {
  const _PreparingState({required this.attachmentId});

  final String attachmentId;

  @override
  Widget build(BuildContext context) {
    final channel = OctopusChannel.of(context).channel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _IconButton(
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              color: OctopusTheme.of(context).colorTheme.contentView,
            ),
            onPressed: () => channel.cancelAttachmentUpload(attachmentId),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: UploadProgressIndicator(
            uploaded: 0,
            total: double.maxFinite.toInt(),
          ),
        ),
      ],
    );
  }
}

class _InProgressState extends StatelessWidget {
  const _InProgressState({
    required this.sent,
    required this.total,
    required this.attachmentId,
  });

  final int sent;
  final int total;
  final String attachmentId;

  @override
  Widget build(BuildContext context) {
    final channel = OctopusChannel.of(context).channel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _IconButton(
            icon: SvgPicture.asset(
              'assets/icons/close.svg',
              color: OctopusTheme.of(context).colorTheme.contentView,
            ),
            onPressed: () => channel.cancelAttachmentUpload(attachmentId),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: UploadProgressIndicator(
            uploaded: sent,
            total: total,
          ),
        ),
      ],
    );
  }
}

class _FailedState extends StatelessWidget {
  const _FailedState({
    this.error,
    required this.messageId,
    required this.attachmentId,
  });

  final String? error;
  final String messageId;
  final String attachmentId;

  @override
  Widget build(BuildContext context) {
    final channel = OctopusChannel.of(context).channel;
    final theme = OctopusTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconButton(
          icon: SvgPicture.asset(
            'assets/icons/retry.svg',
            color: theme.colorTheme.contentView,
          ),
          onPressed: () {
            channel.retryAttachmentUpload(messageId, attachmentId);
          },
        ),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorTheme.overlayDark.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              child: Text(
                'sdfdsfsdf',
                style: theme.textTheme.primaryGreyBody.copyWith(
                  color: theme.colorTheme.contentView,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          backgroundColor: OctopusTheme.of(context).colorTheme.overlayDark,
          maxRadius: 12,
          child: SvgPicture.asset(
            'assets/icons/check.svg',
            color: OctopusTheme.of(context).colorTheme.contentView,
          ),
        ),
      );
}
