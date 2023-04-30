import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/attachment/image_attachment.dart';
import 'package:octopus/widgets/attachment/image_group.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/message/message_deleted.dart';
import 'package:octopus/widgets/message/message_text.dart';

typedef AttachmentBuilder = Widget Function(
  BuildContext,
  Message,
  List<Attachment>,
);

typedef OnQuotedMessageTap = void Function(String?);

enum DisplayWidget {
  hide,

  gone,

  show,
}

class MessageWidget extends StatefulWidget {
  MessageWidget({
    super.key,
    required this.message,
    this.reverse = false,
    this.translateUserAvatar = true,
    this.shape,
    this.attachmentShape,
    this.borderSide,
    this.attachmentBorderSide,
    this.borderRadiusGeometry,
    this.attachmentBorderRadiusGeometry,
    this.onMessageTap,
    this.showReactionPickerIndicator = false,
    this.showUserAvatar = DisplayWidget.show,
    this.showSendingIndicator = true,
    this.showThreadReplyIndicator = false,
    this.showUsername = true,
    this.showTimestamp = true,
    this.showReactions = true,
    this.showDeleteMessage = true,
    this.showEditMessage = true,
    this.showReplyMessage = true,
    this.showResendMessage = true,
    this.showCopyMessage = true,
    this.showFlagButton = true,
    this.showPinButton = true,
    this.showPinHighlight = true,
    this.onUserAvatarTap,
    this.onLinkTap,
    this.onMessageActions,
    this.userAvatarBuilder,
    this.editMessageInputBuilder,
    this.textBuilder,
    this.bottomRowBuilder,
    this.deletedBottomRowBuilder,
    this.padding,
    this.textPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.attachmentPadding = EdgeInsets.zero,
    this.onQuotedMessageTap,
    this.usernameBuilder,
    this.imageAttachmentThumbnailSize = const Size(400, 400),
    this.imageAttachmentThumbnailResizeType = 'crop',
    this.imageAttachmentThumbnailCropType = 'center',
    required this.messageTheme,
    this.customAttachmentBuilders,
  }) : attachmentBuilders = {
          'image': (context, message, attachments) {
            final border = RoundedRectangleBorder(
              borderRadius: attachmentBorderRadiusGeometry ?? BorderRadius.zero,
            );

            final mediaQueryData = MediaQuery.of(context);
            if (attachments.length > 1) {
              return Padding(
                padding: EdgeInsets.zero,
                child: wrapAttachmentWidget(
                  context,
                  Material(
                    color: Colors.transparent,
                    child: ImageGroup(
                      size: Size(
                        attachments[0].originalWidth?.toDouble() ?? 0.8.sw,
                        attachments[0].originalHeight?.toDouble() ?? 0.3.sw,
                      ),
                      images: attachments,
                      message: message,
                      messageTheme: messageTheme,
                      // onShowMessage: onShowMessage,
                      // onReturnAction: onReturnAction,
                      // onAttachmentTap: onAttachmentTap,
                      imageThumbnailSize: imageAttachmentThumbnailSize,
                      imageThumbnailResizeType:
                          imageAttachmentThumbnailResizeType,
                      imageThumbnailCropType: imageAttachmentThumbnailCropType,
                    ),
                  ),
                  border,
                  reverse,
                ),
              );
            }

            return wrapAttachmentWidget(
              context,
              ImageAttachment(
                attachment: attachments[0],
                message: message,
                messageTheme: messageTheme,
                size: Size(
                  attachments[0].originalWidth?.toDouble() ?? 0.8.sw,
                  attachments[0].originalHeight?.toDouble() ?? 0.3.sw,
                ),
                // onShowMessage: onShowMessage,
                // onReturnAction: onReturnAction,
                // onAttachmentTap: onAttachmentTap != null
                //     ? () {
                //         onAttachmentTap.call(message, attachments[0]);
                //       }
                //     : null,
              ),
              border,
              reverse,
            );
          }
        }..addAll(customAttachmentBuilders ?? {});

  final Widget Function(BuildContext, Message)? editMessageInputBuilder;

  final Widget Function(BuildContext, Message)? textBuilder;

  final Widget Function(BuildContext, Message)? usernameBuilder;

  final void Function(BuildContext, Message)? onMessageActions;

  final Widget Function(BuildContext, Message)? bottomRowBuilder;

  final Widget Function(BuildContext, Message)? deletedBottomRowBuilder;

  final Widget Function(BuildContext, User)? userAvatarBuilder;

  final Message message;

  final bool reverse;

  final ShapeBorder? shape;

  final ShapeBorder? attachmentShape;

  final BorderSide? borderSide;

  final BorderSide? attachmentBorderSide;

  final BorderRadiusGeometry? borderRadiusGeometry;

  final BorderRadiusGeometry? attachmentBorderRadiusGeometry;

  final EdgeInsetsGeometry? padding;

