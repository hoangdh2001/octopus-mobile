import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/core/ui/typedef.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel/channel_page.dart';

bool Function(Message) defaultMessageFilter(String currentUserId) =>
    (Message m) {
      return true;
    };

class MessageListCore extends StatefulWidget {
  const MessageListCore({
    super.key,
    required this.loadingBuilder,
    required this.emptyBuilder,
    required this.messageListBuilder,
    required this.errorBuilder,
    this.parentMessage,
    this.messageListController,
    this.messageFilter,
    this.paginationLimit = 20,
  });

  final MessageListController? messageListController;

  final Widget Function(BuildContext, List<Message>) messageListBuilder;

  final WidgetBuilder loadingBuilder;

  final WidgetBuilder emptyBuilder;

  final int paginationLimit;

  final ErrorBuilder errorBuilder;

  final Message? parentMessage;

  final bool Function(Message)? messageFilter;

  @override
  MessageListCoreState createState() => MessageListCoreState();
}

class MessageListCoreState extends State<MessageListCore> {
  OctopusChannelState? _octopusChannelState;

  bool get _upToDate => _octopusChannelState!.channel.state?.isUpToDate ?? true;

  User? get _currentUser =>
      _octopusChannelState!.channel.client.state.currentUser;

  var _messages = <Message>[];

  @override
  Widget build(BuildContext context) {
    final messagesStream = _octopusChannelState!.channel.state?.messagesStream;

    final initialData = _octopusChannelState!.channel.state?.messages;

    return BetterStreamBuilder<List<Message>>(
      initialData: initialData,
      comparator: const ListEquality().equals,
      stream: messagesStream,
      errorBuilder: widget.errorBuilder,
      noDataBuilder: widget.loadingBuilder,
      builder: (context, data) {
        final messageList = data
            .where(
              widget.messageFilter ?? defaultMessageFilter(_currentUser!.id),
            )
            .toList(growable: false)
            .reversed
            .toList(growable: false);
        if (messageList.isEmpty) {
          if (_upToDate) {
            return widget.emptyBuilder(context);
          }
        } else {
          _messages = messageList;
        }
        return widget.messageListBuilder(context, _messages);
      },
    );
  }

  Future<void> paginateData({
    QueryDirection direction = QueryDirection.top,
  }) {
    return _octopusChannelState!.queryMessages(
      direction: direction,
      limit: widget.paginationLimit,
    );
  }

  @override
  void didChangeDependencies() {
    final newStreamChannel = OctopusChannel.of(context);

    if (newStreamChannel != _octopusChannelState) {
      // if (_channelPage == null /*only first time*/ && _isThreadConversation) {
      //   newStreamChannel.getReplies(
      //     widget.parentMessage!.id,
      //     limit: widget.paginationLimit,
      //   );
      // }
      _octopusChannelState = newStreamChannel;
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MessageListCore oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.messageListController != oldWidget.messageListController) {
      _setupController();
    }

    // if (widget.parentMessage?.id != widget.parentMessage?.id) {
    //   if (_isThreadConversation) {
    //     _streamChannel!.getReplies(
    //       widget.parentMessage!.id,
    //       limit: widget.paginationLimit,
    //     );
    //   }
    // }
  }

  @override
  void initState() {
    _setupController();

    super.initState();
  }

  void _setupController() {
    if (widget.messageListController != null) {
      widget.messageListController!.paginateData = paginateData;
    }
  }

  @override
  void dispose() {
    // if (!_upToDate) {
    //   _streamChannel!.reloadChannel();
    // }
    super.dispose();
  }
}

class MessageListController {
  Future<void> Function({QueryDirection direction})? paginateData;
}
