class AddMemberToProjectRequest {
  final List<String> members;

  AddMemberToProjectRequest(this.members);

  Map<String, dynamic> toJson() => {
        'members': members,
      };
}
