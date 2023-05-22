import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/message/message_action.dart';
import 'package:octopus/widgets/message/reactions/reaction_picker.dart';
import 'package:octopus/widgets/message_list/message_list_view.dart';

class MessageActionsModal extends StatefulWidget {
  const MessageActionsModal({
    super.key,
    required this.message,
    required this.messageWidget,
    required this.messageTheme,
    this.showReactions,
    this.showDeleteMessage,
    this.showEditMessage,
    this.onReplyTap,
    this.showCopyMessage = true,
    this.showReplyMessage = true,
    this.showResendMessage = true,
    this.showFlagButton,
    this.showPinButton,
    this.editMessageInputBuilder,
    this.reverse = false,
    this.customActions = const [],
    this.onCopyTap,
  });

  final Widget messageWidget;

  final Widget Function(BuildContext, Message)? editMessageInputBuilder;

  final OnMessageTap? onReplyTap;

  final Message message;

  final OCMessageThemeData messageTheme;

  final bool? showReactions;

  final OnMessageTap? onCopyTap;

  final bool? showDeleteMessage;

  final bool showCopyMessage;

  final bool? showEditMessage;

  final bool showResendMessage;

  final bool? showReplyMessage;

  final bool? showFlagButton;

  final bool? showPinButton;

  final bool reverse;

  final List<MessageAction> customActions;

  @override
  _MessageActionsModalState createState() => _MessageActionsModalState();
}

class _MessageActionsModalState extends State<MessageActionsModal> {
  bool _showActions = true;
  // late List<String> _userPermissions;
  late bool _isMyMessage;

  @override
  Widget build(BuildContext context) => _showMessageOptionsModal();

