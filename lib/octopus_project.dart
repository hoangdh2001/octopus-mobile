import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/project.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/workspace_state.dart';

class OctopusProject extends StatefulWidget {
  const OctopusProject({super.key, required this.project, required this.child});

  final Project project;

  final Widget child;

  @override
  State<OctopusProject> createState() => OctopusProjectState();

  static OctopusProjectState of(BuildContext context) {
    OctopusProjectState? octopusState;

    octopusState = context.findAncestorStateOfType<OctopusProjectState>();

    if (octopusState == null) {
      throw Exception(
        'You must have a Octopus Project widget at the top of your widget tree',
      );
    }

    return octopusState;
  }
}

class OctopusProjectState extends State<OctopusProject> {
  Project get project => widget.project;

  ProjectState get workspaceState => widget.project.state!.projectState;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
