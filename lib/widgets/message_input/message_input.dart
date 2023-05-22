import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/attachment/attachment_picker.dart';
import 'package:octopus/widgets/auto_complete_input/auto_complete_input.dart';
import 'package:octopus/widgets/message_input/message_input_controller.dart';
import 'package:octopus/widgets/message_input/message_send_button.dart';
import 'package:octopus/core/ui/simple_safe_area.dart';
import 'package:octopus/widgets/message_input/quoted_message_input.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:octopus/core/extensions/extension_platformfile.dart';

typedef MessageValidator = bool Function(Message message);

typedef AttachmentLimitExceedListener = void Function(
  int limit,
  String error,
);

typedef ActionButtonBuilder = Widget Function(
  BuildContext context,
  IconButton defaultActionButton,
);

enum ActionsLocation {
  /// Align to left
  left,

  /// Align to right
  right,

  /// Align to left but inside the [TextField]
  leftInside,

  /// Align to right but inside the [TextField]
  rightInside,
}

enum DefaultAttachmentTypes {
  /// Image Attachment
  image,

  /// Video Attachment
  video,

  /// File Attachment
  file,
}

typedef ErrorListener = void Function(
  Object error,
  StackTrace? stackTrace,
);

class MessageInput extends StatefulWidget {
  const MessageInput({
    super.key,
    this.onMessageSent,
    this.preMessageSending,
    this.maxHeight = 150,
    this.focusNode,
    this.autofocus = true,
    this.actionsLocation = ActionsLocation.left,
    this.actions = const [],
    this.disableAttachments = false,
    this.showCommandsButton = true,
    this.attachmentButtonBuilder,
    this.commandButtonBuilder,
    this.messageInputController,
    this.onError,
    this.restorationId,
    this.validator = _defaultValidator,
  });

  final void Function(Message)? onMessageSent;

  final FutureOr<Message> Function(Message)? preMessageSending;

  final double maxHeight;

  final FocusNode? focusNode;

  final bool autofocus;

  final ActionsLocation actionsLocation;

  final List<Widget> actions;

  final bool disableAttachments;

  final bool showCommandsButton;

  final ActionButtonBuilder? attachmentButtonBuilder;

  final ActionButtonBuilder? commandButtonBuilder;

  final MessageInputController? messageInputController;

  final ErrorListener? onError;

  final String? restorationId;

  final MessageValidator validator;

