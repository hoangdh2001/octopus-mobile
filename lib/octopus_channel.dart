import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/extensions/extension_stream_controller.dart';
import 'package:rxdart/rxdart.dart';

enum QueryDirection {
  top,

  bottom,
}

class OctopusChannel extends StatefulWidget {
  const OctopusChannel({
    super.key,
    required this.child,
    required this.channel,
    this.initialMessageId,
  });

  final Widget child;

  /// [channel] specifies the channel with which child should be wrapped
  final Channel channel;

  final String? initialMessageId;

  static OctopusChannelState of(BuildContext context) {
    OctopusChannelState? octopusChannelState;

    octopusChannelState =
        context.findAncestorStateOfType<OctopusChannelState>();

    assert(
      octopusChannelState != null,
      'You must have a OctopusChannel widget at the top of your widget tree',
    );

    return octopusChannelState!;
  }

  @override
  State<OctopusChannel> createState() => OctopusChannelState();
}

class OctopusChannelState extends State<OctopusChannel> {
  Channel get channel => widget.channel;

  ChannelState? get channelState => widget.channel.state?.channelState;

  Stream<ChannelState>? get channelStateStream =>
      widget.channel.state?.channelStateStream;

  final _queryTopMessagesController = BehaviorSubject.seeded(false);
  final _queryBottomMessagesController = BehaviorSubject.seeded(false);

  Stream<bool> get queryTopMessages => _queryTopMessagesController.stream;

  Stream<bool> get queryBottomMessages => _queryBottomMessagesController.stream;

  bool _topPaginationEnded = false;
  bool _bottomPaginationEnded = false;

  late List<Future<bool>> _futures;

  String? get initialMessageId => widget.initialMessageId;

  @override
  void initState() {
    super.initState();
    _populateFutures();
  }

  void _populateFutures() {
    _futures = [widget.channel.initialized];
    // if (initialMessageId != null) {
    //   _futures.add(_loadChannelAtMessage);
    // }
  }

  @override
  void didUpdateWidget(covariant OctopusChannel oldWidget) {
    // if (oldWidget.initialMessageId != initialMessageId) {
    //   _populateFutures();
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _queryTopMessagesController.close();
    _queryBottomMessagesController.close();
    super.dispose();
  }

  Future<void> _queryTopMessages({int limit = 20}) async {
    if (_topPaginationEnded ||
        _queryTopMessagesController.value ||
        channel.state == null) {
      return;
    }

    _queryTopMessagesController.safeAdd(true);

    if (channel.state!.messages.isEmpty) {
      return _queryTopMessagesController.safeAdd(false);
    }

    final oldestMessage = channel.state!.messages.first.id;

    try {
      final state = await channel.query(
          messagesPagination:
              PaginationParams(limit: limit, lessThan: oldestMessage));
      if (state.messages == null ||
          state.messages!.isEmpty ||
          state.messages!.length < limit) {
        _topPaginationEnded = true;
      }
      _queryTopMessagesController.safeAdd(false);
    } catch (e, stk) {
      _queryTopMessagesController.safeAddError(e, stk);
    }
  }

  Future<void> _queryBottomMessages({int limit = 20}) async {
    if (_bottomPaginationEnded ||
        _queryBottomMessagesController.value ||
        channel.state == null ||
        channel.state!.isUpToDate) return;
    _queryBottomMessagesController.safeAdd(true);

    if (channel.state!.messages.isEmpty) {
      return _queryBottomMessagesController.safeAdd(false);
    }

    final recentMessage = channel.state!.messages.last;

    try {
      final state = await channel.query(
          messagesPagination: PaginationParams(
              limit: limit, greaterThanOrEqual: recentMessage.id));
      if (state.messages == null ||
          state.messages!.isEmpty ||
          state.messages!.length < limit) {
        _bottomPaginationEnded = true;
      }
      _queryBottomMessagesController.safeAdd(false);
    } catch (e, stk) {
      _queryBottomMessagesController.safeAddError(e, stk);
    }
  }

  Future<void> queryMessages({
    QueryDirection? direction = QueryDirection.top,
    int limit = 20,
  }) {
    if (direction == QueryDirection.top) {
      return _queryTopMessages(limit: limit);
    }
    return _queryBottomMessages(limit: limit);
  }

  Future<void> reloadChannel() => _queryAtMessage(limit: 30);

  Future<ChannelState?> _queryAtMessage({
    String? messageId,
    int limit = 20,
  }) async {
    if (channel.state == null) return null;
    channel.state!.isUpToDate = false;
    channel.state!.truncate();

    if (messageId == null) {
      await channel.query(
          messagesPagination: PaginationParams(
        limit: limit,
      ));
      channel.state!.isUpToDate = true;
      return null;
    }

    return queryAroundMessage(messageId);
  }

  Future<ChannelState> queryAroundMessage(
    String messageId, {
    int limit = 20,
  }) =>
      channel.query(
        messagesPagination: PaginationParams(
          idAround: messageId,
          limit: limit,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget child = FutureBuilder<List<bool>>(
      future: Future.wait(_futures),
      initialData: [
        channel.state != null,
        // if (initialMessageId != null) false,
      ],
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          String? message = snapshot.error.toString();
          if (snapshot.error is DioError) {
            final dioError = snapshot.error as DioError?;
            if (dioError?.type == DioErrorType.values) {
              message = dioError!.response?.statusMessage;
            } else {
              message = 'Check your connection and retry';
            }
          }
          return Center(child: Text(message ?? ''));
        }
        final initialized = snapshot.data![0];
        // final dataLoaded = initialMessageId == null ? true : snapshot.data![1];
        // if ((!initialized || !dataLoaded)) {
        //   return Center(
        //     child: _getIndicatorWidget(Theme.of(context).platform),
        //   );
        // }
        return widget.child;
      },
    );
    // if (initialMessageId != null) {
    //   child = Material(child: child);
    // }
    return child;
  }

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
  }
}
