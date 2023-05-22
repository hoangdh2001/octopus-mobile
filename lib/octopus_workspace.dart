import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

class OctopusWorkspace extends StatefulWidget {
  const OctopusWorkspace(
      {super.key, required this.worspace, required this.child});

  final Workspace worspace;

  final Widget child;

  @override
  State<OctopusWorkspace> createState() => OctopusWorkspaceState();

  static OctopusWorkspaceState of(BuildContext context) {
    OctopusWorkspaceState? octopusState;

    octopusState = context.findAncestorStateOfType<OctopusWorkspaceState>();

    if (octopusState == null) {
      throw Exception(
        'You must have a Octopus widget at the top of your widget tree',
      );
    }

    return octopusState;
  }
}

class OctopusWorkspaceState extends State<OctopusWorkspace> {
  Workspace get workspace => widget.worspace;

  WorkspaceState get workspaceState => widget.worspace.state!.workspaceState;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
