import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/attachment/media_list_view.dart';
import 'package:octopus/widgets/attachment/utils/media_list_view_controller.dart';
import 'package:octopus/widgets/message_input/message_input.dart';
import 'package:octopus/widgets/message_input/message_input_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

/// Callback for when a file has to be picked.
typedef FilePickerCallback = void Function(
  DefaultAttachmentTypes fileType, {
  bool camera,
});

/// Callback for building an icon for a custom attachment type.
typedef CustomAttachmentIconBuilder = Widget Function(
  BuildContext context,
  bool active,
);

typedef SendImageCallback = void Function();

/// A widget that allows to pick an attachment.
class AttachmentPicker extends StatefulWidget {
  /// Default constructor for [AttachmentPicker] which creates the Stream
  /// attachment picker widget.
  const AttachmentPicker({
    super.key,
    required this.messageInputController,
    required this.onFilePicked,
    this.isOpen = false,
    this.pickerSize = 360.0,
    this.attachmentLimit = 10,
    this.onAttachmentLimitExceeded,
    this.onError,
    this.allowedAttachmentTypes = const [
      DefaultAttachmentTypes.image,
      DefaultAttachmentTypes.file,
      DefaultAttachmentTypes.video,
    ],
    this.customAttachmentTypes = const [],
    this.attachmentThumbnailSize = const ThumbnailSize(400, 400),
    this.attachmentThumbnailFormat = ThumbnailFormat.jpeg,
    this.attachmentThumbnailQuality = 100,
    this.attachmentThumbnailScale = 1,
    this.sendImage,
  });

  /// True if the picker is open.
  final bool isOpen;

  /// The picker size in height.
  final double pickerSize;

  /// The [StreamMessageInputController] linked to this picker.
  final MessageInputController messageInputController;

  /// The limit of attachments that can be picked.
  final int attachmentLimit;

  /// The callback for when the attachment limit is exceeded.
  final AttachmentLimitExceedListener? onAttachmentLimitExceeded;

  /// Callback for when an error occurs in the attachment picker.
  final ValueChanged<String>? onError;

  /// Callback for when file is picked.
  final FilePickerCallback onFilePicked;

  /// The list of attachment types that can be picked.
  final List<DefaultAttachmentTypes> allowedAttachmentTypes;

  /// The list of custom attachment types that can be picked.
  final List<CustomAttachmentType> customAttachmentTypes;

  /// Size of the attachment thumbnails.
  ///
  /// Defaults to (400, 400).
  final ThumbnailSize attachmentThumbnailSize;

  /// Format of the attachment thumbnails.
  ///
  /// Defaults to [ThumbnailFormat.jpeg].
  final ThumbnailFormat attachmentThumbnailFormat;

  /// The quality value for the attachment thumbnails.
  ///
  /// Valid from 1 to 100.
  /// Defaults to 100.
  final int attachmentThumbnailQuality;

  /// The scale to apply on the [attachmentThumbnailSize].
  final double attachmentThumbnailScale;

  final SendImageCallback? sendImage;

