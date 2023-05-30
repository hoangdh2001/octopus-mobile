import 'package:json_annotation/json_annotation.dart';

part 'add_members_with_email.g.dart';

@JsonSerializable()
class AddMemberWithEmail {
  final String email;
  final String role;
  final String? group;

  AddMemberWithEmail({required this.email, required this.role, this.group});

  factory AddMemberWithEmail.fromJson(Map<String, dynamic> json) =>
      _$AddMemberWithEmailFromJson(json);

  Map<String, dynamic> toJson() => _$AddMemberWithEmailToJson(this);
}