  static bool _defaultValidator(Message message) =>
      message.text?.isNotEmpty == true;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput>
    with RestorationMixin<MessageInput> {
  final _imagePicker = ImagePicker();
  late FocusNode _focusNode = widget.focusNode ?? FocusNode();
  late final _isInternalFocusNode = widget.focusNode == null;

  bool get _commandEnabled => false;

  bool _openFilePickerSection = false;

  bool _actionsShrunk = false;

  bool _inputEnabled = true;

  // bool get _isEditing => true;

  RestorableMessageInputController? _controller;

  MessageInputController get _effectiveController =>
      widget.messageInputController ?? _controller!.value;

  @override
  String? get restorationId => widget.restorationId;

  bool get _hasQuotedMessage =>
      _effectiveController.value.quotedMessage != null;

  void _createLocalController([Message? message]) {
    assert(_controller == null, '');
    _controller = RestorableMessageInputController(message: message);
  }

  void _registerController() {
    assert(_controller != null, '');

    registerForRestoration(
      _controller!,
      widget.restorationId ?? 'messageInputController',
    );
    _effectiveController.textEditingController
        .removeListener(_onChangedDebounced);
    _effectiveController.textEditingController.addListener(_onChangedDebounced);
    // if (!_isEditing && _timeOut <= 0) _startSlowMode();
  }

  @override
  void initState() {
    super.initState();
    if (widget.messageInputController == null) {
      _createLocalController();
    } else {
      _initialiseEffectiveController();
    }
    _focusNode.addListener(_focusNodeListener);
  }

  void _initialiseEffectiveController() {
    _effectiveController.textEditingController
        .removeListener(_onChangedDebounced);
    _effectiveController.textEditingController.addListener(_onChangedDebounced);
    // if (!_isEditing && _timeOut <= 0) _startSlowMode();
  }

  @override
  void didUpdateWidget(covariant MessageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messageInputController == null &&
        oldWidget.messageInputController != null) {
      _createLocalController(oldWidget.messageInputController!.value);
    } else if (widget.messageInputController != null &&
        oldWidget.messageInputController == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
      // _initialiseEffectiveController();
    }

    // Update _focusNode
    if (widget.focusNode != null && oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_focusNodeListener);
      _focusNode = widget.focusNode!;
      _focusNode.addListener(_focusNodeListener);
    }
  }

  void _focusNodeListener() {
    if (_focusNode.hasFocus) {
      _openFilePickerSection = false;
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MessageValueListenableBuilder(
        valueListenable: _effectiveController,
        builder: (context, value, _) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: OctopusTheme.of(context).colorTheme.contentView,
            ),
            child: SimpleSafeArea(
              enabled: !_openFilePickerSection,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy > 0) {
                    _focusNode.unfocus();
                    if (_openFilePickerSection) {
                      setState(() {
                        _openFilePickerSection = false;
                      });
                    }
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: _hasQuotedMessage
                          ? _buildReplyToMessage()
                          : const Offstage(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _buildTextField(context),
                    ),
                    _buildFilePickerSection(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Flex _buildTextField(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        if (!_commandEnabled && widget.actionsLocation == ActionsLocation.left)
          _buildExpandActionsButton(context),
        _buildTextInput(context),
        _buildSendButton(context),
      ],
    );
  }

  Widget _buildExpandActionsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedCrossFade(
        crossFadeState: _actionsShrunk
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstCurve: Curves.easeOut,
        secondCurve: Curves.easeIn,
        firstChild: IconButton(
          onPressed: () {
            if (_actionsShrunk) {
              setState(() => _actionsShrunk = false);
            }
          },
          icon: Transform.rotate(
            angle: (widget.actionsLocation == ActionsLocation.right ||
                    widget.actionsLocation == ActionsLocation.rightInside)
                ? pi
                : 0,
            child: SvgPicture.asset(
              'assets/icons/circle_right.svg',
              color: OctopusTheme.of(context).colorTheme.brandPrimary,
            ),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(
            height: 24,
            width: 24,
          ),
          splashRadius: 24,
        ),
        secondChild: widget.disableAttachments &&
                !widget.showCommandsButton &&
                !widget.actions.isNotEmpty
            ? const Offstage()
            : Wrap(
                children: <Widget>[
                  if (!widget.disableAttachments)
                    _buildAttachmentButton(context),
                  // if (widget.showCommandsButton &&
                  //     // !_isEditing &&
                  //     channel.state != null &&
                  //     channel.config?.commands.isNotEmpty == true)
                  //   _buildCommandButton(context),
                  ...widget.actions,
                ].insertBetween(const SizedBox(width: 8)),
              ),
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
      ),
    );
  }

  Expanded _buildTextInput(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.5).r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LimitedBox(
                  maxHeight: 40,
                  child: AutoCompleteInput(
                    key: const Key('messageInputText'),
                    controller: _effectiveController,
                    enabled: _inputEnabled,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => sendMessage(),
                    enableSuggestions: true,
                    autofocus: true,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: "Aa",
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 12, 13, 11),
                    ),
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    final streamChannel = OctopusChannel.of(context);
    var message = _effectiveController.value;
    // if (!streamChannel.channel.ownCapabilities
    //         .contains(PermissionType.sendLinks) &&
    //     _urlRegex.allMatches(message.text ?? '').any((element) =>
    //         element.group(0)?.split('.').last.isValidTLD() == true)) {
    //   showInfoDialog(
    //     context,
    //     icon: StreamSvgIcon.error(
    //       color: StreamChatTheme.of(context).colorTheme.accentError,
    //       size: 24,
    //     ),
    //     title: 'Links are disabled',
    //     details: 'Sending links is not allowed in this conversation.',
    //     okText: context.translations.okLabel,
    //   );
    //   return;
    // }

    // final skipEnrichUrl = _effectiveController.ogAttachment == null;

    // var shouldKeepFocus = widget.shouldKeepFocusAfterMessage;

    // shouldKeepFocus ??= !_commandEnabled;

    _effectiveController.reset();

    if (widget.preMessageSending != null) {
      message = await widget.preMessageSending!(message);
    }

    final channel = streamChannel.channel;
    if (!channel.state!.isUpToDate) {
      await streamChannel.reloadChannel();
    }

    // message = message.replaceMentionsWithId();

    try {
      Future sendingFuture;
      // if (_isEditing) {
      //   sendingFuture = channel.updateMessage(
      //     message,
      //     skipEnrichUrl: skipEnrichUrl,
      //   );
      // } else {
      sendingFuture = channel.sendMessage(
        message,
        // skipEnrichUrl: skipEnrichUrl,
      );
      // }

      FocusScope.of(context).requestFocus(_focusNode);

      final resp = await sendingFuture;
      // if (resp.message?.type == 'error') {
      //   _effectiveController.value = message;
      // }
      widget.onMessageSent?.call(resp);
    } catch (e, stk) {
      if (widget.onError != null) {
        widget.onError?.call(e, stk);
      } else {
        rethrow;
      }
    }
  }

  Widget _buildAttachmentButton(BuildContext context) {
    final defaultButton = IconButton(
      icon: SvgPicture.asset(
        'assets/icons/attach.svg',
        color: _openFilePickerSection
            ? OctopusTheme.of(context).colorTheme.brandPrimary
            : OctopusTheme.of(context).colorTheme.icon,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(
        height: 24,
        width: 24,
      ),
      splashRadius: 24,
      onPressed: () async {
        // _showCommandsOverlay = false;
        // _showMentionsOverlay = false;

        if (_openFilePickerSection) {
          setState(() => _openFilePickerSection = false);
        } else {
          showAttachmentModal();
        }
      },
    );

    return widget.attachmentButtonBuilder?.call(context, defaultButton) ??
        defaultButton;
  }

  void showAttachmentModal() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }

    if (!kIsWeb) {
      setState(() {
        _openFilePickerSection = true;
      });
    } else {
      showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text(
                'ssdfds',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('sdfdsfsdfsd'),
              onTap: () {
                pickFile(DefaultAttachmentTypes.image);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('sdfsdfds'),
              onTap: () {
                pickFile(DefaultAttachmentTypes.video);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('sdfdsfds'),
              onTap: () {
                pickFile(DefaultAttachmentTypes.file);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  void pickFile(
    DefaultAttachmentTypes fileType, {
    bool camera = false,
  }) async {
    setState(() => _inputEnabled = false);

    AttachmentFile? file;
    String? attachmentType;
    int? originalWidth;
    int? originalHeight;

    if (fileType == DefaultAttachmentTypes.image) {
      attachmentType = 'image';
    } else if (fileType == DefaultAttachmentTypes.video) {
      attachmentType = 'video';
    } else if (fileType == DefaultAttachmentTypes.file) {
      attachmentType = 'file';
    }

    if (camera) {
      XFile? pickedFile;
      if (fileType == DefaultAttachmentTypes.image) {
        pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
        originalWidth = 3024;
        originalHeight = 4032;
      } else if (fileType == DefaultAttachmentTypes.video) {
        pickedFile = await _imagePicker.pickVideo(source: ImageSource.camera);
        originalWidth = 1080;
        originalHeight = 1920;
      }
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        file = AttachmentFile(
          size: bytes.length,
          path: pickedFile.path,
          bytes: bytes,
        );
      }
    } else {
      late FileType type;
      if (fileType == DefaultAttachmentTypes.image) {
        type = FileType.image;
      } else if (fileType == DefaultAttachmentTypes.video) {
        type = FileType.video;
      } else if (fileType == DefaultAttachmentTypes.file) {
        type = FileType.any;
      }
      final res = await FilePicker.platform.pickFiles(
        type: type,
      );
      if (res?.files.isNotEmpty == true) {
        file = res!.files.single.toAttachmentFile;
      }
    }

    setState(() => _inputEnabled = true);

    if (file == null) return;

    final attachment = Attachment(
      file: file,
      type: attachmentType,
      uploadState: const UploadState.preparing(),
      originalWidth: originalWidth,
      originalHeight: originalHeight,
    );

    // if (file.size! > widget.maxAttachmentSize) {
    //   return _showErrorAlert(
    //     context.translations.fileTooLargeError(
    //       widget.maxAttachmentSize / (1024 * 1024),
    //     ),
    //   );
    // }

    _addAttachments([
      attachment.copyWith(
        file: file,
        // extraData: {...attachment.extraData}
        //   ..update('file_size', ((_) => file!.size!)),
      ),
    ]);
  }

  void _addAttachments(Iterable<Attachment> attachments) {
    // final limit = widget.attachmentLimit;
    // final length = _effectiveController.attachments.length + attachments.length;
    // if (length > limit) {
    //   final onAttachmentLimitExceed = widget.onAttachmentLimitExceed;
    //   if (onAttachmentLimitExceed != null) {
    //     return onAttachmentLimitExceed(
    //       widget.attachmentLimit,
    //       context.translations.attachmentLimitExceedError(limit),
    //     );
    //   }
    //   return _showErrorAlert(
    //     context.translations.attachmentLimitExceedError(limit),
    //   );
    // }

    for (final attachment in attachments) {
      _effectiveController.addAttachment(attachment);
    }

    final channel = OctopusChannel.of(context).channel;
    if (Theme.of(context).platform == Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  _effectiveController.clearAttachments();
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  sendMessage();
                },
                child: const Text("Send"))
          ],
          content: Text("You want to send file to ${channel.name}"),
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text("You want to send file to ${channel.name}"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                _effectiveController.clearAttachments();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                sendMessage();
              },
              child: const Text("Send"),
            )
          ],
        ),
      );
    }
  }

  Widget _buildSendButton(BuildContext context) {
    return MessageSendButton(
      onSendMessage: sendMessage,
      isIdle: !widget.validator(_effectiveController.message),
      isEditEnabled: true,
    );
  }

  late final _onChangedDebounced = debounce(
    () {
      var value = _effectiveController.text;
      if (!mounted) return;
      value = value.trim();

      final channel = OctopusChannel.of(context).channel;
      if (value.isNotEmpty
          // &&
          //     channel.ownCapabilities.contains(PermissionType.sendTypingEvents)
          ) {
        // Notify the server that the user started typing.
        channel.keyStroke().onError(
          (error, stackTrace) {
            widget.onError?.call(error!, stackTrace);
          },
        );
      }

      var actionsLength = widget.actions.length;
      if (widget.showCommandsButton) actionsLength += 1;
      if (!widget.disableAttachments) actionsLength += 1;

      setState(() {
        _actionsShrunk = value.isNotEmpty && actionsLength > 1;
      });

      // _checkContainsUrl(value, context);
      // _checkCommands(value, context);
      // _checkMentions(value, context);
      // _checkEmoji(value, context);
    },
    const Duration(milliseconds: 350),
    leading: true,
  );

  Widget _buildFilePickerSection() {
    final picker = AttachmentPicker(
      messageInputController: _effectiveController,
      onFilePicked: pickFile,
      isOpen: _openFilePickerSection,
      sendImage: sendMessage,
      // pickerSize: _openFilePickerSection ? _kMinMediaPickerSize : 0,
      // attachmentLimit: widget.attachmentLimit,
      // onAttachmentLimitExceeded: widget.onAttachmentLimitExceed,
      // maxAttachmentSize: widget.maxAttachmentSize,
      // onError: _showErrorAlert,
    );

    // if (_openFilePickerSection && widget.attachmentsPickerBuilder != null) {
    //   return widget.attachmentsPickerBuilder!(
    //     context,
    //     _effectiveController,
    //     picker,
    //   );
    // }

    return picker;
  }

  Widget _buildReplyToMessage() {
    // if (!_hasQuotedMessage) return const Offstage();
    // final containsUrl = _effectiveController.value.quotedMessage!.attachments
    //     .any((element) => element.titleLink != null);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: OctopusTheme.of(context).colorTheme.disabled,
            width: 1,
          ),
        ),
      ),
      child: QuotedMessageInput(
        reverse: true,
        // showBorder: !containsUrl,
        message: _effectiveController.value.quotedMessage!,
        messageTheme: OctopusTheme.of(context).otherMessageTheme,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        onCancelReply: () {
          _effectiveController.clearQuotedMessage();
          _focusNode.unfocus();
        },
      ),
    );
  }

  @override
  void dispose() {
    _effectiveController.textEditingController
        .removeListener(_onChangedDebounced);
    _controller?.dispose();
    _focusNode.removeListener(_focusNodeListener);
    if (_isInternalFocusNode) _focusNode.dispose();
    // _stopSlowMode();
    _onChangedDebounced.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // _streamChatTheme = StreamChatTheme.of(context);
    // _messageInputTheme = StreamMessageInputTheme.of(context);

    super.didChangeDependencies();
  }
}
