import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/attachment/utils/attachment_package.dart';
import 'package:octopus/widgets/attachment/video_thumbnail.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GalleryFooter extends StatefulWidget implements PreferredSizeWidget {
  const GalleryFooter({
    super.key,
    this.onBackPressed,
    this.onTitleTap,
    this.onImageTap,
    this.currentPage = 0,
    this.totalPages = 0,
    required this.mediaAttachmentPackages,
    this.mediaSelectedCallBack,
    this.backgroundColor,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final VoidCallback? onBackPressed;

  final VoidCallback? onTitleTap;

  final VoidCallback? onImageTap;

  final int currentPage;

  final int totalPages;

  final List<AttachmentPackage> mediaAttachmentPackages;

  final ValueChanged<int>? mediaSelectedCallBack;

  final Color? backgroundColor;

  @override
  _GalleryFooterState createState() => _GalleryFooterState();

  @override
  final Size preferredSize;
}

class _GalleryFooterState extends State<GalleryFooter> {
  @override
  Widget build(BuildContext context) {
    const showShareButton = !kIsWeb;
    final mediaQueryData = MediaQuery.of(context);
    final galleryFooterThemeData = OctopusTheme.of(context).galleryFooterTheme;
    return SizedBox.fromSize(
      size: Size(
        mediaQueryData.size.width,
        mediaQueryData.padding.bottom + widget.preferredSize.height,
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: BottomAppBar(
          color:
              widget.backgroundColor ?? galleryFooterThemeData.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!showShareButton)
                Container(
                  width: 48,
                )
              else
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/share.svg',
                    width: 24,
                    height: 24,
                    color: galleryFooterThemeData.shareIconColor,
                  ),
                  onPressed: () async {
                    final attachment = widget
                        .mediaAttachmentPackages[widget.currentPage].attachment;
                    final url = attachment.url ??
                        attachment.secureUrl ??
                        attachment.thumbnailUrl!;
                    final type = attachment.type == 'image'
                        ? 'jpg'
                        : url.split('?').first.split('.').last;
                    final request = await HttpClient().getUrl(Uri.parse(url));
                    final response = await request.close();
                    final bytes =
                        await consolidateHttpClientResponseBytes(response);
                    final tmpPath = await getTemporaryDirectory();
                    final filePath = '${tmpPath.path}/${attachment.id}.$type';
                    final file = File(filePath);
                    await file.writeAsBytes(bytes);
                    await Share.shareFiles(
                      [filePath],
                      mimeTypes: [
                        'image/$type',
                      ],
                    );
                  },
                ),
              InkWell(
                onTap: widget.onTitleTap,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${widget.currentPage}/${widget.totalPages}',
                        style: galleryFooterThemeData.titleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/grid.svg',
                  color: galleryFooterThemeData.gridIconButtonColor,
                ),
                onPressed: () => _showPhotosModal(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotosModal(context) {
    final chatThemeData = OctopusTheme.of(context);
    final galleryFooterThemeData = OctopusTheme.of(context).galleryFooterTheme;
    showModalBottomSheet(
      context: context,
      barrierColor: galleryFooterThemeData.bottomSheetBarrierColor,
      backgroundColor: galleryFooterThemeData.bottomSheetBackgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        const crossAxisCount = 3;
        final noOfRowToShowInitially =
            widget.mediaAttachmentPackages.length > crossAxisCount ? 2 : 1;
        final size = MediaQuery.of(context).size;
        final initialChildSize =
            48 + (size.width * noOfRowToShowInitially) / crossAxisCount;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: initialChildSize / size.height,
          minChildSize: initialChildSize / size.height,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Photos',
                          style:
                              galleryFooterThemeData.bottomSheetPhotosTextStyle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/close.svg',
                          color:
                              galleryFooterThemeData.bottomSheetCloseIconColor,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.mediaAttachmentPackages.length,
                    padding: const EdgeInsets.all(1),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      Widget media;
                      final attachmentPackage =
                          widget.mediaAttachmentPackages[index];
                      final attachment = attachmentPackage.attachment;
                      final message = attachmentPackage.message;
                      if (attachment.type == 'video') {
                        media = InkWell(
                          onTap: () => widget.mediaSelectedCallBack!(index),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: VideoThumbnailImage(
                              video: (attachment.file?.path ?? attachment.url)!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        media = InkWell(
                          onTap: () => widget.mediaSelectedCallBack!(index),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: attachment.url ??
                                  attachment.secureUrl ??
                                  attachment.thumbnailUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }

                      return Stack(
                        children: [
                          media,
                          if (message.sender != null)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.6),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: chatThemeData
                                          .colorTheme.primaryGrey
                                          .withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                child: UserAvatar(
                                  user: message.sender!,
                                  constraints:
                                      BoxConstraints.tight(const Size(24, 24)),
                                  showOnlineStatus: false,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