  /// Used to create a new copy of [StreamAttachmentPicker] with modified
  /// properties.
  AttachmentPicker copyWith({
    Key? key,
    MessageInputController? messageInputController,
    FilePickerCallback? onFilePicked,
    bool? isOpen,
    double? pickerSize,
    int? attachmentLimit,
    AttachmentLimitExceedListener? onAttachmentLimitExceeded,
    ValueChanged<bool>? onChangeInputState,
    ValueChanged<String>? onError,
    List<DefaultAttachmentTypes>? allowedAttachmentTypes,
    List<CustomAttachmentType>? customAttachmentTypes,
    ThumbnailSize? attachmentThumbnailSize,
    ThumbnailFormat? attachmentThumbnailFormat,
    int? attachmentThumbnailQuality,
    double? attachmentThumbnailScale,
    SendImageCallback? sendImage,
  }) =>
      AttachmentPicker(
        key: key ?? this.key,
        messageInputController:
            messageInputController ?? this.messageInputController,
        onFilePicked: onFilePicked ?? this.onFilePicked,
        isOpen: isOpen ?? this.isOpen,
        pickerSize: pickerSize ?? this.pickerSize,
        attachmentLimit: attachmentLimit ?? this.attachmentLimit,
        onAttachmentLimitExceeded:
            onAttachmentLimitExceeded ?? this.onAttachmentLimitExceeded,
        onError: onError ?? this.onError,
        allowedAttachmentTypes:
            allowedAttachmentTypes ?? this.allowedAttachmentTypes,
        customAttachmentTypes:
            customAttachmentTypes ?? this.customAttachmentTypes,
        attachmentThumbnailSize:
            attachmentThumbnailSize ?? this.attachmentThumbnailSize,
        attachmentThumbnailFormat:
            attachmentThumbnailFormat ?? this.attachmentThumbnailFormat,
        attachmentThumbnailQuality:
            attachmentThumbnailQuality ?? this.attachmentThumbnailQuality,
        attachmentThumbnailScale:
            attachmentThumbnailScale ?? this.attachmentThumbnailScale,
        sendImage: sendImage ?? this.sendImage,
      );

  @override
  State<AttachmentPicker> createState() => _AttachmentPickerState();
}

class _AttachmentPickerState extends State<AttachmentPicker> {
  int _filePickerIndex = 0;
  final _mediaListViewController = MediaListViewController();

