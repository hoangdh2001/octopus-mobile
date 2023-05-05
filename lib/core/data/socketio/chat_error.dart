import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/socketio/chat_error_code.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///
class OCError with EquatableMixin implements Exception {
  const OCError(this.message);

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'StreamChatError(message: $message)';
}

///
class SocketError extends OCError {
  ///
  const SocketError(
    super.message, {
    this.data,
  });

  ///
  factory SocketError.fromStreamError(Map<String, Object?> error) {
    final data = Error.fromJson(error);
    final message = data.detail;
    return SocketError(message, data: data);
  }

  ///
  factory SocketError.fromWebSocketChannelError(
    dynamic error,
  ) {
    final message = error.message ?? '';
    return SocketError(message);
  }

  ///
  int? get code => data?.status;

  ///
  ChatErrorCode? get errorCode {
    final code = this.code;
    if (code == null) return null;
    return chatErrorCodeFromCode(code);
  }

  /// Response body. please refer to [ErrorResponse].
  final Error? data;

  ///
  bool get isRetriable => data == null;

  @override
  List<Object?> get props => [...super.props, code];

  @override
  String toString() {
    var params = 'message: $message';
    if (data != null) params += ', data: $data';
    return 'WebSocketError($params)';
  }
}

class ChatNetworkError extends OCError {
  ///
  ChatNetworkError(
    ChatErrorCode errorCode, {
    int? statusCode,
    this.data,
  })  : code = errorCode.code,
        statusCode = statusCode ?? data?.status,
        super(errorCode.message);

  ///
  ChatNetworkError.raw({
    required this.code,
    required String message,
    this.statusCode,
    this.data,
  }) : super(message);

  ///
  factory ChatNetworkError.fromDioError(DioError error) {
    final response = error.response;
    Error? errorResponse;
    final data = response?.data;
    if (data != null) {
      errorResponse = Error.fromJson(data);
    }
    return ChatNetworkError.raw(
      code: errorResponse?.status ?? -1,
      message:
          errorResponse?.detail ?? response?.statusMessage ?? error.message!,
      statusCode: errorResponse?.status ?? response?.statusCode,
      data: errorResponse,
    )..stackTrace = error.stackTrace;
  }

  /// Error code
  final int code;

  /// HTTP status code
  final int? statusCode;

  /// Response body. please refer to [ErrorResponse].
  final Error? data;

  StackTrace? _stackTrace;

  ///
  set stackTrace(StackTrace? stack) => _stackTrace = stack;

  ///
  ChatErrorCode? get errorCode => chatErrorCodeFromCode(code);

  ///
  bool get isRetriable => data == null;

  @override
  List<Object?> get props => [...super.props, code, statusCode];

  @override
  String toString({bool printStackTrace = false}) {
    var params = 'code: $code, message: $message';
    if (statusCode != null) params += ', statusCode: $statusCode';
    if (data != null) params += ', data: $data';
    var msg = 'StreamChatNetworkError($params)';

    if (printStackTrace && _stackTrace != null) {
      msg += '\n$_stackTrace';
    }
    return msg;
  }
}
