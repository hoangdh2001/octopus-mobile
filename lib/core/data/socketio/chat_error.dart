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