  final EdgeInsets textPadding;

  final OCMessageThemeData messageTheme;

  final EdgeInsetsGeometry attachmentPadding;

  final DisplayWidget showUserAvatar;

  final bool showSendingIndicator;

  final bool showReactions;

  final bool showThreadReplyIndicator;

  final void Function(User)? onUserAvatarTap;

  final void Function(String)? onLinkTap;

  final bool showReactionPickerIndicator;

  final bool showUsername;

  final bool showTimestamp;

  final bool showReplyMessage;

  final bool showEditMessage;

  final bool showCopyMessage;

  final bool showDeleteMessage;

  final bool showResendMessage;

  final bool showFlagButton;

  final bool showPinButton;

  final bool showPinHighlight;

  final bool translateUserAvatar;

  final OnQuotedMessageTap? onQuotedMessageTap;

  final void Function(Message)? onMessageTap;

  final Size imageAttachmentThumbnailSize;

  final String /*clip|crop|scale|fill*/ imageAttachmentThumbnailResizeType;

  final String /*center|top|bottom|left|right*/
      imageAttachmentThumbnailCropType;

  final Map<String, AttachmentBuilder> attachmentBuilders;

  final Map<String, AttachmentBuilder>? customAttachmentBuilders;

  MessageWidget copyWith({
    Key? key,
    void Function(User)? onMentionTap,
    void Function(Message)? onThreadTap,
    void Function(Message)? onReplyTap,
    Widget Function(BuildContext, Message)? editMessageInputBuilder,
    Widget Function(BuildContext, Message)? textBuilder,
    Widget Function(BuildContext, Message)? usernameBuilder,
    Widget Function(BuildContext, Message)? bottomRowBuilder,
    Widget Function(BuildContext, Message)? deletedBottomRowBuilder,
    void Function(BuildContext, Message)? onMessageActions,
    Message? message,
    bool? reverse,
    ShapeBorder? shape,
    ShapeBorder? attachmentShape,
    BorderSide? borderSide,
    BorderSide? attachmentBorderSide,
    BorderRadiusGeometry? borderRadiusGeometry,
    BorderRadiusGeometry? attachmentBorderRadiusGeometry,
    EdgeInsetsGeometry? padding,
    EdgeInsets? textPadding,
    EdgeInsetsGeometry? attachmentPadding,
    DisplayWidget? showUserAvatar,
    bool? showSendingIndicator,
    bool? showReactions,
    bool? allRead,
    bool? showThreadReplyIndicator,
    bool? showInChannelIndicator,
    void Function(User)? onUserAvatarTap,
    void Function(String)? onLinkTap,
    bool? showReactionPickerIndicator,
    bool? showUsername,
    bool? showTimestamp,
    bool? showReplyMessage,
    bool? showThreadReplyMessage,
    bool? showEditMessage,
    bool? showCopyMessage,
    bool? showDeleteMessage,
    bool? showResendMessage,
    bool? showFlagButton,
    bool? showPinButton,
    bool? showPinHighlight,
    Map<String, AttachmentBuilder>? customAttachmentBuilders,
    bool? translateUserAvatar,
    OnQuotedMessageTap? onQuotedMessageTap,
    void Function(Message)? onMessageTap,
    Widget Function(BuildContext, User)? userAvatarBuilder,
    Size? imageAttachmentThumbnailSize,
    String? imageAttachmentThumbnailResizeType,
    String? imageAttachmentThumbnailCropType,
    OCMessageThemeData? messageTheme,
  }) =>
      MessageWidget(
        key: key ?? this.key,
        editMessageInputBuilder:
            editMessageInputBuilder ?? this.editMessageInputBuilder,
        textBuilder: textBuilder ?? this.textBuilder,
        usernameBuilder: usernameBuilder ?? this.usernameBuilder,
        bottomRowBuilder: bottomRowBuilder ?? this.bottomRowBuilder,
        deletedBottomRowBuilder:
            deletedBottomRowBuilder ?? this.deletedBottomRowBuilder,
        onMessageActions: onMessageActions ?? this.onMessageActions,
        message: message ?? this.message,
        reverse: reverse ?? this.reverse,
        shape: shape ?? this.shape,
        attachmentShape: attachmentShape ?? this.attachmentShape,
        borderSide: borderSide ?? this.borderSide,
        attachmentBorderSide: attachmentBorderSide ?? this.attachmentBorderSide,
        borderRadiusGeometry: borderRadiusGeometry ?? this.borderRadiusGeometry,
        attachmentBorderRadiusGeometry: attachmentBorderRadiusGeometry ??
            this.attachmentBorderRadiusGeometry,
        padding: padding ?? this.padding,
        textPadding: textPadding ?? this.textPadding,
        attachmentPadding: attachmentPadding ?? this.attachmentPadding,
        showUserAvatar: showUserAvatar ?? this.showUserAvatar,
        showSendingIndicator: showSendingIndicator ?? this.showSendingIndicator,
        showReactions: showReactions ?? this.showReactions,
        onUserAvatarTap: onUserAvatarTap ?? this.onUserAvatarTap,
        onLinkTap: onLinkTap ?? this.onLinkTap,
        showReactionPickerIndicator:
            showReactionPickerIndicator ?? this.showReactionPickerIndicator,
        showUsername: showUsername ?? this.showUsername,
        showTimestamp: showTimestamp ?? this.showTimestamp,
        showReplyMessage: showReplyMessage ?? this.showReplyMessage,
        showEditMessage: showEditMessage ?? this.showEditMessage,
        showCopyMessage: showCopyMessage ?? this.showCopyMessage,
        showDeleteMessage: showDeleteMessage ?? this.showDeleteMessage,
        showResendMessage: showResendMessage ?? this.showResendMessage,
        showFlagButton: showFlagButton ?? this.showFlagButton,
        showPinButton: showPinButton ?? this.showPinButton,
        showPinHighlight: showPinHighlight ?? this.showPinHighlight,
        translateUserAvatar: translateUserAvatar ?? this.translateUserAvatar,
        onQuotedMessageTap: onQuotedMessageTap ?? this.onQuotedMessageTap,
        onMessageTap: onMessageTap ?? this.onMessageTap,
        userAvatarBuilder: userAvatarBuilder ?? this.userAvatarBuilder,
        imageAttachmentThumbnailSize:
            imageAttachmentThumbnailSize ?? this.imageAttachmentThumbnailSize,
        imageAttachmentThumbnailResizeType:
            imageAttachmentThumbnailResizeType ??
                this.imageAttachmentThumbnailResizeType,
        imageAttachmentThumbnailCropType: imageAttachmentThumbnailCropType ??
            this.imageAttachmentThumbnailCropType,
        messageTheme: messageTheme ?? this.messageTheme,
        customAttachmentBuilders:
            customAttachmentBuilders ?? this.customAttachmentBuilders,
      );

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    with AutomaticKeepAliveClientMixin<MessageWidget> {
  bool get showSendingIndicator => widget.showSendingIndicator;

  bool get isDeleted => widget.message.status == MessageStatus.deleted;

  bool get showUsername => widget.showUsername;

  bool get showTimeStamp => widget.showTimestamp;

  bool get isSendFailed => widget.message.status == MessageStatus.error;

  // bool get isUpdateFailed =>
  //     widget.message.status == MessageStatus.failed_update;

  // bool get isDeleteFailed =>
  //     widget.message.status == MessageSendingStatus.failed_delete;

  // bool get isFailedState => isSendFailed || isUpdateFailed || isDeleteFailed;

  bool get showBottomRow =>
      showUsername ||
      showTimeStamp ||
      // showInChannel ||
      // showSendingIndicator ||
      isDeleted;

  @override
  bool get wantKeepAlive => widget.message.attachments.isNotEmpty;

  bool get hasNonUrlAttachments => widget.message.attachments
      .where((it) => it.type == 'giphy' || it.secureUrl != null)
      .isNotEmpty;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const avatarWidth = 32;
    final bottomRowPadding =
        widget.showUserAvatar != DisplayWidget.gone ? avatarWidth + 8.5 : 0.5;

    // final showReactions = _shouldShowReactions;

    final onMessageTap = widget.onMessageTap;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: Portal(
          child: GestureDetector(
            onTap: onMessageTap == null
                ? null
                : () => onMessageTap(widget.message),
            onLongPress: widget.message.status == MessageStatus.deleted
                ? null
                : () => onLongPress(context),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(8),
              child: FractionallySizedBox(
                alignment: widget.reverse
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                widthFactor: 0.8,
                child: Column(
                  crossAxisAlignment: widget.reverse
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: widget.reverse
                          ? AlignmentDirectional.bottomEnd
                          : AlignmentDirectional.bottomStart,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0
                              // isPinned && widget.showPinHighlight ? 8.0 : 0.0,
                              ),
                          child: Column(
                            crossAxisAlignment: widget.reverse
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // if (widget.message.pinned &&
                              //     widget.message.pinnedBy != null &&
                              //     widget.showPinHighlight)
                              //   _buildPinnedMessage(widget.message),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (!widget.reverse &&
                                      widget.showUserAvatar ==
                                          DisplayWidget.show &&
                                      widget.message.sender != null) ...[
                                    _buildUserAvatar(),
                                    const SizedBox(width: 4),
                                  ],
                                  if (widget.showUserAvatar ==
                                      DisplayWidget.hide)
                                    const SizedBox(width: avatarWidth + 4),
                                  Flexible(
                                    child: PortalTarget(
                                      visible: false,
                                      portalFollower:
                                          // Container(
                                          //   transform: Matrix4.translationValues(
                                          //     widget.reverse ? 12 : -12,
                                          //     0,
                                          //     0,
                                          //   ),
                                          //   constraints: const BoxConstraints(
                                          //     maxWidth: 22 * 6.0,
                                          //   ),
                                          // child: _buildReactionIndicator(
                                          //   context,
                                          // ),
                                          // ),
                                          // :
                                          null,
                                      anchor: Aligned(
                                        follower: Alignment(
                                          widget.reverse ? 1 : -1,
                                          -1,
                                        ),
                                        target: Alignment(
                                          widget.reverse ? -1 : 1,
                                          -1,
                                        ),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                            padding: widget.showReactions
                                                ? EdgeInsets.only(
                                                    // top: widget
                                                    //             .message
                                                    //             .reactionCounts
                                                    //             ?.isNotEmpty ==
                                                    //         true
                                                    //     ? 18
                                                    //     : 0,
                                                    )
                                                : EdgeInsets.zero,
                                            child: (widget.message.status ==
                                                    MessageStatus.deleted)
                                                // && !isFailedState)
                                                ? Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          widget.showUserAvatar ==
                                                                  DisplayWidget
                                                                      .gone
                                                              ? 0
                                                              : 4.0,
                                                    ),
                                                    child: MessageDeleted(
                                                      borderRadiusGeometry: widget
                                                          .borderRadiusGeometry,
                                                      borderSide:
                                                          widget.borderSide,
                                                      shape: widget.shape,
                                                    ),
                                                  )
                                                : Card(
                                                    elevation: 0,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          (widget.showUserAvatar ==
                                                                  DisplayWidget
                                                                      .gone
                                                              ? 0
                                                              : 4.0),
                                                    ),
                                                    shape: widget.shape ??
                                                        RoundedRectangleBorder(
                                                          side: widget
                                                                  .borderSide ??
                                                              BorderSide(
                                                                color: widget
                                                                        .messageTheme
                                                                        .messageBorderColor ??
                                                                    Colors.grey,
                                                              ),
                                                          borderRadius: widget
                                                                  .borderRadiusGeometry ??
                                                              BorderRadius.zero,
                                                        ),
                                                    color: _backgroundColor,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        // if (hasQuotedMessage)
                                                        //   _buildQuotedMessage(),
                                                        if (hasNonUrlAttachments)
                                                          _parseAttachments(),
                                                        // if (!isGiphy)
                                                        _buildTextBubble(),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                          // if (widget
                                          //     .showReactionPickerIndicator)
                                          //   Positioned(
                                          //     right: widget.reverse ? null : 4,
                                          //     left: widget.reverse ? 4 : null,
                                          //     top: -8,
                                          //     child: CustomPaint(
                                          //       painter: ReactionBubblePainter(
                                          //         _streamChatTheme
                                          //             .colorTheme.barsBg,
                                          //         Colors.transparent,
                                          //         Colors.transparent,
                                          //         tailCirclesSpace: 1,
                                          //       ),
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (widget.reverse &&
                                      widget.showUserAvatar ==
                                          DisplayWidget.show &&
                                      widget.message.sender != null) ...[
                                    // _buildUserAvatar(),
                                    const SizedBox(width: 4),
                                  ],
                                ],
                              ),
                              if (showBottomRow)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).textScaleFactor *
                                          18.0,
                                ),
                            ],
                          ),
                        ),
                        if (showBottomRow)
                          Padding(
                            padding: EdgeInsets.only(
                              left: !widget.reverse ? bottomRowPadding : 0,
                              right: widget.reverse ? bottomRowPadding : 0,
                              // bottom: isPinned && widget.showPinHighlight
                              //     ? 6.0
                              //     : 0.0,
                            ),
                            child: widget.bottomRowBuilder?.call(
                                  context,
                                  widget.message,
                                ) ??
                                _bottomRow,
                          ),
                        // if (isFailedState)
                        //   Positioned(
                        //     right: widget.reverse ? 0 : null,
                        //     left: widget.reverse ? null : 0,
                        //     bottom: showBottomRow ? 18 : -2,
                        //     child: StreamSvgIcon.error(size: 20),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Widget _buildQuotedMessage() {
  //   final isMyMessage = widget.message.user?.id == _streamChat.currentUser?.id;
  //   final onTap = widget.message.quotedMessage?.isDeleted != true &&
  //           widget.onQuotedMessageTap != null
  //       ? () => widget.onQuotedMessageTap!(widget.message.quotedMessageId)
  //       : null;
  //   final chatThemeData = _streamChatTheme;
  //   return StreamQuotedMessageWidget(
  //     onTap: onTap,
  //     message: widget.message.quotedMessage!,
  //     messageTheme: isMyMessage
  //         ? chatThemeData.otherMessageTheme
  //         : chatThemeData.ownMessageTheme,
  //     reverse: widget.reverse,
  //     padding: EdgeInsets.only(
  //       right: 8,
  //       left: 8,
  //       top: 8,
  //       bottom: hasNonUrlAttachments ? 8 : 0,
  //     ),
  //   );
  // }

  Widget get _bottomRow {
    if (isDeleted) {
      return widget.deletedBottomRowBuilder?.call(
            context,
            widget.message,
          ) ??
          const Offstage();
    }

    final children = <WidgetSpan>[];

    // final threadParticipants = widget.message.threadParticipants?.take(2);
    // final showThreadParticipants = threadParticipants?.isNotEmpty == true;
    // final replyCount = widget.message.replyCount;

    // var msg = context.translations.threadReplyLabel;
    // if (showThreadReplyIndicator && replyCount! > 1) {
    //   msg = context.translations.threadReplyCountText(replyCount);
    // }

    // final onThreadTap = () async {
    //   try {
    //     var message = widget.message;
    //     if (showInChannel) {
    //       final channel = StreamChannel.of(context);
    //       message = await channel.getMessage(widget.message.parentId!);
    //     }
    //     return widget.onThreadTap!(message);
    //   } catch (e, stk) {
    //     print(e);
    //     print(stk);

    //     return null;
    //   }
    // };

    const usernameKey = Key('username');

    children.addAll([
      if (showUsername) WidgetSpan(child: _buildUsername(usernameKey)),
      if (showTimeStamp)
        WidgetSpan(
          child: Text(
            Jiffy(widget.message.createdAt.toLocal()).jm,
            style: widget.messageTheme.createdAtStyle,
          ),
        ),
      // if (showSendingIndicator)
      //   WidgetSpan(
      //     child: _buildSendingIndicator(),
      //   ),
    ]);

    // final showThreadTail = !(hasUrlAttachments || isGiphy || isOnlyEmoji) &&
    //     (showThreadReplyIndicator || showInChannel);

    // final threadIndicatorWidgets = <WidgetSpan>[
    //   if (showThreadTail)
    //     WidgetSpan(
    //       child: Container(
    //         margin: EdgeInsets.only(
    //           bottom: context.textScaleFactor *
    //               ((widget.messageTheme.repliesStyle?.fontSize ?? 1) / 2),
    //         ),
    //         child: CustomPaint(
    //           size: const Size(16, 32) * context.textScaleFactor,
    //           painter: _ThreadReplyPainter(
    //             context: context,
    //             color: widget.messageTheme.messageBorderColor,
    //             reverse: widget.reverse,
    //           ),
    //         ),
    //       ),
    //     ),
    //   if (showInChannel || showThreadReplyIndicator) ...[
    //     if (showThreadParticipants)
    //       WidgetSpan(
    //         child: SizedBox.fromSize(
    //           size: Size((threadParticipants!.length * 8.0) + 8, 16),
    //           child: _buildThreadParticipantsIndicator(threadParticipants),
    //         ),
    //       ),
    //     WidgetSpan(
    //       child: InkWell(
    //         onTap: widget.onThreadTap != null ? onThreadTap : null,
    //         child: Text(msg, style: widget.messageTheme.repliesStyle),
    //       ),
    //     ),
    //   ],
    // ];

    // if (widget.reverse) {
    //   children.addAll(threadIndicatorWidgets.reversed);
    // } else {
    //   children.insertAll(0, threadIndicatorWidgets);
    // }

    return Text.rich(
      TextSpan(
        children: [
          ...children,
        ].insertBetween(const WidgetSpan(child: SizedBox(width: 8))),
      ),
      maxLines: 1,
      textAlign: widget.reverse ? TextAlign.right : TextAlign.left,
    );
  }

  Widget _buildUsername(Key usernameKey) {
    if (widget.usernameBuilder != null) {
      return widget.usernameBuilder!(context, widget.message);
    }
    return Text(
      '${widget.message.sender?.firstName} ${widget.message.sender?.lastName}' ??
          '',
      maxLines: 1,
      key: usernameKey,
      style: widget.messageTheme.messageAuthorStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Widget _buildUrlAttachment() {
  //   final urlAttachment = widget.message.attachments
  //       .firstWhere((element) => element.ogScrapeUrl != null);

  //   final host = Uri.parse(urlAttachment.ogScrapeUrl!).withScheme.host;
  //   final splitList = host.split('.');
  //   final hostName = splitList.length == 3 ? splitList[1] : splitList[0];
  //   final hostDisplayName = urlAttachment.authorName?.capitalize() ??
  //       getWebsiteName(hostName.toLowerCase()) ??
  //       hostName.capitalize();

  //   return StreamUrlAttachment(
  //     urlAttachment: urlAttachment,
  //     hostDisplayName: hostDisplayName,
  //     textPadding: widget.textPadding,
  //     messageTheme: widget.messageTheme,
  //     onLinkTap: widget.onLinkTap,
  //   );
  // }

  // Widget _buildThreadParticipantsIndicator(Iterable<User> threadParticipants) =>
  //     _ThreadParticipants(
  //       streamChatTheme: _streamChatTheme,
  //       threadParticipants: threadParticipants,
  //     );

  // Widget _buildReactionIndicator(
  //   BuildContext context,
  // ) {
  //   final ownId = _streamChat.currentUser!.id;
  //   final reactionsMap = <String, Reaction>{};
  //   widget.message.latestReactions?.forEach((element) {
  //     if (!reactionsMap.containsKey(element.type) ||
  //         element.user!.id == ownId) {
  //       reactionsMap[element.type] = element;
  //     }
  //   });
  //   final reactionsList = reactionsMap.values.toList()
  //     ..sort((a, b) => a.user!.id == ownId ? 1 : -1);

  //   return AnimatedSwitcher(
  //     duration: const Duration(milliseconds: 300),
  //     child: _shouldShowReactions
  //         ? GestureDetector(
  //             onTap: () => _showMessageReactionsModalBottomSheet(context),
  //             child: StreamReactionBubble(
  //               key: ValueKey('${widget.message.id}.reactions'),
  //               reverse: widget.reverse,
  //               flipTail: widget.reverse,
  //               backgroundColor: widget.messageTheme.reactionsBackgroundColor ??
  //                   Colors.transparent,
  //               borderColor: widget.messageTheme.reactionsBorderColor ??
  //                   Colors.transparent,
  //               maskColor: widget.messageTheme.reactionsMaskColor ??
  //                   Colors.transparent,
  //               reactions: reactionsList,
  //             ),
  //           )
  //         : const SizedBox(),
  //   );
  // }

  // bool get _shouldShowReactions =>
  //     widget.showReactions &&
  //     (widget.message.reactionCounts?.isNotEmpty == true) &&
  //     !widget.message.isDeleted;

  // void _showMessageActionModalBottomSheet(BuildContext context) {
  //   final channel = StreamChannel.of(context).channel;

  //   showDialog(
  //     useRootNavigator: false,
  //     context: context,
  //     barrierColor: _streamChatTheme.colorTheme.overlay,
  //     builder: (context) => StreamChannel(
  //       channel: channel,
  //       child: StreamMessageActionsModal(
  //         messageWidget: widget.copyWith(
  //           key: const Key('MessageWidget'),
  //           message: widget.message.copyWith(
  //             text: (widget.message.text?.length ?? 0) > 200
  //                 ? '${widget.message.text!.substring(0, 200)}...'
  //                 : widget.message.text,
  //           ),
  //           showReactions: false,
  //           showUsername: false,
  //           showTimestamp: false,
  //           translateUserAvatar: false,
  //           showSendingIndicator: false,
  //           padding: EdgeInsets.zero,
  //           showReactionPickerIndicator: widget.showReactions &&
  //               (widget.message.status == MessageSendingStatus.sent) &&
  //               channel.ownCapabilities.contains(PermissionType.sendReaction),
  //           showPinHighlight: false,
  //           showUserAvatar:
  //               widget.message.user!.id == channel.client.state.currentUser!.id
  //                   ? DisplayWidget.gone
  //                   : DisplayWidget.show,
  //         ),
  //         onCopyTap: (message) =>
  //             Clipboard.setData(ClipboardData(text: message.text)),
  //         messageTheme: widget.messageTheme,
  //         reverse: widget.reverse,
  //         message: widget.message,
  //         editMessageInputBuilder: widget.editMessageInputBuilder,
  //         onReplyTap: widget.onReplyTap,
  //         onThreadReplyTap: widget.onThreadTap,
  //         showResendMessage:
  //             widget.showResendMessage && (isSendFailed || isUpdateFailed),
  //         showCopyMessage: widget.showCopyMessage &&
  //             !isFailedState &&
  //             widget.message.text?.trim().isNotEmpty == true,
  //         showReplyMessage: widget.showReplyMessage &&
  //             !isFailedState &&
  //             widget.onReplyTap != null,
  //         showThreadReplyMessage: widget.showThreadReplyMessage &&
  //             !isFailedState &&
  //             widget.onThreadTap != null,
  //         showFlagButton: widget.showFlagButton,
  //         customActions: widget.customActions,
  //         showDeleteMessage: widget.showDeleteMessage || isDeleteFailed,
  //         showEditMessage: widget.showEditMessage &&
  //             !isDeleteFailed &&
  //             !widget.message.attachments
  //                 .any((element) => element.type == 'giphy'),
  //         showPinButton: widget.showPinButton,
  //         showReactions: widget.showReactions,
  //       ),
  //     ),
  //   );
  // }

  // void _showMessageReactionsModalBottomSheet(BuildContext context) {
  //   final channel = StreamChannel.of(context).channel;
  //   showDialog(
  //     useRootNavigator: false,
  //     context: context,
  //     barrierColor: _streamChatTheme.colorTheme.overlay,
  //     builder: (context) => StreamChannel(
  //       channel: channel,
  //       child: StreamMessageReactionsModal(
  //         messageWidget: widget.copyWith(
  //           key: const Key('MessageWidget'),
  //           message: widget.message.copyWith(
  //             text: (widget.message.text?.length ?? 0) > 200
  //                 ? '${widget.message.text!.substring(0, 200)}...'
  //                 : widget.message.text,
  //           ),
  //           showReactions: false,
  //           showUsername: false,
  //           showTimestamp: false,
  //           translateUserAvatar: false,
  //           showSendingIndicator: false,
  //           padding: EdgeInsets.zero,
  //           showReactionPickerIndicator: widget.showReactions &&
  //               (widget.message.status == MessageSendingStatus.sent) &&
  //               channel.ownCapabilities.contains(PermissionType.sendReaction),
  //           showPinHighlight: false,
  //           showUserAvatar:
  //               widget.message.user!.id == channel.client.state.currentUser!.id
  //                   ? DisplayWidget.gone
  //                   : DisplayWidget.show,
  //         ),
  //         onUserAvatarTap: widget.onUserAvatarTap,
  //         messageTheme: widget.messageTheme,
  //         reverse: widget.reverse,
  //         message: widget.message,
  //         showReactions: widget.showReactions &&
  //             channel.ownCapabilities.contains(PermissionType.sendReaction),
  //       ),
  //     ),
  //   );
  // }

  Widget _parseAttachments() {
    final attachmentGroups = <String, List<Attachment>>{};
    widget.message.attachments
        // .where((element) => element.type == 'giphy')
        .forEach((e) {
      if (attachmentGroups[e.type] == null) {
        attachmentGroups[e.type!] = [];
      }

      attachmentGroups[e.type]?.add(e);
    });

    final attachmentList = <Widget>[];

    attachmentGroups.forEach((type, attachments) {
      final attachmentBuilder = widget.attachmentBuilders[type];

      if (attachmentBuilder == null) return;
      final attachmentWidget = attachmentBuilder(
        context,
        widget.message,
        attachments,
      );
      attachmentList.add(attachmentWidget);
    });

    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: attachmentList.insertBetween(SizedBox(
          height: widget.attachmentPadding.vertical / 2,
        )),
      ),
    );
  }

  void onLongPress(BuildContext context) {
    if (widget.message.status == MessageStatus.sending) {
      return;
    }

    if (widget.onMessageActions != null) {
      widget.onMessageActions!(context, widget.message);
    } else {
      // _showMessageActionModalBottomSheet(context);
    }
    return;
  }

  // Widget _buildSendingIndicator() {
  //   // final style = widget.messageTheme.createdAtStyle;
  //   final message = widget.message;
  //   final memberCount = ChannelPage.of(context).channel.memberCount;

  //   // if (hasNonUrlAttachments &&
  //   //     (message.status == MessageSendingStatus.sending ||
  //   //         message.status == MessageSendingStatus.updating)) {
  //   //   final totalAttachments = message.attachments.length;
  //   //   final uploadRemaining =
  //   //       message.attachments.where((it) => !it.uploadState.isSuccess).length;
  //   //   if (uploadRemaining == 0) {
  //   //     return StreamSvgIcon.check(
  //   //       size: style!.fontSize,
  //   //       color: IconTheme.of(context).color!.withOpacity(0.5),
  //   //     );
  //   //   }
  //   //   return Text(
  //   //     context.translations.attachmentsUploadProgressText(
  //   //       remaining: uploadRemaining,
  //   //       total: totalAttachments,
  //   //     ),
  //   //     style: style,
  //   //   );
  //   // }

  //   final channel = ChannelPage.of(context).channel;

  //   if (!channel.ownCapabilities.contains(PermissionType.readEvents)) {
  //     return StreamSendingIndicator(
  //       message: message,
  //       size: style!.fontSize,
  //     );
  //   }

  //   return BetterStreamBuilder<List<Read>>(
  //     stream: channel.state?.readStream,
  //     initialData: channel.state?.read,
  //     builder: (context, data) {
  //       final readList = data.where((it) =>
  //           it.user.id != _streamChat.currentUser?.id &&
  //           (it.lastRead.isAfter(message.createdAt) ||
  //               it.lastRead.isAtSameMomentAs(message.createdAt)));
  //       final isMessageRead = readList.length >= (channel.memberCount ?? 0) - 1;
  //       Widget child = StreamSendingIndicator(
  //         message: message,
  //         isMessageRead: isMessageRead,
  //         size: style!.fontSize,
  //       );
  //       if (isMessageRead) {
  //         child = Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             if (memberCount > 2)
  //               Text(
  //                 readList.length.toString(),
  //                 style: style.copyWith(
  //                   color: _streamChatTheme.colorTheme.accentPrimary,
  //                 ),
  //               ),
  //             const SizedBox(width: 2),
  //             child,
  //           ],
  //         );
  //       }
  //       return child;
  //     },
  //   );
  // }

  Widget _buildUserAvatar() => Transform.translate(
        offset: Offset(
          0,
          widget.translateUserAvatar ? 40 / 2 : 0,
        ),
        child:
            widget.userAvatarBuilder?.call(context, widget.message.sender!) ??
                UserAvatar(
                  user: widget.message.sender!,
                  size: 32,
                  // onTap: widget.onUserAvatarTap,
                  // constraints: widget.messageTheme.avatarTheme!.constraints,
                  // borderRadius: widget.messageTheme.avatarTheme!.borderRadius,
                  // showOnlineStatus: false,
                ),
      );

  Widget _buildTextBubble() {
    if (widget.message.text?.trim().isEmpty ?? false) return const Offstage();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.textPadding,
          child: widget.textBuilder != null
              ? widget.textBuilder!(context, widget.message)
              : MessageText(
                  onLinkTap: widget.onLinkTap,
                  message: widget.message,
                  // onMentionTap: widget.onMentionTap,
                  // messageTheme: isOnlyEmoji
                  //     ? widget.messageTheme.copyWith(
                  //         messageTextStyle:
                  //             widget.messageTheme.messageTextStyle!.copyWith(
                  //           fontSize: 42,
                  //         ),
                  //       )
                  //     : widget.messageTheme,
                ),
        ),
        // if (hasUrlAttachments && !hasQuotedMessage) _buildUrlAttachment(),
      ],
    );
  }

  // Widget _buildPinnedMessage(Message message) {
  //   final pinnedBy = message.pinnedBy!;
  //   final currentUser = _streamChat.currentUser!;

  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         StreamSvgIcon.pin(size: 16),
  //         const SizedBox(width: 4),
  //         Text(
  //           context.translations.pinnedByUserText(
  //             pinnedBy: pinnedBy,
  //             currentUser: currentUser,
  //           ),
  //           style: TextStyle(
  //             color: _streamChatTheme.colorTheme.textLowEmphasis,
  //             fontSize: 13,
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // bool get isPinned => widget.message.pinned;

  Color? get _backgroundColor {
    // if (hasQuotedMessage) {
    //   return widget.messageTheme.messageBackgroundColor;
    // }

    // if (hasUrlAttachments) {
    //   return widget.messageTheme.linkBackgroundColor;
    // }

    // if (isOnlyEmoji) {
    //   return Colors.transparent;
    // }

    // if (isGiphy) {
    //   return Colors.transparent;
    // }

    if (hasNonUrlAttachments) {
      return Colors.transparent;
    }

    return widget.messageTheme.messageBackgroundColor;
  }

