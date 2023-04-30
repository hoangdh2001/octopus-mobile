import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/core/ui/loading_indicator.dart';
import 'package:octopus/core/ui/scroll_position_list/indexed_key.dart';
import 'package:octopus/core/ui/scroll_position_list/item_positions_listener.dart';
import 'package:octopus/core/ui/scroll_position_list/lazy_load_scroll_view.dart';
import 'package:octopus/core/ui/scroll_position_list/scrollable_positioned_list.dart';
import 'package:octopus/core/ui/swipeable.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/message/message_widget.dart';
import 'package:octopus/widgets/message_list/date_divider.dart';
import 'package:octopus/widgets/message_list/message_core.dart';
import 'package:octopus/widgets/message_list/system_message.dart';

typedef MessageBuilder = Widget Function(
  BuildContext,
  MessageDetails,
  List<Message>,
  MessageWidget defaultMessageWidget,
);

enum SpacingType {
  timeDiff,
  otherUser,
  deleted,
  defaultSpacing,
}

typedef SpacingWidgetBuilder = Widget Function(
  BuildContext context,
  List<SpacingType> spacingTypes,
);

typedef SystemMessageBuilder = Widget Function(
  BuildContext,
  Message,
);

class MessageDetails {
  /// Constructor for creating [MessageDetails]
  MessageDetails(
    String currentUserId,
    this.message,
    List<Message> messages,
    this.index,
  ) {
    isMyMessage = message.sender?.id == currentUserId;
    isLastUser = index + 1 < messages.length &&
        message.sender?.id == messages[index + 1].sender?.id;
    isNextUser =
        index - 1 >= 0 && message.sender!.id == messages[index - 1].sender?.id;
  }

  /// True if the message belongs to the current user
  late final bool isMyMessage;

  /// True if the user message is the same of the previous message
  late final bool isLastUser;

  /// True if the user message is the same of the next message
  late final bool isNextUser;

  /// The message
  final Message message;

  /// The index of the message
  final int index;
}

typedef OnMessageTap = void Function(Message);

typedef OnMessageSwiped = void Function(Message);

class MessageListView extends StatefulWidget {
  const MessageListView(
      {super.key,
      this.emptyBuilder,
      this.messageListBuilder,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
      this.scrollPhysics = const ClampingScrollPhysics(),
      this.reverse = true,
      this.headerBuilder,
      this.footerBuilder,
      this.dateDividerBuilder,
      this.spacingWidgetBuilder = _defaultSpacingWidgetBuilder,
      this.unreadMessagesSeparatorBuilder,
      this.paginationLoadingIndicatorBuilder,
      this.systemMessageBuilder,
      this.onSystemMessageTap,
      this.messageBuilder,
      this.onMessageTap,
      this.onMessageSwiped,
      this.messageListController,
      this.scrollController,
      this.itemPositionListener,
      this.messageFilter});

  final WidgetBuilder? emptyBuilder;

  final MessageBuilder? messageBuilder;

  final Widget Function(BuildContext, List<Message>)? messageListBuilder;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final ScrollPhysics? scrollPhysics;

  final bool reverse;

  final WidgetBuilder? headerBuilder;

  final WidgetBuilder? footerBuilder;

  final Widget Function(DateTime)? dateDividerBuilder;

  final SpacingWidgetBuilder spacingWidgetBuilder;

  final SystemMessageBuilder? systemMessageBuilder;

  final Widget Function(BuildContext context, int unreadCount)?
      unreadMessagesSeparatorBuilder;

  final WidgetBuilder? paginationLoadingIndicatorBuilder;

  final OnMessageTap? onSystemMessageTap;

  final OnMessageTap? onMessageTap;

  final OnMessageSwiped? onMessageSwiped;

  final MessageListController? messageListController;

  final ItemScrollController? scrollController;

  final ItemPositionsListener? itemPositionListener;

  final bool Function(Message)? messageFilter;

  static Widget _defaultSpacingWidgetBuilder(
    BuildContext context,
    List<SpacingType> spacingTypes,
  ) {
    if (!spacingTypes.contains(SpacingType.defaultSpacing)) {
      return const SizedBox(height: 8);
    }
    return const SizedBox(height: 2);
  }

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  ItemScrollController? _scrollController;

