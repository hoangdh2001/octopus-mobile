import 'package:json_annotation/json_annotation.dart';

enum WorkspaceOwnCapability {
  @JsonValue("ALL_CAPABILITIES")
  allCapabilities,
  @JsonValue("CREATE_PROJECT")
  createProject,
  @JsonValue("ADD_MEMBER")
  addMember,
  @JsonValue("CREATE_LIST")
  createList,
  @JsonValue("VIEW_OTHER_PROJECT")
  viewOtherProject;
}