  Widget _showMessageOptionsModal() {
    final mediaQueryData = MediaQuery.of(context);
    final size = mediaQueryData.size;
    final user = OctopusChannel.of(context).channel.client.state.currentUser;

    final roughMaxSize = size.width * 2 / 3;
    var messageTextLength = widget.message.text?.length ?? 0;
    if (widget.message.quotedMessage != null) {
      var quotedMessageLength =
          (widget.message.quotedMessage!.text?.length ?? 0) + 40;
      if (widget.message.quotedMessage!.attachments.isNotEmpty) {
        quotedMessageLength += 40;
      }
      if (quotedMessageLength > messageTextLength) {
        messageTextLength = quotedMessageLength;
      }
    }
    final roughSentenceSize = messageTextLength *
        (widget.messageTheme.messageTextStyle?.fontSize ?? 1) *
        1.2;
    final divFactor = widget.message.attachments.isNotEmpty
        ? 1
        : (roughSentenceSize == 0 ? 1 : (roughSentenceSize / roughMaxSize));

    final streamChatThemeData = OctopusTheme.of(context);

    final numberOfReactions = streamChatThemeData.reactionIcons.length;
    final shiftFactor =
        numberOfReactions < 5 ? (5 - numberOfReactions) * 0.1 : 0.0;

    // final hasEditPermission = _userPermissions.contains(
    //       PermissionType.updateAnyMessage,
    //     ) ||
    //     _userPermissions.contains(PermissionType.updateOwnMessage);

    // final hasDeletePermission = _userPermissions.contains(
    //       PermissionType.deleteAnyMessage,
    //     ) ||
    //     _userPermissions.contains(PermissionType.deleteOwnMessage);

    // final hasReactionPermission =
    //     _userPermissions.contains(PermissionType.sendReaction);

    final child = Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: widget.reverse
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              if (
              // (widget.showReactions ?? hasReactionPermission) &&
              (widget.message.status == MessageStatus.ready))
                Align(
                  alignment: Alignment(
                    user?.id == widget.message.sender?.id
                        ? (divFactor >= 1.0
                            ? -0.2 - shiftFactor
                            : (1.2 - divFactor))
                        : (divFactor >= 1.0
                            ? shiftFactor + 0.2
                            : -(1.2 - divFactor)),
                    0,
                  ),
                  child: ReactionPicker(
                    message: widget.message,
                  ),
                ),
              const SizedBox(height: 8),
              IgnorePointer(
                child: widget.messageWidget,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.reverse ? 0 : 40,
                ),
                child: SizedBox(
                  width: mediaQueryData.size.width * 0.75,
                  child: Material(
                    color: streamChatThemeData.colorTheme.contentView,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.showReplyMessage ??
                            widget.message.status == MessageStatus.ready)
                          _buildReplyButton(context),
                        // if (widget.showResendMessage)
                        //   _buildResendMessage(context),
                        if (widget.showEditMessage ?? _isMyMessage)
                          _buildEditMessage(context),
                        if (widget.showCopyMessage) _buildCopyButton(context),
                        // if (widget.showFlagButton)
                        //   _buildFlagButton(context),
                        if (widget.showPinButton ?? true)
                          _buildPinButton(context),
                        if (widget.showDeleteMessage ?? (_isMyMessage))
                          _buildDeleteButton(context),
                        if (widget.showDeleteMessage ?? (_isMyMessage))
                          _buildRetrieveMessageButton(context),
                        ...widget.customActions
                            .map((action) => _buildCustomAction(
                                  context,
                                  action,
                                )),
                      ].insertBetween(
                        Container(
                          height: 1,
                          color: streamChatThemeData.colorTheme.border,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.maybePop(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: ColoredBox(
                color: streamChatThemeData.colorTheme.overlay,
              ),
            ),
          ),
          if (_showActions)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              builder: (context, val, child) => Transform.scale(
                scale: val,
                child: child,
              ),
              child: child,
            ),
        ],
      ),
    );
  }

  InkWell _buildCustomAction(
    BuildContext context,
    MessageAction messageAction,
  ) =>
      InkWell(
        onTap: () {
          messageAction.onTap?.call(widget.message);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
          child: Row(
            children: [
              messageAction.leading ?? const Offstage(),
              const SizedBox(width: 16),
              messageAction.title ?? const Offstage(),
            ],
          ),
        ),
      );

  // void _showFlagDialog() async {
  //   final client = OctopusChannel.of(context).channel.client;

  //   final streamChatThemeData = OctopusTheme.of(context);
  //   final answer = await showConfirmationDialog(
  //     context,
  //     title: context.translations.flagMessageLabel,
  //     icon: StreamSvgIcon.flag(
  //       color: streamChatThemeData.colorTheme.accentError,
  //       size: 24,
  //     ),
  //     question: context.translations.flagMessageQuestion,
  //     okText: context.translations.flagLabel,
  //     cancelText: context.translations.cancelLabel,
  //   );

  //   final theme = streamChatThemeData;
  //   if (answer == true) {
  //     try {
  //       await client.flagMessage(widget.message.id);
  //       await showInfoDialog(
  //         context,
  //         icon: StreamSvgIcon.flag(
  //           color: theme.colorTheme.accentError,
  //           size: 24,
  //         ),
  //         details: context.translations.flagMessageSuccessfulText,
  //         title: context.translations.flagMessageSuccessfulLabel,
  //         okText: context.translations.okLabel,
  //       );
  //     } catch (err) {
  //       if (err is StreamChatNetworkError &&
  //           err.errorCode == ChatErrorCode.inputError) {
  //         await showInfoDialog(
  //           context,
  //           icon: StreamSvgIcon.flag(
  //             color: theme.colorTheme.accentError,
  //             size: 24,
  //           ),
  //           details: context.translations.flagMessageSuccessfulText,
  //           title: context.translations.flagMessageSuccessfulLabel,
  //           okText: context.translations.okLabel,
  //         );
  //       } else {
  //         _showErrorAlert();
  //       }
  //     }
  //   }
  // }

  void _togglePin() async {
    final channel = OctopusChannel.of(context).channel;

    Navigator.pop(context);
    try {
      if (!widget.message.pinned) {
        await channel.pinMessage(widget.message);
      } else {
        await channel.unpinMessage(widget.message);
      }
    } catch (e) {
      // _showErrorAlert();
    }
  }

  void _showDeleteDialog() async {
    setState(() {
      _showActions = false;
    });
    final answer = await showConfirmationDialog(
      context,
      title: "Detete Message",
      icon: SvgPicture.asset(
        'assets/icons/flag.svg',
        color: OctopusTheme.of(context).colorTheme.error,
        width: 24,
        height: 24,
      ),
      question: "Are you sure you want to permanently delete this message?",
      okText: "DELETE",
      cancelText: "CANCEL",
    );

    if (answer == true) {
      try {
        Navigator.pop(context);
        await OctopusChannel.of(context)
            .channel
            .deleteMessage(widget.message, hard: true);
      } catch (err) {
        // _showErrorAlert();
      }
    } else {
      setState(() {
        _showActions = true;
      });
    }
  }

  void _deleteMessage() async {
    Navigator.pop(context);
    await OctopusChannel.of(context)
        .channel
        .deleteMessage(widget.message, hard: false);
  }

  // void _showErrorAlert() {
  //   showInfoDialog(
  //     context,
  //     icon: StreamSvgIcon.error(
  //       color: StreamChatTheme.of(context).colorTheme.accentError,
  //       size: 24,
  //     ),
  //     details: context.translations.operationCouldNotBeCompletedText,
  //     title: context.translations.somethingWentWrongError,
  //     okText: context.translations.okLabel,
  //   );
  // }

  Widget _buildReplyButton(BuildContext context) {
    final streamChatThemeData = OctopusTheme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        widget.onReplyTap?.call(widget.message);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/reply.svg',
              color: streamChatThemeData.colorTheme.icon,
            ),
            const SizedBox(width: 16),
            Text(
              "Reply",
              style: streamChatThemeData.textTheme.primaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFlagButton(BuildContext context) {
  //   final streamChatThemeData = OctopusTheme.of(context);
  //   return InkWell(
  //     onTap: _showFlagDialog,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
  //       child: Row(
  //         children: [
  //           StreamSvgIcon.iconFlag(
  //             color: streamChatThemeData.primaryIconTheme.color,
  //           ),
  //           const SizedBox(width: 16),
  //           Text(
  //             context.translations.flagMessageLabel,
  //             style: streamChatThemeData.textTheme.body,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPinButton(BuildContext context) {
    final streamChatThemeData = OctopusTheme.of(context);
    return InkWell(
      onTap: _togglePin,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/pin.svg',
              color: streamChatThemeData.colorTheme.icon,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Text(
              "${widget.message.pinned ? 'Unpin' : 'Pin'} Message",
              style: streamChatThemeData.textTheme.primaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    // final isDeleteFailed =
    //     widget.message.status == MessageSta.failed_delete;
    return InkWell(
      onTap: _deleteMessage,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/trash.svg',
              color: Colors.red,
            ),
            const SizedBox(width: 16),
            Text(
              'Delete message',
              style: OctopusTheme.of(context)
                  .textTheme
                  .primaryGreyBody
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetrieveMessageButton(BuildContext context) {
    // final isDeleteFailed =
    //     widget.message.status == MessageSta.failed_delete;
    return InkWell(
      onTap: _showDeleteDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/u-turn-to-left.svg',
              color: Colors.deepOrangeAccent,
            ),
            const SizedBox(width: 16),
            Text(
              'Retrieve message',
              style: OctopusTheme.of(context)
                  .textTheme
                  .primaryGreyBody
                  .copyWith(color: Colors.deepOrangeAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyButton(BuildContext context) {
    final streamChatThemeData = OctopusTheme.of(context);
    return InkWell(
      onTap: () async {
        widget.onCopyTap?.call(widget.message);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/copy.svg',
              width: 24,
              height: 24,
              color: streamChatThemeData.colorTheme.icon,
            ),
            const SizedBox(width: 16),
            Text(
              "Copy message",
              style: streamChatThemeData.textTheme.primaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditMessage(BuildContext context) {
    final streamChatThemeData = OctopusTheme.of(context);
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        // _showEditBottomSheet(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/edit_message.svg',
              color: streamChatThemeData.colorTheme.icon,
            ),
            const SizedBox(width: 16),
            Text(
              "Edit message",
              style: streamChatThemeData.textTheme.primaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendMessage(BuildContext context) {
    // final isUpdateFailed =
    //     widget.message.status == MessageSendingStatus.failed_update;
    final streamChatThemeData = OctopusTheme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        final channel = OctopusChannel.of(context).channel;
        // if (isUpdateFailed) {
        //   channel.updateMessage(widget.message);
        // } else {
        channel.sendMessage(widget.message);
        // }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/circle_up.svg',
              color: streamChatThemeData.colorTheme.brandPrimary,
            ),
            const SizedBox(width: 16),
            Text(
              "Resend message",
              style: streamChatThemeData.textTheme.primaryGreyBody,
            ),
          ],
        ),
      ),
    );
  }

  // void _showEditBottomSheet(BuildContext context) {
  //   final channel = StreamChannel.of(context).channel;
  //   final streamChatThemeData = StreamChatTheme.of(context);
  //   showModalBottomSheet(
  //     context: context,
  //     elevation: 2,
  //     clipBehavior: Clip.hardEdge,
  //     isScrollControlled: true,
  //     backgroundColor: StreamMessageInputTheme.of(context).inputBackgroundColor,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(16),
  //         topRight: Radius.circular(16),
  //       ),
  //     ),
  //     builder: (context) => Padding(
  //       padding: MediaQuery.of(context).viewInsets,
  //       child: StreamChannel(
  //         channel: channel,
  //         child: Flex(
  //           direction: Axis.vertical,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.all(8),
  //                     child: StreamSvgIcon.edit(
  //                       color: streamChatThemeData.colorTheme.disabled,
  //                     ),
  //                   ),
  //                   Text(
  //                     context.translations.editMessageLabel,
  //                     style: const TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                   IconButton(
  //                     visualDensity: VisualDensity.compact,
  //                     icon: StreamSvgIcon.closeSmall(),
  //                     onPressed: Navigator.of(context).pop,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             if (widget.editMessageInputBuilder != null)
  //               widget.editMessageInputBuilder!(context, widget.message)
  //             else
  //               StreamMessageInput(
  //                 messageInputController: StreamMessageInputController(
  //                   message: widget.message,
  //                 ),
  //                 preMessageSending: (m) {
  //                   FocusScope.of(context).unfocus();
  //                   Navigator.pop(context);
  //                   return m;
  //                 },
  //               ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void didChangeDependencies() {
    final newStreamChannel = OctopusChannel.of(context);
    // _userPermissions = newStreamChannel.channel.ownCapabilities;
    _isMyMessage = widget.message.sender?.id ==
        OctopusChannel.of(context).channel.client.state.currentUser?.id;
    super.didChangeDependencies();
  }
}
