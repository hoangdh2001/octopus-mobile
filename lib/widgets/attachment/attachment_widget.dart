import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';

enum AttachmentSource {
  local,

  network;

  T when<T>({
    required T Function() local,
    required T Function() network,
  }) {
    switch (this) {
      case AttachmentSource.local:
        return local();
      case AttachmentSource.network:
        return network();
    }
  }
}

abstract class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({
    super.key,
    required this.message,
    required this.attachment,
    required this.size,
    AttachmentSource? source,
  }) : _source = source;

  final Size size;
  final AttachmentSource? _source;

  final Message message;

  final Attachment attachment;

  AttachmentSource get source =>
      _source ??
      (attachment.file != null
          ? AttachmentSource.local
          : AttachmentSource.network);
}

class AttachmentError extends StatelessWidget {
  const AttachmentError({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) => Center(
        child: AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Container(
            color: OctopusTheme.of(context)
                .colorTheme
                .brandPrimary
                .withOpacity(0.1),
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: OctopusTheme.of(context).colorTheme.icon,
              ),
            ),
          ),
        ),
      );
}
