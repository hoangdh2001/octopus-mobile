import 'package:characters/characters.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:octopus/core/data/models/emoji.dart';

final _emojiChars = Emoji.chars();

extension ExtensionString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~.]).{8,}');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  String charAt(int index) {
    final value = this;
    if (value.length <= index || value.length + index < 0) {
      return '';
    }

    int realPosition = index < 0 ? value.length + index : index;

    return value[realPosition];
  }

  MediaType? get mimeType {
    if (toLowerCase().endsWith('heic')) {
      return MediaType.parse('image/heic');
    } else {
      final mimeType = lookupMimeType(this);
      if (mimeType == null) return null;
      return MediaType.parse(mimeType);
    }
  }

  bool get isOnlyEmoji {
    if (isEmpty) return false;
    final characters = trim().characters;
    return characters.every(_emojiChars.contains);
  }
}
