import 'package:flutter/material.dart';

class MediaListViewController extends ChangeNotifier {
  var _shouldUpdateMedia = false;

  /// Getter that knows if the media should be updated.
  bool get shouldUpdateMedia => _shouldUpdateMedia;

  /// Method that update shouldUpdateMedia and notify all listeners
  /// about this update.
  void updateMedia({required bool newValue}) {
    _shouldUpdateMedia = newValue;
    notifyListeners();
  }
}