  OctopusChannelState? octopusChannelState;

  final ValueNotifier<bool> _showScrollToBottom = ValueNotifier(false);

  List<Message> messages = <Message>[];

  Map<String, int> messagesIndex = {};

  int? _messageListLength;

  bool _bottomPaginationActive = false;

  bool _inBetweenList = false;

  double get _initialAlignment {
    // final initialAlignment = widget.initialAlignment;
    // if (initialAlignment != null) return initialAlignment;
    return initialIndex == 0 ? 0 : 0.1;
  }

  int initialIndex = 0;

  double initialAlignment = 0;

  // late int unreadCount;

  late final ItemPositionsListener _itemPositionListener;

  bool get _upToDate => octopusChannelState!.channel.state!.isUpToDate;

  late final _defaultController = MessageListController();

  MessageListController get _messageListController =>
      widget.messageListController ?? _defaultController;

  late OctopusThemeData _streamTheme;

  StreamSubscription? _messageNewListener;

  @override
  void initState() {
    super.initState();

    _scrollController = widget.scrollController ?? ItemScrollController();
    _itemPositionListener =
        widget.itemPositionListener ?? ItemPositionsListener.create();
    _itemPositionListener.itemPositions
        .addListener(_handleItemPositionsChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newStreamChannel = OctopusChannel.of(context);
    _streamTheme = OctopusTheme.of(context);

    if (newStreamChannel != octopusChannelState) {
      octopusChannelState = newStreamChannel;
      _messageNewListener?.cancel();

      //   _userRead = streamChannel?.channel.state!.read.firstWhereOrNull(
      //     (it) =>
      //         it.user.id == streamChannel?.channel.client.state.currentUser?.id,
      //   );
      //   _messageNewListener?.cancel();
      //   unreadCount = streamChannel?.channel.state?.unreadCount ?? 0;
      //   initialIndex = getInitialIndex(
      //     widget.initialScrollIndex,
      //     streamChannel!,
      //     widget.messageFilter,
      //     _userRead,
      //   );

      initialAlignment = _initialAlignment;

      if (_scrollController?.isAttached == true) {
        _scrollController?.jumpTo(
          index: initialIndex,
          alignment: initialAlignment,
        );
      }

      _messageNewListener =
          octopusChannelState!.channel.on(EventType.messageNew).listen((event) {
        if (_upToDate) {
          _bottomPaginationActive = false;
        }
        if (
            // event.message?.parentId == widget.parentMessage?.id &&
            event.message!.sender!.id ==
                octopusChannelState!.channel.client.state.currentUser!.id) {
          // setState(() => unreadCount = 0);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController?.jumpTo(
              index: 0,
            );
          });
        }
      });

      //   if (_isThreadConversation) {
      //     streamChannel!.getReplies(widget.parentMessage!.id);
      //   }