  @override
  Widget build(BuildContext context) {
    final _chatTheme = OctopusTheme.of(context);
    final messageInputController = widget.messageInputController;

    final _attachmentContainsImage =
        messageInputController.attachments.any((it) => it.type == 'image');

    final _attachmentContainsFile =
        messageInputController.attachments.any((it) => it.type == 'file');

    final _attachmentContainsVideo =
        messageInputController.attachments.any((it) => it.type == 'video');

    final attachmentLimitCrossed =
        messageInputController.attachments.length >= widget.attachmentLimit;

    Color _getIconColor(int index) {
      final chatThemeData = _chatTheme;
      switch (index) {
        case 0:
          return _filePickerIndex == 0 || _attachmentContainsImage
              ? chatThemeData.colorTheme.primaryGrey
              : (_attachmentContainsImage
                  ? chatThemeData.colorTheme.primaryGrey
                  : chatThemeData.colorTheme.primaryGrey.withOpacity(
                      messageInputController.attachments.isEmpty ? 0.5 : 0.2,
                    ));
        case 1:
          return _attachmentContainsFile
              ? chatThemeData.colorTheme.primaryGrey
              : (messageInputController.attachments.isEmpty
                  ? chatThemeData.colorTheme.primaryGrey.withOpacity(0.5)
                  : chatThemeData.colorTheme.primaryGrey.withOpacity(0.2));
        case 2:
          return widget.messageInputController.attachments.isNotEmpty &&
                  (!_attachmentContainsImage || attachmentLimitCrossed)
              ? chatThemeData.colorTheme.primaryGrey.withOpacity(0.2)
              : _attachmentContainsFile &&
                      messageInputController.attachments.isNotEmpty
                  ? chatThemeData.colorTheme.primaryGrey.withOpacity(0.2)
                  : chatThemeData.colorTheme.primaryGrey.withOpacity(0.5);
        case 3:
          return widget.messageInputController.attachments.isNotEmpty &&
                  (!_attachmentContainsVideo || attachmentLimitCrossed)
              ? chatThemeData.colorTheme.primaryGrey.withOpacity(0.2)
              : _attachmentContainsFile &&
                      messageInputController.attachments.isNotEmpty
                  ? chatThemeData.colorTheme.primaryGrey.withOpacity(0.2)
                  : chatThemeData.colorTheme.primaryGrey.withOpacity(0.5);
        default:
          return Colors.black;
      }
    }

    return AnimatedContainer(
      duration:
          widget.isOpen ? const Duration(milliseconds: 300) : Duration.zero,
      curve: Curves.easeOut,
      height: widget.isOpen ? widget.pickerSize : 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: widget.pickerSize,
              child: Material(
                color: Colors.grey.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        if (widget.allowedAttachmentTypes
                            .contains(DefaultAttachmentTypes.image))
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/pictures.svg',
                              color: _getIconColor(0),
                            ),
                            onPressed:
                                messageInputController.attachments.isNotEmpty &&
                                        !_attachmentContainsImage
                                    ? null
                                    : () {
                                        setState(() {
                                          _filePickerIndex = 0;
                                        });
                                      },
                          ),
                        if (widget.allowedAttachmentTypes
                            .contains(DefaultAttachmentTypes.file))
                          IconButton(
                            iconSize: 32,
                            icon: SvgPicture.asset(
                              'assets/icons/files.svg',
                              color: _getIconColor(1),
                            ),
                            onPressed:
                                messageInputController.attachments.isNotEmpty &&
                                        !_attachmentContainsFile
                                    ? null
                                    : () {
                                        widget.onFilePicked(
                                            DefaultAttachmentTypes.file);
                                      },
                          ),
                        if (widget.allowedAttachmentTypes
                            .contains(DefaultAttachmentTypes.image))
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/camera.svg',
                              color: _getIconColor(2),
                            ),
                            onPressed: attachmentLimitCrossed ||
                                    (messageInputController
                                            .attachments.isNotEmpty &&
                                        !_attachmentContainsVideo)
                                ? null
                                : () {
                                    widget.onFilePicked(
                                      DefaultAttachmentTypes.image,
                                      camera: true,
                                    );
                                  },
                          ),
                        if (widget.allowedAttachmentTypes
                            .contains(DefaultAttachmentTypes.video))
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              'assets/icons/record.svg',
                              color: _getIconColor(3),
                            ),
                            onPressed: attachmentLimitCrossed ||
                                    (messageInputController
                                            .attachments.isNotEmpty &&
                                        !_attachmentContainsVideo)
                                ? null
                                : () {
                                    widget.onFilePicked(
                                      DefaultAttachmentTypes.video,
                                      camera: true,
                                    );
                                  },
                          ),
                        for (int i = 0;
                            i < widget.customAttachmentTypes.length;
                            i++)
                          IconButton(
                            onPressed: () {
                              if (messageInputController
                                  .attachments.isNotEmpty) {
                                if (!messageInputController.attachments.any(
                                    (e) =>
                                        e.type ==
                                        widget.customAttachmentTypes[i].type)) {
                                  return;
                                }
                              }

                              setState(() {
                                _filePickerIndex = i + 1;
                              });
                            },
                            icon: widget.customAttachmentTypes[i].iconBuilder(
                                context, _filePickerIndex == i + 1),
                          ),
                        const Spacer(),
                        if (widget.isOpen)
                          FutureBuilder(
                            future: PhotoManager.requestPermissionExtend(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == PermissionState.limited) {
                                return TextButton(
                                  child: Text('sdfdsf'),
                                  onPressed: () async {
                                    await PhotoManager.presentLimited();
                                    _mediaListViewController.updateMedia(
                                      newValue: true,
                                    );
                                  },
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                      ],
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: _chatTheme.colorTheme.contentView,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.isOpen &&
                        (widget.allowedAttachmentTypes
                                .contains(DefaultAttachmentTypes.image) ||
                            (widget.allowedAttachmentTypes
                                .contains(DefaultAttachmentTypes.file))))
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _chatTheme.colorTheme.contentView,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _PickerWidget(
                            mediaListViewController: _mediaListViewController,
                            filePickerIndex: _filePickerIndex,
                            chatTheme: _chatTheme,
                            containsFile: _attachmentContainsFile,
                            selectedMedias: messageInputController.attachments
                                .map((e) => e.id)
                                .toList(),
                            onAddMoreFilesClick: widget.onFilePicked,
                            onMediaSelected: (media) {
                              if (messageInputController.attachments
                                  .any((e) => e.id == media.id)) {
                                messageInputController
                                    .removeAttachmentById(media.id);
                              } else {
                                _addAssetAttachment(media);
                              }
                            },
                            allowedAttachmentTypes:
                                widget.allowedAttachmentTypes,
                            customAttachmentTypes: widget.customAttachmentTypes,
                            mediaThumbnailSize: widget.attachmentThumbnailSize,
                            mediaThumbnailFormat:
                                widget.attachmentThumbnailFormat,
                            mediaThumbnailQuality:
                                widget.attachmentThumbnailQuality,
                            mediaThumbnailScale:
                                widget.attachmentThumbnailScale,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (messageInputController.attachments.where((attachment) => attachment.type == 'image' || attachment.type == 'video').isNotEmpty)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            bottom: messageInputController.attachments.isNotEmpty ? 30 : -80,
            child: Container(
              width: 0.9.sw,
              height: 40.h,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                style: OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                onPressed: () {
                  widget.sendImage?.call();
                },
                child: Text(
                    'Send${messageInputController.attachments.isNotEmpty ? ' ${messageInputController.attachments.length}' : ''}'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addAssetAttachment(AssetEntity medium) async {
    final mediaFile = await medium.originFile;
    if (mediaFile == null) return;

    final tempDir = await getTemporaryDirectory();

    // TODO: Confirm that this max resolution is final
    // Taken from https://getstream.io/chat/docs/flutter-dart/file_uploads/?language=dart#image-resizing
    const maxCDNImageResolution = 16800000;
    final imageResolution = medium.width * medium.height;
    File? cachedFile;
    if (imageResolution > maxCDNImageResolution) {
      final aspect = imageResolution / maxCDNImageResolution;
      final updatedSize = medium.size / (math.sqrt(aspect));
      final resizedImage = await medium.thumbnailDataWithSize(
        ThumbnailSize(
          updatedSize.width.floor(),
          updatedSize.height.floor(),
        ),
        quality: 70, // TODO: investigate compressing all images
      );
      final file =
          await File('${tempDir.path}/${mediaFile.path.split('/').last}')
              .create();
      file.writeAsBytesSync(resizedImage!);
      cachedFile = file;
    } else {
      cachedFile = await mediaFile
          .copy('${tempDir.path}/${mediaFile.path.split('/').last}');
    }

    final file = AttachmentFile(
      path: cachedFile.path,
      size: await cachedFile.length(),
      bytes: cachedFile.readAsBytesSync(),
    );

    // if (file.size! > widget.maxAttachmentSize) {
    //   return widget.onError?.call(
    //     context.translations.fileTooLargeError(
    //       widget.maxAttachmentSize / (1024 * 1024),
    //     ),
    //   );
    // }

    setState(() {
      final attachment = Attachment(
        id: medium.id,
        file: file,
        type: medium.type == AssetType.image ? 'image' : 'video',
        originalWidth: medium.width,
        originalHeight: medium.height,
      );
      _addAttachments([attachment]);
    });
  }

  /// Adds an attachment to the [messageInputController.attachments] map
  void _addAttachments(Iterable<Attachment> attachments) {
    final limit = widget.attachmentLimit;
    final length =
        widget.messageInputController.attachments.length + attachments.length;
    if (length > limit) {
      final onAttachmentLimitExceed = widget.onAttachmentLimitExceeded;
      if (onAttachmentLimitExceed != null) {
        // return onAttachmentLimitExceed(
        //   widget.attachmentLimit,
        //   context.translations.attachmentLimitExceedError(limit),
        // );
      }
      // return widget.onError?.call(
      //   context.translations.attachmentLimitExceedError(limit),
      // );
    }
    for (final attachment in attachments) {
      widget.messageInputController.addAttachment(attachment);
    }
  }
}

class _PickerWidget extends StatefulWidget {
  const _PickerWidget({
    required this.filePickerIndex,
    required this.containsFile,
    required this.selectedMedias,
    required this.onAddMoreFilesClick,
    required this.onMediaSelected,
    required this.chatTheme,
    required this.allowedAttachmentTypes,
    required this.customAttachmentTypes,
    required this.mediaListViewController,
    this.mediaThumbnailSize = const ThumbnailSize(400, 400),
    this.mediaThumbnailFormat = ThumbnailFormat.jpeg,
    this.mediaThumbnailQuality = 100,
    this.mediaThumbnailScale = 1,
  });

  final int filePickerIndex;
  final bool containsFile;
  final List<String> selectedMedias;
  final void Function(DefaultAttachmentTypes) onAddMoreFilesClick;
  final void Function(AssetEntity) onMediaSelected;
  final OctopusThemeData chatTheme;
  final List<DefaultAttachmentTypes> allowedAttachmentTypes;
  final List<CustomAttachmentType> customAttachmentTypes;
  final MediaListViewController mediaListViewController;
  final ThumbnailSize mediaThumbnailSize;
  final ThumbnailFormat mediaThumbnailFormat;
  final int mediaThumbnailQuality;
  final double mediaThumbnailScale;

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<_PickerWidget> {
  Future<PermissionState>? requestPermission;

  @override
  void initState() {
    super.initState();
    requestPermission = PhotoManager.requestPermissionExtend();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filePickerIndex != 0) {
      return widget.customAttachmentTypes[widget.filePickerIndex - 1]
          .pickerBuilder(context);
    }
    return FutureBuilder<PermissionState>(
      future: requestPermission,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Offstage();
        }

        if ([PermissionState.authorized, PermissionState.limited]
            .contains(snapshot.data)) {
          if (widget.containsFile ||
              !widget.allowedAttachmentTypes
                  .contains(DefaultAttachmentTypes.image)) {
            return GestureDetector(
              onTap: () {
                widget.onAddMoreFilesClick(DefaultAttachmentTypes.file);
              },
              child: Container(
                constraints: const BoxConstraints.expand(),
                // color: widget.chatTheme.colorTheme.inputBg,
                alignment: Alignment.center,
                // child: Text(
                //   'sdfdsfds',
                //   style: TextStyle(
                //     // color: widget.chatTheme.colorTheme.accentPrimary,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
            );
          }
          return MediaListView(
            selectedIds: widget.selectedMedias,
            onSelect: widget.onMediaSelected,
            controller: widget.mediaListViewController,
            thumbnailSize: widget.mediaThumbnailSize,
            thumbnailFormat: widget.mediaThumbnailFormat,
            thumbnailQuality: widget.mediaThumbnailQuality,
            thumbnailScale: widget.mediaThumbnailScale,
          );
        }

        return InkWell(
          onTap: () async {
            PhotoManager.openSetting();
          },
          child: ColoredBox(
            color: widget.chatTheme.colorTheme.primaryGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'svgs/icon_picture_empty_state.svg',
                  package: 'stream_chat_flutter',
                  height: 140,
                  // color: widget.chatTheme.colorTheme.disabled,
                ),
                // Text(
                //   context.translations.enablePhotoAndVideoAccessMessage,
                //   style: widget.streamChatTheme.textTheme.body.copyWith(
                //     color: widget.streamChatTheme.colorTheme.textLowEmphasis,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 6),
                // Center(
                //   child: Text(
                //     context.translations.allowGalleryAccessMessage,
                //     style: widget.streamChatTheme.textTheme.bodyBold.copyWith(
                //       color: widget.streamChatTheme.colorTheme.accentPrimary,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Class which holds data for a custom attachment type in the attachment picker
class CustomAttachmentType {
  /// Default constructor for creating a custom attachment for the attachment
  /// picker.
  CustomAttachmentType({
    required this.type,
    required this.iconBuilder,
    required this.pickerBuilder,
  });

  /// Type name.
  String type;

  /// Builds the icon in the attachment picker top row.
  CustomAttachmentIconBuilder iconBuilder;

  /// Builds content in the attachment builder when icon is selected.
  WidgetBuilder pickerBuilder;
}
