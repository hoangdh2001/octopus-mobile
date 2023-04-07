import 'package:flutter/foundation.dart';

class IndexedKey extends LocalKey {
  const IndexedKey(this.key, this.index);

  final Key? key;

  final int index;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is IndexedKey && other.key == key;
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() => '(IndexedKey) index: $index, key: $key';
}
