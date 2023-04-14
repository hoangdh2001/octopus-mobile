import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';

part 'page.g.dart';

@freezed
@JsonSerializable(genericArgumentFactories: true)
class Page<T> with _$Page<T> {
  const factory Page({
    int? skip,
    int? limit,
    int? totalItem,
    int? totalPage,
    required List<T> data,
  }) = _Page;

  factory Page.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$PageFromJson<T>(json, fromJsonT);
  }
}