      //   unreadCount = streamChannel?.channel.state?.unreadCount ?? 0;
    }
  }

  @override
  void dispose() {
    if (!_upToDate) {
      octopusChannelState!.reloadChannel();
    }
    _messageNewListener?.cancel();
    _itemPositionListener.itemPositions
        .removeListener(_handleItemPositionsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MessageListCore(
        loadingBuilder: (context) => const Center(
          child: LoadingIndicator(),
        ),
        messageFilter: widget.messageFilter,
        emptyBuilder: widget.emptyBuilder ??
            (context) => const Center(
                  child: Text(
                    'Empty',
                  ),
                ),
        messageListController: _messageListController,
        messageListBuilder: widget.messageListBuilder ??
            (context, list) => _buildListView(list),
        errorBuilder: (BuildContext context, Object error) => Center(
          child: Text(
            'Error',
          ),
        ),
      );

  Widget _buildListView(List<Message> data) {
    messages = data;

    for (var index = 0; index < messages.length; index++) {
      messagesIndex[messages[index].id] = index;
    }
    final newMessagesListLength = messages.length;

    if (_messageListLength != null) {
      if (_bottomPaginationActive || (_inBetweenList)) {
        if (_itemPositionListener.itemPositions.value.isNotEmpty) {
          final first = _itemPositionListener.itemPositions.value.first;
          final diff = newMessagesListLength - _messageListLength!;
          if (diff > 0) {
            if (messages[0].sender?.id !=
                octopusChannelState!.channel.client.state.currentUser?.id) {
              initialIndex = first.index + diff;
              initialAlignment = first.itemLeadingEdge;
            }
          }
        }
      }
    }

    _messageListLength = newMessagesListLength;

    final itemCount = messages.length + // total messages
            2 + // top + bottom loading indicator
            2
        // + // header + footer
        // 1 // parent message
        ;

    final child = Stack(
      alignment: Alignment.center,
      children: [
        LazyLoadScrollView(
          onStartOfPage: () async {
            _inBetweenList = false;
            if (!_upToDate) {
              _bottomPaginationActive = true;
              return _paginateData(
                QueryDirection.bottom,
              );
            }
          },
          onEndOfPage: () async {
            _inBetweenList = false;
            _bottomPaginationActive = false;
            return _paginateData(
              QueryDirection.top,
            );
          },
          onInBetweenOfPage: () {
            _inBetweenList = true;
          },
          child: ScrollablePositionedList.separated(
            key: (initialIndex != 0 && initialAlignment != 0)
                ? ValueKey('$initialIndex-$initialAlignment')
                : null,
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            itemPositionsListener: _itemPositionListener,
            initialScrollIndex: initialIndex,
            initialAlignment: initialAlignment,
            physics: widget.scrollPhysics,
            itemScrollController: _scrollController,
            reverse: widget.reverse,
            itemCount: itemCount,
            findChildIndexCallback: (Key key) {
              final indexedKey = key as IndexedKey;
              final valueKey = indexedKey.key as ValueKey<String>?;
              if (valueKey != null) {
                final index = messagesIndex[valueKey.value];
                if (index != null) {
                  return ((index + 2) * 2) - 1;
                }
              }
              return null;
            },

            // Item Count -> 8 (1 parent, 2 header+footer, 2 top+bottom, 3 messages)
            // eg:     |Type|         rev(|Index(item)|)     rev(|Index(separator)|)    |Index(item)|    |Index(separator)|
            //     ParentMessage  ->        7                                             (count-1)
            //        Separator(ThreadSeparator)          ->           6                                      (count-2)
            //     Header         ->        6                                             (count-2)
            //        Separator(Header -> 8??T -> 0||52)  ->           5                                      (count-3)
            //     TopLoader      ->        5                                             (count-3)
            //        Separator(0)                        ->           4                                      (count-4)
            //     Message        ->        4                                             (count-4)
            //        Separator(2||8)                     ->           3                                      (count-5)
            //     Message        ->        3                                             (count-5)
            //        Separator(2||8)                     ->           2                                      (count-6)
            //     Message        ->        2                                             (count-6)
            //        Separator(0)                        ->           1                                      (count-7)
            //     BottomLoader   ->        1                                             (count-7)
            //        Separator(Footer -> 8??30)          ->           0                                      (count-8)
            //     Footer         ->        0                                             (count-8)

            separatorBuilder: (context, i) {
              if (i == itemCount - 2) {
                return const Offstage();
              }
              if (i == itemCount - 3) {
                if (widget.reverse
                    ? widget.headerBuilder == null
                    : widget.footerBuilder == null) {
                  if (messages.isNotEmpty) {
                    return _buildDateDivider(messages.last);
                  }
                  return const SizedBox(height: 52);
                }
                return const SizedBox(height: 8);
              }
              if (i == 0) {
                if (widget.reverse
                    ? widget.footerBuilder == null
                    : widget.headerBuilder == null) {
                  return const SizedBox(height: 30);
                }
                return const SizedBox(height: 8);
              }

              if (i == 1 || i == itemCount - 4) {
                return const Offstage();
              }

              late final Message message, nextMessage;
              if (widget.reverse) {
                message = messages[i - 1];
                nextMessage = messages[i - 2];
              } else {
                message = messages[i - 2];
                nextMessage = messages[i - 1];
              }

              Widget separator;

              // final isThread = message.replyCount! > 0;

              if (!Jiffy(message.createdAt.toLocal()).isSame(
                nextMessage.createdAt.toLocal(),
                Units.DAY,
              )) {
                separator = _buildDateDivider(nextMessage);
              } else {
                final timeDiff = Jiffy(nextMessage.createdAt.toLocal()).diff(
                  message.createdAt.toLocal(),
                  Units.MINUTE,
                );

                final isNextUserSame =
                    message.sender!.id == nextMessage.sender?.id;
                final isDeleted = message.status == MessageStatus.deleted;
                final hasTimeDiff = timeDiff >= 1;

                final spacingRules = [
                  if (hasTimeDiff) SpacingType.timeDiff,
                  if (!isNextUserSame) SpacingType.otherUser,
                  if (isDeleted) SpacingType.deleted,
                ];

                if (spacingRules.isEmpty) {
                  spacingRules.add(SpacingType.defaultSpacing);
                }

                separator = widget.spacingWidgetBuilder.call(
                  context,
                  spacingRules,
                );
              }

              // if (unreadCount > 0 && unreadCount == i - 1) {
              //   final unreadMessagesSeparator =
              //       _buildUnreadMessagesSeparator(unreadCount);

              //   return Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       separator,
              //       unreadMessagesSeparator,
              //     ],
              //   );
              // }

              return separator;
            },
            itemBuilder: (context, i) {
              // if (i == itemCount - 1) {
              //   if (widget.parentMessage == null) {
              //     return const Offstage();
              //   }
              //   return buildParentMessage(widget.parentMessage!);
              // }

              if (i == itemCount - 1) {
                if (widget.reverse) {
                  return widget.headerBuilder?.call(context) ??
                      const Offstage();
                } else {
                  return widget.footerBuilder?.call(context) ??
                      const Offstage();
                }
              }

              final indicatorBuilder = widget.paginationLoadingIndicatorBuilder;

              if (i == itemCount - 2) {
                return _loadingIndicator(
                  octopusChannelState!,
                  QueryDirection.top,
                  indicatorBuilder: indicatorBuilder,
                );
              }

              if (i == 1) {
                return _loadingIndicator(
                  octopusChannelState!,
                  QueryDirection.bottom,
                  indicatorBuilder: indicatorBuilder,
                );
              }

              if (i == 0) {
                if (widget.reverse) {
                  return widget.footerBuilder?.call(context) ??
                      const Offstage();
                } else {
                  return widget.headerBuilder?.call(context) ??
                      const Offstage();
                }
              }

              const bottomMessageIndex = 2; // 1 -> loader // 0 -> footer

              final message = messages[i - 2];
              Widget messageWidget;

              if (i == bottomMessageIndex) {
                messageWidget = _buildBottomMessage(
                  context,
                  message,
                  messages,
                  i - 2,
                );
              } else {
                messageWidget = buildMessage(message, messages, i - 2);
              }
              return KeyedSubtree(
                key: ValueKey(message.id),
                child: messageWidget,
              );
            },
          ),
        ),
        // if (widget.showScrollToBottom)
        // BetterStreamBuilder<bool>(
        //   stream: channelPageState!.channel.state!.isUpToDateStream,
        //   initialData: channelPageState!.channel.state!.isUpToDate,
        //   builder: (context, snapshot) => ValueListenableBuilder<bool>(
        //     valueListenable: _showScrollToBottom,
        //     child: _buildScrollToBottom(),
        //     builder: (context, value, child) {
        //       if (!snapshot || value) {
        //         return child!;
        //       }
        //       return const Offstage();
        //     },
        //   ),
        // ),
        // if (widget.showFloatingDateDivider)
        //   _buildFloatingDateDivider(itemCount),
      ],
    );

    final backgroundColor = OctopusTheme.of(context).colorTheme.contentView;
    // final backgroundImage =
    //     StreamMessageListViewTheme.of(context).backgroundImage;

    // if (backgroundColor != null) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        // image: backgroundImage,
      ),
      child: child,
    );
    // }

    // return child;
  }

  Future<void> _paginateData(
    QueryDirection direction,
  ) =>
      _messageListController.paginateData!(direction: direction);

  Widget _buildDateDivider(Message message) {
    final divider = widget.dateDividerBuilder != null
        ? widget.dateDividerBuilder!(
            message.createdAt.toLocal(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DateDivider(
              dateTime: message.createdAt.toLocal(),
            ),
          );
    return divider;
  }

  Widget _buildUnreadMessagesSeparator(int unreadCount) {
    final unreadMessagesSeparator =
        widget.unreadMessagesSeparatorBuilder?.call(context, unreadCount) ??
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    // gradient: _streamTheme.colorTheme.bgGradient,
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Last read $unreadCount',
                    textAlign: TextAlign.center,
                    // style: StreamChannelHeaderTheme.of(context).subtitleStyle,
                  ),
                ),
              ),
            );
    return unreadMessagesSeparator;
  }

  Widget _buildBottomMessage(
    BuildContext context,
    Message message,
    List<Message> messages,
    int index,
  ) {
    final messageWidget = buildMessage(message, messages, index);
    return messageWidget;
  }

  Widget buildMessage(Message message, List<Message> messages, int index) {
    if ((message.type == MessageType.systemNotification) &&
        message.text?.isNotEmpty == true) {
      return widget.systemMessageBuilder?.call(context, message) ??
          SystemMessage(
            message: message,
            onMessageTap: (message) {
              widget.onSystemMessageTap?.call(message);
              FocusScope.of(context).unfocus();
            },
          );
    }

    final userId =
        OctopusChannel.of(context).channel.client.state.currentUser!.id;
    final isMyMessage = message.sender?.id == userId;
    final nextMessage = index - 1 >= 0 ? messages[index - 1] : null;
    final isNextUserSame =
        nextMessage != null && message.sender!.id == nextMessage.sender!.id;

    num timeDiff = 0;
    if (nextMessage != null) {
      timeDiff = Jiffy(nextMessage.createdAt.toLocal()).diff(
        message.createdAt.toLocal(),
        Units.MINUTE,
      );
    }

    final hasFileAttachment =
        message.attachments.any((it) => it.type == 'file');

    // final isThreadMessage =
    //     message.parentId != null && message.showInChannel == true;

    // final hasReplies = message.replyCount! > 0;

    final attachmentBorderRadius = hasFileAttachment ? 12.0 : 14.0;

    final showTimeStamp = timeDiff >= 1 || !isNextUserSame;

    final showUsername = !isMyMessage &&
        // (!isThreadMessage || _isThreadConversation) &&
        // !hasReplies &&
        (timeDiff >= 1 || !isNextUserSame);

    final showUserAvatar = isMyMessage
        ? DisplayWidget.gone
        : (timeDiff >= 1 || !isNextUserSame)
            ? DisplayWidget.show
            : DisplayWidget.hide;

    final showSendingIndicator =
        isMyMessage && (index == 0 || timeDiff >= 1 || !isNextUserSame);

    // final showInChannelIndicator = !_isThreadConversation && isThreadMessage;
    // final showThreadReplyIndicator = !_isThreadConversation && hasReplies;
    // final isOnlyEmoji = message.text?.isOnlyEmoji ?? false;

    // final hasUrlAttachment =
    //     message.attachments.any((it) => it.ogScrapeUrl != null);

    final borderSide = isMyMessage ? BorderSide.none : null;

    final currentUser =
        OctopusChannel.of(context).channel.client.state.currentUser;
    final members = OctopusChannel.of(context).channel.state?.members ?? [];
    final currentUserMember =
        members.firstWhereOrNull((e) => e.user!.id == currentUser!.id);

    Widget messageWidget = MessageWidget(
      message: message,
      reverse: isMyMessage,
      showReactions: !(message.status == MessageStatus.deleted),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      // showThreadReplyIndicator: showThreadReplyIndicator,
      showUsername: showUsername,
      showTimestamp: showTimeStamp,
      showSendingIndicator: showSendingIndicator,
      showUserAvatar: showUserAvatar,
      onQuotedMessageTap: (quotedMessageId) async {
        if (messages.map((e) => e.id).contains(quotedMessageId)) {
          final index = messages.indexWhere((m) => m.id == quotedMessageId);
          _scrollController?.scrollTo(
            index: index + 2, // +2 to account for loader and footer
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            alignment: 0.1,
          );
        } else {
          // await streamChannel!
          //     .loadChannelAtMessage(quotedMessageId)
          //     .then((_) async {
          //   initialIndex = 21; // 19 + 2 | 19 is the index of the message
          //   initialAlignment = 0.1;
          // });
        }
      },
      showEditMessage: isMyMessage,
      showDeleteMessage: isMyMessage,
      // showThreadReplyMessage: !isThreadMessage &&
      //     streamChannel?.channel.ownCapabilities
      //             .contains(PermissionType.sendReply) ==
      //         true,
      showFlagButton: !isMyMessage,
      borderSide: borderSide,
      // onThreadTap: _onThreadTap,
      attachmentBorderRadiusGeometry: BorderRadius.only(
          topLeft: Radius.circular(attachmentBorderRadius),
          bottomLeft: isMyMessage
              ? Radius.circular(attachmentBorderRadius)
              : Radius.circular(
                  (timeDiff >= 1 || !isNextUserSame) &&
                          !(
                            // hasReplies ||
                           hasFileAttachment)
                      ? 0
                      : attachmentBorderRadius,
                ),
          topRight: Radius.circular(attachmentBorderRadius),
          bottomRight: isMyMessage
              ? Radius.circular(
                  (timeDiff >= 1 || !isNextUserSame) &&
                          !(
                            // hasReplies || 
                          hasFileAttachment)
                      ? 0
                      : attachmentBorderRadius,
                )
              : Radius.circular(attachmentBorderRadius),
          ),
      attachmentPadding: EdgeInsets.all(hasFileAttachment ? 4 : 2),
      borderRadiusGeometry: BorderRadius.only(
        topLeft: const Radius.circular(16),
        bottomLeft: isMyMessage
            ? const Radius.circular(16)
            : Radius.circular(
                (timeDiff >= 1 || !isNextUserSame) ? 0 : 16,
              ),
        topRight: const Radius.circular(16),
        bottomRight: isMyMessage
            ? Radius.circular(
                (timeDiff >= 1 || !isNextUserSame) ? 0 : 16,
              )
            : const Radius.circular(16),
      ),
      textPadding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal:
            // isOnlyEmoji ? 0 :
            16.0,
      ),
      messageTheme: isMyMessage
          ? _streamTheme.ownMessageTheme
          : _streamTheme.otherMessageTheme,
      // onReturnAction: (action) {
      //   switch (action) {
      //     case ReturnActionType.none:
      //       break;
      //     case ReturnActionType.reply:
      //       FocusScope.of(context).unfocus();
      //       widget.onMessageSwiped?.call(message);
      //       break;
      //   }
      // },
      onMessageTap: (message) {
        widget.onMessageTap?.call(message);
        FocusScope.of(context).unfocus();
      },
      
      // showPinButton: currentUserMember != null &&
      //     _userPermissions.contains(PermissionType.pinMessage),
    );

    if (widget.messageBuilder != null) {
      messageWidget = widget.messageBuilder!(
        context,
        MessageDetails(
          userId,
          message,
          messages,
          index,
        ),
        messages,
        messageWidget as MessageWidget,
      );
    }

    var child = messageWidget;
    if (!(message.status == MessageStatus.deleted) &&
        !(message.type == MessageType.systemNotification) &&
        // !message.isEphemeral &&
        widget.onMessageSwiped != null) {
      child = Container(
        decoration: const BoxDecoration(),
        clipBehavior: Clip.hardEdge,
        child: Swipeable(
          onSwipeEnd: () {
            FocusScope.of(context).unfocus();
            widget.onMessageSwiped?.call(message);
          },
          backgroundIcon: SvgPicture.asset(
            'assets/icons/reply.svg',
            // color: _streamTheme.colorTheme.accentPrimary,
          ),
          child: child,
        ),
      );
    }

    // if (!initialMessageHighlightComplete &&
    //     widget.highlightInitialMessage &&
    //     _isInitialMessage(message.id)) {
    //   final colorTheme = _streamTheme.colorTheme;
    //   final highlightColor =
    //       widget.messageHighlightColor ?? colorTheme.highlight;
    //   child = TweenAnimationBuilder<Color?>(
    //     tween: ColorTween(
    //       begin: highlightColor,
    //       end: colorTheme.barsBg.withOpacity(0),
    //     ),
    //     duration: const Duration(seconds: 3),
    //     onEnd: () => initialMessageHighlightComplete = true,
    //     builder: (_, color, child) => ColoredBox(
    //       color: color!,
    //       child: child,
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 4),
    //       child: child,
    //     ),
    //   );
    // }
    return child;
  }

  // Widget _buildScrollToBottom() => StreamBuilder<int>(
  //       stream: channelPageState!.channel.state!.unreadCountStream,
  //       builder: (_, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Offstage();
  //         } else if (!snapshot.hasData) {
  //           return const Offstage();
  //         }
  //         final unreadCount = snapshot.data!;
  //         if (widget.scrollToBottomBuilder != null) {
  //           return widget.scrollToBottomBuilder!(
  //             unreadCount,
  //             scrollToBottomDefaultTapAction,
  //           );
  //         }
  //         final showUnreadCount = unreadCount > 0 &&
  //             streamChannel!.channel.state!.members.any((e) =>
  //                 e.userId ==
  //                 streamChannel!.channel.client.state.currentUser!.id);
  //         return Positioned(
  //           bottom: 8,
  //           right: 8,
  //           width: 40,
  //           height: 40,
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               FloatingActionButton(
  //                 backgroundColor: _streamTheme.colorTheme.barsBg,
  //                 onPressed: () => scrollToBottomDefaultTapAction(unreadCount),
  //                 child: widget.reverse
  //                     ? StreamSvgIcon.down(
  //                         color: _streamTheme.colorTheme.textHighEmphasis,
  //                       )
  //                     : StreamSvgIcon.up(
  //                         color: _streamTheme.colorTheme.textHighEmphasis,
  //                       ),
  //               ),
  //               if (showUnreadCount)
  //                 Positioned(
  //                   width: 20,
  //                   height: 20,
  //                   left: 10,
  //                   top: -10,
  //                   child: CircleAvatar(
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(3),
  //                       child: Text(
  //                         '$unreadCount',
  //                         style: const TextStyle(
  //                           fontSize: 11,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         );
  //       },
  //     );

  Widget _loadingIndicator(
    OctopusChannelState octopusChannel,
    QueryDirection direction, {
    WidgetBuilder? indicatorBuilder,
  }) =>
      _LoadingIndicator(
        direction: direction,
        streamChannel: octopusChannel,
        indicatorBuilder: indicatorBuilder,
      );

  void _handleItemPositionsChanged() {
    final _itemPositions = _itemPositionListener.itemPositions.value.toList();
    final _firstItemIndex =
        _itemPositions.indexWhere((element) => element.index == 1);
    var _isFirstItemVisible = false;
    if (_firstItemIndex != -1) {
      final _firstItem = _itemPositions[_firstItemIndex];
      _isFirstItemVisible =
          _firstItem.itemLeadingEdge > 0 && _firstItem.itemTrailingEdge < 1;
    }
    if (_isFirstItemVisible) {
      // most recent message is visible
      final channel = octopusChannelState?.channel;
      // if (channel != null) {
      //   if (_upToDate &&
      //       channel.config?.readEvents == true &&
      //       channel.state!.unreadCount > 0) {
      //     streamChannel!.channel.markRead();
      //   }
      // }
    }
    if (mounted) {
      if (_showScrollToBottom.value == _isFirstItemVisible) {
        _showScrollToBottom.value = !_isFirstItemVisible;
      }
    }
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    required this.direction,
    required this.streamChannel,
    this.indicatorBuilder,
  });

  final QueryDirection direction;
  final OctopusChannelState streamChannel;
  final WidgetBuilder? indicatorBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = direction == QueryDirection.top
        ? streamChannel.queryTopMessages
        : streamChannel.queryBottomMessages;
    return BetterStreamBuilder<bool>(
      key: Key('LOADING-INDICATOR $direction'),
      stream: stream,
      initialData: false,
      errorBuilder: (context, error) => ColoredBox(
        // color: streamTheme.colorTheme.accentError.withOpacity(0.2),
        color: OctopusTheme.of(context).colorTheme.brandPrimary,
        child: Center(
          child: Text('loading error'),
        ),
      ),
      builder: (context, data) {
        if (!data) return const Offstage();
        return indicatorBuilder?.call(context) ??
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            );
      },
    );
  }
}