//   void retryMessage(BuildContext context) {
//     final channel = StreamChannel.of(context).channel;
//     if (widget.message.status == MessageSendingStatus.failed) {
//       channel.sendMessage(widget.message);
//       return;
//     }
//     if (widget.message.status == MessageSendingStatus.failed_update) {
//       channel.updateMessage(widget.message);
//       return;
//     }

//     if (widget.message.status == MessageSendingStatus.failed_delete) {
//       channel.deleteMessage(widget.message);
//       return;
//     }
//   }
// }

// class _ThreadParticipants extends StatelessWidget {
//   const _ThreadParticipants({
//     required StreamChatThemeData streamChatTheme,
//     required this.threadParticipants,
//   }) : _streamChatTheme = streamChatTheme;

//   final StreamChatThemeData _streamChatTheme;
//   final Iterable<User> threadParticipants;

//   @override
//   Widget build(BuildContext context) {
//     var padding = 0.0;
//     return Stack(
//       children: threadParticipants.map((user) {
//         padding += 8.0;
//         return Positioned(
//           right: padding - 8,
//           bottom: 0,
//           top: 0,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _streamChatTheme.colorTheme.barsBg,
//             ),
//             padding: const EdgeInsets.all(1),
//             child: StreamUserAvatar(
//               user: user,
//               constraints: BoxConstraints.tight(const Size.fromRadius(7)),
//               showOnlineStatus: false,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class _ThreadReplyPainter extends CustomPainter {
//   const _ThreadReplyPainter({
//     this.context,
//     required this.color,
//     this.reverse = false,
//   });

//   final Color? color;
//   final BuildContext? context;
//   final bool reverse;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color ?? StreamChatTheme.of(context!).colorTheme.disabled
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1
//       ..strokeCap = StrokeCap.round;

//     final path = Path()
//       ..moveTo(reverse ? size.width : 0, 0)
//       ..quadraticBezierTo(
//         reverse ? size.width : 0,
//         size.height * 0.38,
//         reverse ? size.width : 0,
//         size.height * 0.5,
//       )
//       ..quadraticBezierTo(
//         reverse ? size.width : 0,
//         size.height,
//         reverse ? 0 : size.width,
//         size.height,
//       );
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
}
