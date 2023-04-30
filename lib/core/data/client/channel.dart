import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/repositories/channel_repository.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class Channel {
  Channel(
    this._client,
    this._channelRepository,
    this._id, {
    String? name,
    String? image,
  }) {
    _client.logger.info('New Channel instance created, not yet initialized');
  }

  Channel.fromState(this._client, ChannelState channelState,
      ChannelRepository channelRepository)
      : assert(
          channelState.channel != null,
          'No channel found inside channel state',
        ),
        _id = channelState.channel!.id,
        _channelRepository = channelRepository {
    state = ChannelClientState(this, channelState);
    _initializedCompleter.complete(true);
    _client.logger.info('New Channel instance initialized');
  }

  final ChannelRepository _channelRepository;

  ChannelClientState? state;

  String? _id;

  // User? get createdBy {
  //   _checkInitialized();
  //   return state!._channelState.channel?.createdBy;
  // }

  // Stream<User?> get createdByStream {
  //   _checkInitialized();
  //   return state!.channelStateStream.map((cs) => cs.channel?.createdBy);
  // }

  bool get hidden {
    _checkInitialized();
    return state!._channelState.channel?.hidden == true;
  }

  Stream<bool> get hiddenStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.hidden == true);
  }

  DateTime? get createdAt {
    _checkInitialized();
    return state!._channelState.channel?.createdAt;
  }

  Stream<DateTime?> get createdAtStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.createdAt);
  }

  DateTime? get lastMessageAt {
    _checkInitialized();
    return state!._channelState.channel?.lastMessageAt;
  }

  Stream<DateTime?> get lastMessageAtStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.lastMessageAt);
  }

  DateTime? get updatedAt {
    _checkInitialized();
    return state!._channelState.channel?.updatedAt;
  }

  Stream<DateTime?> get updatedAtStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.updatedAt);
  }

  DateTime? get deletedAt {
    _checkInitialized();
    return state!._channelState.channel?.deletedAt;
  }

  Stream<DateTime?> get deletedAtStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.deletedAt);
  }

  String? get name {
    _checkInitialized();
    return state!._channelState.channel?.name;
  }

  Stream<String?> get nameStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.name);
  }

  String? get image {
    _checkInitialized();
    return state!._channelState.channel?.avatar;
  }

  Stream<String?> get imageStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.channel?.avatar);
  }

  List<Member> get members {
    _checkInitialized();
    return state!.channelState.members;
  }

  Stream<List<Member>> get membersStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.members);
  }

  int get memberCount {
    _checkInitialized();
    return state!.channelState.members.length;
  }

  Stream<int> get memberCountStream {
    _checkInitialized();
    return state!.channelStateStream.map((cs) => cs.members.length);
  }

  void updateChannelState(ChannelState channelState) {
    state!.updateChannelState(channelState);
  }

  Stream<Event> on([
    String? eventType,
    String? eventType2,
    String? eventType3,
    String? eventType4,
  ]) =>
      _client
          .on(
            eventType,
            eventType2,
            eventType3,
            eventType4,
          )
          .where((e) =>
              e.channel?.channel!.id == id ||
              e.message?.channelID == id ||
              e.channelID == id);

  // late final _keyStrokeHandler = KeyStrokeHandler(
  //   onStartTyping: startTyping,
  //   onStopTyping: stopTyping,
  // );

  // int? get memberCount {
  //   _checkInitialized();
  //   return state!._channelState.channel?.memberCount;
  // }

  // /// Channel member count as a stream.
  // Stream<int?> get memberCountStream {
  //   _checkInitialized();
  //   return state!.channelStateStream.map((cs) => cs.channel?.memberCount);
  // }

  final _messageAttachmentsUploadCompleter = <String, Completer<Message>>{};
  final _cancelableAttachmentUploadRequest = <String, CancelToken>{};

  Future<Message> sendMessage(
    Message message, {
    bool skipPush = false,
    bool skipEnrichUrl = false,
  }) async {
    _checkInitialized();
    // Cancelling previous completer in case it's called again in the process
    // Eg. Updating the message while the previous call is in progress.
    _messageAttachmentsUploadCompleter
        .remove(message.id)
        ?.completeError('Message Cancelled');

    // final quotedMessage = state!.messages.firstWhereOrNull(
    //   (m) => m.id == message.quotedMessageId,
    // );
    // ignore: parameter_assignments
    message = message.copyWith(
      createdAt: message.createdAt,
      sender: _client.state.currentUser,
      // quotedMessage: quotedMessage,
      status: MessageStatus.sending,
      attachments: message.attachments.map(
        (it) {
          if (it.uploadState.isSuccess) return it;
          return it.copyWith(
              id: const Uuid().v4(),
              uploadState: const UploadState.preparing());
        },
      ).toList(),
    );

    state!.updateMessage(message);

    try {
      if (message.attachments.any((it) => !it.uploadState.isSuccess)) {
        final attachmentsUploadCompleter = Completer<Message>();
        _messageAttachmentsUploadCompleter[message.id] =
            attachmentsUploadCompleter;

        _uploadAttachments(
          message.id,
          message.attachments.map((it) => it.id),
        );

        // ignore: parameter_assignments
        message = await attachmentsUploadCompleter.future;
      }

      final rs = await _channelRepository.sendMessage(
        id!,
        message: message,
      );

      state!.updateMessage(rs);

      return rs;
    } catch (e) {
      // if (e is StreamChatNetworkError && e.isRetriable) {
      //   state!._retryQueue.add([message]);
      // }
      rethrow;
    }
  }

  Future<void> retryAttachmentUpload(String messageId, String attachmentId) =>
      _uploadAttachments(messageId, [attachmentId]);

  Future<void> _uploadAttachments(
    String messageId,
    Iterable<String> attachmentIds,
  ) {
    var message = [
      ...state!.messages,
    ].firstWhereOrNull((it) => it.id == messageId);

    if (message == null) {
      throw const OCError('Error, Message not found');
    }

    final attachments = message.attachments.where((it) {
      if (it.uploadState.isSuccess) return false;
      return attachmentIds.contains(it.id);
    });

    if (attachments.isEmpty) {
      client.logger.info('No attachments available to upload');
      if (message.attachments.every((it) => it.uploadState.isSuccess)) {
        _messageAttachmentsUploadCompleter.remove(messageId)?.complete(message);
      }
      return Future.value();
    }

    client.logger.info('Found ${attachments.length} attachments');

    void updateAttachment(Attachment attachment) {
      final index = message!.attachments.indexWhere(
        (it) => it.id == attachment.id,
      );
      if (index != -1) {
        final newAttachments = [...message!.attachments]..[index] = attachment;
        final updatedMessage = message!.copyWith(attachments: newAttachments);
        state?.updateMessage(updatedMessage);
        // updating original message for next iteration
        message = message!.merge(updatedMessage);
      }
    }

    return Future.wait(attachments.map((it) {
      client.logger.info('Uploading ${it.id} attachment...');

      final throttledUpdateAttachment = updateAttachment.throttled(
        const Duration(milliseconds: 500),
      );

      void onSendProgress(int sent, int total) {
        throttledUpdateAttachment([
          it.copyWith(
            uploadState: UploadState.inProgress(uploaded: sent, total: total),
          ),
        ]);
      }

      final isImage = it.type == 'image';
      final cancelToken = CancelToken();
      Future<Attachment> future;
      if (isImage) {
        future = sendImage(
          it.file!,
          it.id,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        ).then((it) => it);
      } else {
        future = sendFile(
          it.file!,
          it.id,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        ).then((it) => it);
      }
      _cancelableAttachmentUploadRequest[it.id] = cancelToken;
      return future.then((attachment) {
        print(attachment.toString());
        client.logger.info('Attachment ${it.id} uploaded successfully...');
        // if (isImage) {
        updateAttachment(it.copyWith(
          fileSize: attachment.fileSize,
          url: attachment.url,
          id: attachment.id,
          mimeType: attachment.mimeType,
          createdAt: attachment.createdAt,
          updatedAt: attachment.updatedAt,
          originalHeight: attachment.originalHeight,
          originalWidth: attachment.originalWidth,
          originalName: attachment.originalName,
          secureUrl: attachment.secureUrl,
          thumbnailUrl: attachment.thumbnailUrl,
          type: attachment.type,
          uploadState: const UploadState.success(),
        ));
        // } else {
        //   updateAttachment(
        //     it.merge(attachment).copyWith(uploadState: constUpload),
        //   );
        // }
      }).catchError((e, stk) {
        client.logger.severe('error uploading the attachment', e, stk);
        updateAttachment(
          it.copyWith(uploadState: UploadState.failed(error: e.toString())),
        );
      }).whenComplete(() {
        throttledUpdateAttachment.cancel();
        _cancelableAttachmentUploadRequest.remove(it.id);
      });
    })).whenComplete(() {
      if (message!.attachments.every((it) => it.uploadState.isSuccess)) {
        _messageAttachmentsUploadCompleter.remove(messageId)?.complete(message);
      }
    });
  }

  Future<ChannelState> watch() async {
    ChannelState? response;

    try {
      final rs = await _channelRepository.queryChannel(id!);
      rs.fold((channelState) {
        response = channelState;
      }, (error) {
        if (!_initializedCompleter.isCompleted) {
          _initializedCompleter.completeError(error);
        }
        throw error;
      });
    } catch (error, stackTrace) {
      if (!_initializedCompleter.isCompleted) {
        _initializedCompleter.completeError(error, stackTrace);
      }
      rethrow;
    }

    if (state == null) {
      _initState(response!);
    }

    return response!;
  }

  Future<Attachment> sendFile(
    AttachmentFile file,
    String attachmentID, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) {
    _checkInitialized();
    return _channelRepository.sendFile(
      id!,
      attachmentID,
      file,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  /// Send an image to this channel.
  Future<Attachment> sendImage(
    AttachmentFile image,
    String attachmentID, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) {
    _checkInitialized();
    return _channelRepository.sendImage(
      id!,
      attachmentID,
      image,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  void _initState(ChannelState channelState) {
    state = ChannelClientState(this, channelState);

    if (id != null) {
      client.state.channels = {id!: this};
    }
    if (!_initializedCompleter.isCompleted) {
      _initializedCompleter.complete(true);
    }
  }

  String? get id => state?._channelState.channel?.id ?? _id;

  Client get client => _client;
  final Client _client;

  final Completer<bool> _initializedCompleter = Completer();

  Future<bool> get initialized => _initializedCompleter.future;

  void dispose() {
    client.state.removeChannel('$id');
    state?.dispose();
    // _keyStrokeHandler.cancel();
  }

  void _checkInitialized() {
    assert(
      _initializedCompleter.isCompleted,
      "Channel $_id hasn't been initialized yet. Make sure to call .watch()"
      ' or to instantiate the client using [Channel.fromState]',
    );
  }

  void cancelAttachmentUpload(
    String attachmentId, {
    String? reason,
  }) {
    final cancelToken = _cancelableAttachmentUploadRequest[attachmentId];
    if (cancelToken == null) {
      throw const OCError(
        "Upload request for this Attachment hasn't started yet or maybe "
        'Already completed',
      );
    }
    if (cancelToken.isCancelled) {
      throw const OCError('Upload request already cancelled');
    }
    cancelToken.cancel(reason);
  }
}

class ChannelClientState {
  final Channel _channel;
  final _subscriptions = CompositeSubscription();

  ChannelClientState(
    this._channel,
    ChannelState channelState,
  ) {
    _channelStateController = BehaviorSubject.seeded(channelState);

    _listenMessageNew();

    updateChannelState(channelState);
  }

  void _listenMessageNew() {
    _subscriptions.add(_channel
        .on(
      EventType.messageNew,
      EventType.notificationMessageNew,
    )
        .listen((event) {
      final message = event.message!;
      if (isUpToDate
          // || (message.parentId != null && message.showInChannel != true)
          ) {
        updateMessage(message);
      }

      // if (_countMessageAsUnread(message)) {
      //   unreadCount += 1;
      // }
    }));
  }

  void updateMessage(Message message) {
    final newMessages = [...messages];
    final oldIndex = newMessages.indexWhere((m) => m.id == message.id);
    if (oldIndex != -1) {
      Message? m;
      // if (message.quotedMessageId != null && message.quotedMessage == null) {
      //   final oldMessage = newMessages[oldIndex];
      //   m = message.copyWith(
      //     quotedMessage: oldMessage.quotedMessage,
      //   );
      // }
      newMessages[oldIndex] = m ?? message;
    } else {
      newMessages.add(message);
    }

    // final newPinnedMessages = [...pinnedMessages];
    // final oldPinnedIndex =
    //     newPinnedMessages.indexWhere((m) => m.id == message.id);

    // Handle pinned messages
    // if (message.pinned) {
    //   if (oldPinnedIndex != -1) {
    //     newPinnedMessages[oldPinnedIndex] = message;
    //   } else {
    //     newPinnedMessages.add(message);
    //   }
    // } else {
    //   newPinnedMessages.removeWhere((m) => m.id == message.id);
    // }

    _channelState = _channelState.copyWith(
      messages: newMessages..sort(_sortByCreatedAt),
      // pinnedMessages: newPinnedMessages,
      channel: _channelState.channel?.copyWith(
        lastMessageAt: message.createdAt,
      ),
    );
  }

  int _sortByCreatedAt(Message a, Message b) =>
      a.createdAt.compareTo(b.createdAt);

  void updateChannelState(ChannelState updatedState) {
    final _existingStateMessages = _channelState.messages;
    final _updatedStateMessages = updatedState.messages;
    final newMessages = <Message>[
      ..._updatedStateMessages,
      ..._existingStateMessages
          .where((m) =>
              !_updatedStateMessages.any((newMessage) => newMessage.id == m.id))
          .toList(),
    ]..sort(_sortByCreatedAt);

    final newMembers = <Member>[
      ...updatedState.members ?? [],
    ];

    _channelState = _channelState.copyWith(
      messages: newMessages,
      channel: _channelState.channel?.merge(updatedState.channel),
      members: newMembers,
    );
  }

  void truncate() {
    _channelState = _channelState.copyWith(
      messages: [],
    );
  }

  List<Message> get messages => _channelState.messages;

  Stream<List<Message>> get messagesStream => channelStateStream
      .map((cs) => cs.messages)
      .distinct(const ListEquality().equals);

  List<Member> get members => _channelState.members;

  Stream<List<Member>> get membersStream => channelStateStream
      .map((cs) => cs.members)
      .distinct(const ListEquality().equals);

  bool get isUpToDate => _isUpToDateController.value;

  set isUpToDate(bool isUpToDate) => _isUpToDateController.add(isUpToDate);

  Stream<bool> get isUpToDateStream => _isUpToDateController.stream;

  final BehaviorSubject<bool> _isUpToDateController =
      BehaviorSubject.seeded(true);

  ChannelState get _channelState => _channelStateController.value;

  set _channelState(ChannelState v) {
    _channelStateController.add(v);
    // _debouncedUpdatePersistenceChannelState.call([v]);
  }

  Stream<ChannelState> get channelStateStream => _channelStateController.stream;

  ChannelState get channelState => _channelStateController.value;
  late BehaviorSubject<ChannelState> _channelStateController;

  void dispose() {
    _channelStateController.close();
  }
}
