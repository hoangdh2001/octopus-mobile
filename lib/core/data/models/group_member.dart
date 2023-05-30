import 'package:equatable/equatable.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_group.dart';
import 'package:octopus/core/data/models/workspace_member.dart';

class GroupMember extends Equatable {
  final WorkspaceGroup group;
  final List<WorkspaceMember>? users;

  const GroupMember(this.group, this.users);

  @override
  List<Object?> get props => [group, users];
}
