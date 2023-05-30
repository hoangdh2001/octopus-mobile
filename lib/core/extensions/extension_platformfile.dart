import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:octopus/core/data/models/attachment_file.dart';

extension PlatformFileX on PlatformFile {
  /// Converts the [PlatformFile] into [AttachmentFile]
  AttachmentFile get toAttachmentFile => AttachmentFile(
        // ignore: avoid_redundant_argument_values
        path: kIsWeb ? null : path,
        name: name,
        bytes: bytes,
        size: size,
      );
}
