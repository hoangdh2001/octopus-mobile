import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/project.dart';
import 'package:octopus/core/data/models/enums/project_role.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/create_list/create_list_page.dart';
import 'package:octopus/pages/task_list/task_list.dart';
import 'package:octopus/widgets/avatars/space_avatar.dart';
import 'package:octopus/widgets/custom_expansion_tile/expansion_tile.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final workspace = OctopusWorkspace.of(context).workspace;
    return BetterStreamBuilder(
      stream: workspace.state!.projectsMapStream,
      builder: (context, data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final project = data[index];
            return ExpansionTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpaceAvatar(
                    name: project.state!.projectState.name,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      project.state!.projectState.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.primaryGreyBody,
                    ),
                  ),
                ],
              ),
              tilePadding: const EdgeInsets.symmetric(horizontal: 8).r,
              leading: (context, animation) {
                return RotationTransition(
                  turns: animation.drive(
                    Tween<double>(begin: 0.0, end: 0.37).chain(
                      CurveTween(curve: Curves.easeOut),
                    ),
                  ),
                  child: SizedBox(
                    height: double.infinity,
                    child: SvgPicture.asset(
                      'assets/icons/sort_right.svg',
                      width: 10,
                      height: 10,
                      color: OctopusTheme.of(context).colorTheme.icon,
                    ),
                  ),
                );
              },
              trailing: (context, animation) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final workspace =
                            OctopusWorkspace.of(context).workspace;
                        final currentUser =
                            Octopus.of(context).client.state.currentUser;
                        final currentMember = project
                            .state!.projectState.members
                            .firstWhereOrNull(
                                (member) => member.user.id == currentUser!.id);
                        final currentMember2 = workspace
                            .state!.workspaceState.members
                            ?.firstWhereOrNull(
                          (member) => member.user.id == currentUser!.id,
                        );
                        if (currentMember != null &&
                                (currentMember.role == ProjectRole.OWNER ||
                                    currentMember.role == ProjectRole.MEMBER) &&
                                ((currentMember2!.role?.ownCapabilities
                                            ?.contains(WorkspaceOwnCapability
                                                .createList) ??
                                        false) ||
                                    (currentMember2.role?.ownCapabilities
                                            ?.contains(WorkspaceOwnCapability
                                                .allCapabilities) ??
                                        false)) ||
                            project.state!.projectState.workspaceAccess) {
                          showListModal(context, project);
                        } else {
                          Fluttertoast.showToast(
                              msg: "You don't have permission to access",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black87,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/icons/plus.svg',
                        width: 24,
                        height: 24,
                        color: OctopusTheme.of(context).colorTheme.icon,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigator.pushNamed(context, Routes.TASK_LIST);
                    //   },
                    //   child: SvgPicture.asset(
                    //     'assets/icons/box_move_right.svg',
                    //     width: 24,
                    //     height: 24,
                    //   ),
                    // ),
                  ],
                );
              },
              children:
                  List.generate(project.state!.spacesState.length, (index) {
                final space = project.state!.spacesState[index];
                return ListTile(
                  leading: SizedBox(
                    height: double.infinity,
                    child: SvgPicture.asset(
                      'assets/icons/dot.svg',
                      color: OctopusTheme.of(context).colorTheme.icon,
                    ),
                  ),
                  onTap: () {
                    final workspace = OctopusWorkspace.of(context).workspace;
                    final currentUser =
                        Octopus.of(context).client.state.currentUser;
                    final currentMember = project.state!.projectState.members
                        .firstWhereOrNull(
                            (member) => member.user.id == currentUser!.id);
                    final currentMember2 = workspace
                        .state!.workspaceState.members
                        ?.firstWhereOrNull(
                      (member) => member.user.id == currentUser!.id,
                    );
                    if ((currentMember != null &&
                            ((currentMember.role == ProjectRole.OWNER ||
                                currentMember.role == ProjectRole.MEMBER ||
                                currentMember.role == ProjectRole.VIEWER)) ||
                        (currentMember2!.role?.ownCapabilities?.contains(
                                WorkspaceOwnCapability.viewOtherProject) ??
                            false) ||
                        (currentMember2.role?.ownCapabilities?.contains(
                                WorkspaceOwnCapability.allCapabilities) ??
                            false) ||
                        project.state!.projectState.workspaceAccess)) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.TASK_LIST,
                          arguments: TaskListPageArgs(
                              spaces: [space], project: project));
                    } else {
                      Fluttertoast.showToast(
                          msg: "You don't have permission to access",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  horizontalTitleGap: 0,
                  contentPadding: const EdgeInsets.only(left: 50).r,
                  title: Text(
                    space.name,
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }

  void showListModal(BuildContext context, Project project) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) =>
          CreateListPage(project: project.state!.projectState),
    );
  }
}
