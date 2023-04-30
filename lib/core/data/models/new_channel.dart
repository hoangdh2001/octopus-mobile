
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_channel.freezed.dart';
part 'new_channel.g.dart';

@freezed
class NewChannel with _$NewChannel {
  const factory NewChannel({
    required List<String> newMembers,
    String? name,
    String? userID,
  }) = _NewChannel;

  factory NewChannel.fromJson(Map<String, dynamic> json) =>
      _$NewChannelFromJson(json);
}
