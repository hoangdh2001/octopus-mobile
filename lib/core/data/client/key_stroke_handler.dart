import 'dart:async';

class KeyStrokeHandler {
  KeyStrokeHandler({
    this.startTypingEventTimeout = 1,
    this.startTypingResendInterval = 3,
    required this.onStartTyping,
    required this.onStopTyping,
  });

  final int startTypingEventTimeout;

  final int startTypingResendInterval;

  final Future<void> Function() onStartTyping;

  final Future<void> Function() onStopTyping;

  Timer? _keyStrokeTimer;
  DateTime? _lastTypingEvent;
  Completer<void>? _keyStrokeCompleter;

  Future<void> _startTyping() {
    _lastTypingEvent = DateTime.now();
    return onStartTyping();
  }

  Future<void> _stopTyping() {
    _lastTypingEvent = null;
    return onStopTyping();
  }

  void _completeKeyStrokeCompleterIfRequired() {
    final completer = _keyStrokeCompleter;
    if (completer != null && !completer.isCompleted) completer.complete();
  }

  Completer<void> _resetKeyStrokeCompleter() {
    _completeKeyStrokeCompleterIfRequired();
    return _keyStrokeCompleter = Completer<void>();
  }

  void _cancelKeyStrokeTimer() {
    _keyStrokeTimer?.cancel();
    _keyStrokeTimer = null;
  }

  void cancel() {
    if (_lastTypingEvent != null) {
      _stopTyping().catchError((_) {});
    }
    _cancelKeyStrokeTimer();
    _completeKeyStrokeCompleterIfRequired();
  }

  Future<void> call() async {
    final completer = _resetKeyStrokeCompleter();

    _cancelKeyStrokeTimer();

    _keyStrokeTimer = Timer(Duration(seconds: startTypingEventTimeout), () {
      _stopTyping().then((_) {
        if (completer.isCompleted) return;
        completer.complete();
      }).onError((error, stackTrace) {
        if (completer.isCompleted) return;
        completer.completeError(error!, stackTrace);
      });
    });

    final now = DateTime.now();
    final lastTypingEvent = _lastTypingEvent;
    if (lastTypingEvent == null ||
        now.difference(lastTypingEvent).inMilliseconds >
            startTypingResendInterval * 1000) {
      _startTyping().onError((error, stackTrace) {
        _cancelKeyStrokeTimer();
        if (completer.isCompleted) return;
        completer.completeError(error!, stackTrace);
      });
    }

    return completer.future;
  }
}
