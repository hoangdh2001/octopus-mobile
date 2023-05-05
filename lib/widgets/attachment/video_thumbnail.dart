import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/video_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailImage extends StatefulWidget {
  /// Constructor for creating [VideoThumbnailImage]
  const VideoThumbnailImage({
    super.key,
    required this.video,
    this.width,
    this.height,
    this.fit,
    this.format = ImageFormat.PNG,
    this.errorBuilder,
    this.placeholderBuilder,
  });

  /// Video path
  final String video;

  /// Width of widget
  final double? width;

  /// Height of widget
  final double? height;

  /// Fit of iamge
  final BoxFit? fit;

  /// Image format
  final ImageFormat format;

  /// Builds widget on error
  final Widget Function(BuildContext, Object?)? errorBuilder;

  /// Builds placeholder
  final WidgetBuilder? placeholderBuilder;

  @override
  _VideoThumbnailImageState createState() => _VideoThumbnailImageState();
}

class _VideoThumbnailImageState extends State<VideoThumbnailImage> {
  late Future<Uint8List?> thumbnailFuture;
  late OctopusThemeData _chatTheme;

  @override
  void initState() {
    thumbnailFuture = VideoService.generateVideoThumbnail(
      video: widget.video,
      imageFormat: widget.format,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _chatTheme = OctopusTheme.of(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant VideoThumbnailImage oldWidget) {
    if (oldWidget.video != widget.video || oldWidget.format != widget.format) {
      thumbnailFuture = VideoService.generateVideoThumbnail(
        video: widget.video,
        imageFormat: widget.format,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List?>(
        future: thumbnailFuture,
        builder: (context, snapshot) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: Builder(
            key: ValueKey<AsyncSnapshot<Uint8List?>>(snapshot),
            builder: (_) {
              if (snapshot.hasError) {
                return widget.errorBuilder?.call(context, snapshot.error) ??
                    Center(
                      child: SvgPicture.asset('assets/icons/edit.svg'),
                    );
              }
              if (!snapshot.hasData) {
                return SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: widget.placeholderBuilder?.call(context) ??
                      Shimmer.fromColors(
                        baseColor: _chatTheme.colorTheme.disabled,
                        highlightColor: Colors.grey.shade100,
                        child: Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.cover,
                          height: widget.height,
                          width: widget.width,
                        ),
                      ),
                );
              }
              return SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Image.memory(
                  snapshot.data!,
                  fit: widget.fit,
                  height: widget.height,
                  width: widget.width,
                ),
              );
            },
          ),
        ),
      );
}
