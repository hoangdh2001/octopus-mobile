import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

extension RemoteMessageX on RemoteMessage {
  Map<String, dynamic> getContent() {
    return jsonDecode(data["content"]);
  }

  Map<String, dynamic> payload() {
    return getContent()["payload"];
  }
}
