import 'dart:async';
import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

class _IVideoService {
  _IVideoService._();

  static final _IVideoService instance = _IVideoService._();

  Future<Uint8List?> generateVideoThumbnail({
    required String video,
    ImageFormat imageFormat = ImageFormat.PNG,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) =>
      VideoThumbnail.thumbnailData(
        video: video,
        imageFormat: imageFormat,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        timeMs: timeMs,
        quality: quality,
      );
}

_IVideoService get VideoService => _IVideoService.instance;
