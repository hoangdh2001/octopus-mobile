// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ChannelService implements ChannelService {
  _ChannelService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Page<ChannelState>> getChannels(payload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'payload': payload};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Page<ChannelState>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Page<ChannelState>.fromJson(_result.data!,
        (json) => ChannelState.fromJson(json as Map<String, dynamic>));
    return value;
  }

  @override
  Future<ChannelState> createChannel(newChannel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(newChannel.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ChannelState>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChannelState.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChannelState> queryChannel(
    channelID,
    channelQuery,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(channelQuery.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ChannelState>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/query',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChannelState.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Message> sendMessage(
    channelID,
    message,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(message.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Message>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/messages',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Message.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> deleteMessage(
    String channelID,
    String messageID,
    bool? hard,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'hard': hard,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/messages/${messageID}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Attachment> sendFile(
    channelID,
    attachmentID,
    file,
    onSendProgress,
    onReceiveProgress,
    cancelToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap({'file': file});
    _data.fields.add(MapEntry(
      'attachmentID',
      attachmentID,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Attachment>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/file',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Attachment.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Attachment> sendImage(
    channelID,
    attachmentID,
    file,
    onSendProgress,
    onReceiveProgress,
    cancelToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData.fromMap({'file': file});
    if (attachmentID != null) {
      _data.fields.add(MapEntry(
        'attachmentID',
        attachmentID,
      ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Attachment>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/image',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Attachment.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> sendEvent(
    String channelID,
    Event event,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(event.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/event',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> markRead(
    String channelID,
    MarkReadRequest markRequestRequest,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(markRequestRequest.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/read',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SendReactionResponse> sendReaction(
    String channelID,
    String messageID,
    String reactionType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendReactionResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/messages/${messageID}/reactions/${reactionType}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SendReactionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> deleteReaction(
    String channelID,
    String messageID,
    String reactionType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/messages/${messageID}/reactions/${reactionType}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> call(
    String channelID,
    String callType,
    bool hasVideo,
    bool isGroup,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'hasVideo': hasVideo,
      r'isGroup': isGroup
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/channels/${channelID}/call/${callType}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<ChannelState> updateChannel(
    String channelID,
    Map<String, Object?> channelData,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(channelData);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ChannelState>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChannelState.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Message> updateMessage(
    String channelID,
    String messageID,
    Map<String, Object?>? set,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(set ?? {});
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Message>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/messages/${messageID}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Message.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> muteChannel(String channelID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/mute',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> unmuteChannel(String channelID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/unmute',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchMessagesResponse> search(String payload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'payload': payload};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchMessagesResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchMessagesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> addMembers(
    String channelID,
    AddMembersRequest members,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(members.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/members',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmptyResponse> removeMember(
    String channelID,
    String memberID,
    String removeType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmptyResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/channels/${channelID}/members/${memberID}/${removeType}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EmptyResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
