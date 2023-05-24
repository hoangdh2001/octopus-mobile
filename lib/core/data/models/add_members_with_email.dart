import 'package:json_annotation/json_annotation.dart';

part 'add_members_with_email.g.dart';

@JsonSerializable()
class AddMemberWithEmail {
  final String email;

  AddMemberWithEmail({required this.email});

  factory AddMemberWithEmail.fromJson(Map<String, dynamic> json) =>
      _$AddMemberWithEmailFromJson(json);

  Map<String, dynamic> toJson() => _$AddMemberWithEmailToJson(this);
}
