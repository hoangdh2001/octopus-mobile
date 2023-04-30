import 'package:dartz/dartz.dart' hide State;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/extensions/extension_stream_controller.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/channel/bloc/cubit/message_list_cubit.dart';
import 'package:rxdart/rxdart.dart';

enum QueryDirection {
  top,

  bottom,
}

class OctopusChannel extends StatefulWidget {
  const OctopusChannel({super.key, required this.child, required this.channel});

  final Widget child;

  /// [channel] specifies the channel with which child should be wrapped
  final Channel channel;

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

    final rs = await getIt<MessageListCubit>().queryChannel(channel.id!,
        messagesPagination:
            PaginationParams(limit: limit, lessThan: oldestMessage));

    rs.fold((channelState) {
      channel.updateChannelState(channelState);
      if (channelState.messages.isEmpty ||
          channelState.messages.length < limit) {
        _topPaginationEnded = true;
      }
      _queryTopMessagesController.safeAdd(false);
    }, (error) {
      _queryTopMessagesController.safeAddError(error);
    });
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

    final rs = await getIt<MessageListCubit>().queryChannel(channel.id!,
        messagesPagination: PaginationParams(
            limit: limit, greaterThanOrEqual: recentMessage.id));

    rs.fold((channelState) {
      channel.updateChannelState(channelState);
      if (channelState.messages.isEmpty ||
          channelState.messages.length < limit) {
        _bottomPaginationEnded = true;
      }
      _queryBottomMessagesController.safeAdd(false);
    }, (error) {
      _queryBottomMessagesController.safeAddError(
        error,
      );
    });
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
      final rs = await getIt<MessageListCubit>().queryChannel(channel.id!,
          messagesPagination: PaginationParams(
            limit: limit,
          ));
      rs.fold((channelState) {
        channel.updateChannelState(channelState);
      }, (error) {});
      channel.state!.isUpToDate = true;
      return null;
    }

    final rs = await queryAroundMessage(messageId);
    return rs.fold((channelState) {
      channel.updateChannelState(channelState);
      return channelState;
    }, (error) => null);
  }

  Future<Either<ChannelState, Error>> queryAroundMessage(
    String messageId, {
    int limit = 20,
  }) =>
      getIt<MessageListCubit>().queryChannel(
        channel.id!,
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
        // ignore: avoid_bool_literals_in_conditional_expressions
        // final dataLoaded = initialMessageId == null ? true : snapshot.data![1];
        // if (widget.showLoading && (!initialized || !dataLoaded)) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
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
}
