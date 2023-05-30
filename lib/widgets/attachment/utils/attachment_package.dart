import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/message.dart';

class AttachmentPackage {
  AttachmentPackage({
    required this.attachment,
    required this.message,
  });

  final Attachment attachment;

  final Message message;
}
