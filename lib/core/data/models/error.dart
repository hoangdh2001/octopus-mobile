import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error.freezed.dart';

part 'error.g.dart';

@freezed
class Error with _$Error {
  const factory Error({
    required String title,
    required int status,
    required String detail,
    required String path,
  }) = _Error;

  factory Error.fromJson(Map<String, Object?> json) => _$ErrorFromJson(json);
}
