import 'package:flutter/material.dart'
    hide ExpansionTile, ModalBottomSheetRoute;
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/create_project/create_project_page.dart';
import 'package:octopus/pages/new_task/new_task_page.dart';
import 'package:octopus/pages/new_workspace/new_workspace_page.dart';
import 'package:octopus/pages/workspace/workspace_page.dart';
import 'package:octopus/widgets/avatars/workspace_avatar.dart';
import 'package:octopus/widgets/custom_expansion_tile/expansion_tile.dart';
import 'package:octopus/widgets/menu_item.dart';
import 'package:octopus/pages/settings/settings_page.dart';
import 'package:octopus/widgets/project_list/project_list.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final List<MenuItem> items;
  final ValueChanged<int>? onTap;

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ).r,
        child: SingleChildScrollView(
          child: Column(
            children: [
              drawerHeader(context),
              Column(
                children: List<Widget>.generate(
                  widget.items.length,
                  (index) => GestureDetector(
                    onTap: () {
                      widget.onTap?.call(index);
                    },
                    child: widget.items[index],
                  ),
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Spaces',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                ),
                visualDensity: VisualDensity.compact,
                trailing: (context, animation) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/reboot.svg',
                          width: 24,
                          height: 24,
                          color: OctopusTheme.of(context).colorTheme.icon,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          showNewProjectModal(context);
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
                      RotationTransition(
                        turns: animation.drive(
                          Tween<double>(begin: 0.0, end: 0.37).chain(
                            CurveTween(curve: Curves.easeOut),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/arrow_right.svg',
                          color: OctopusTheme.of(context).colorTheme.icon,
                        ),
                      ),
                    ],
                  );
                },
                children: const [
                  ProjectList(),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Docs',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                ),
                visualDensity: VisualDensity.compact,
                trailing: (context, animation) {
                  return RotationTransition(
                    turns: animation.drive(
                      Tween<double>(begin: 0.0, end: 0.37).chain(
                        CurveTween(curve: Curves.easeOut),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      color: OctopusTheme.of(context).colorTheme.icon,
                    ),
                  );
                },
                children: const [],
              ),
            ].insertBetween(Divider(
              height: 1,
              color: OctopusTheme.of(context).colorTheme.border,
            )),
          ),
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
    final currentUser = Octopus.of(context).currentUser;
    final client = Octopus.of(context).client;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        right: 8.0,
        left: 8.0,
      ).r,
      child: Column(
        children: [
          BetterStreamBuilder(
              stream: client.state.currentWorkspaceStream,
              builder: (context, data) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WorkspaceAvatar(
                      name: data.name,
                      constraints:
                          const BoxConstraints.tightFor(width: 35, height: 35),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final client = Octopus.of(context).client;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return WorkspacePage(
                                    client: client,
                                    onCreateWorkspaceTap: showCreateWorkspace,
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.name,
                                    style: OctopusTheme.of(context)
                                        .textTheme
                                        .primaryGreyBodyBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/chevron_down.svg',
                                  color:
                                      OctopusTheme.of(context).colorTheme.icon,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            currentUser!.name,
                            style: OctopusTheme.of(context)
                                .textTheme
                                .secondaryGreyCaption2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final client = Octopus.of(context).client;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SettingsPage(
                              client: client,
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        color: OctopusTheme.of(context).colorTheme.icon,
                      ),
                    ),
                  ],
                );
              }),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            child: SizedBox(
              height: 30.h,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: "Search",
                  hintStyle: OctopusTheme.of(context).textTheme.hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ).r,
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: OctopusTheme.of(context).colorTheme.icon,
                  ),
                  prefixIconConstraints:
                      const BoxConstraints.tightFor(width: 40, height: 15),
                ),
                enabled: false,
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const NewTaskPage(),
      ),
    );
  }

  void showCreateWorkspace() {
    Navigator.pushNamed(context, Routes.CREATE_WORKSPACE,
        arguments: NewWorkspacePageArgs(showBack: true));
  }

  void showNewProjectModal(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => const CreateProjectPage(),
    );
  }
}

// ExpansionTile(
//                     title: Row(
//                       children: [
//                         SpaceAvatar(
//                           name: 'To do app',
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Expanded(
//                           child: Text(
//                             'To do app',
//                             style: theme.textTheme.primaryGreyBody,
//                           ),
//                         ),
//                       ],
//                     ),
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 8).r,
//                     leading: (context, animation) {
//                       return RotationTransition(
//                         turns: animation.drive(
//                           Tween<double>(begin: 0.0, end: 0.37).chain(
//                             CurveTween(curve: Curves.easeOut),
//                           ),
//                         ),
//                         child: SizedBox(
//                             height: double.infinity,
//                             child: SvgPicture.asset(
//                               'assets/icons/sort_right.svg',
//                               width: 10,
//                               height: 10,
//                             )),
//                       );
//                     },
//                     trailing: (context, animation) {
//                       return Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               showNewTaskModal(context);
//                             },
//                             child: SvgPicture.asset(
//                               'assets/icons/plus.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, Routes.TASK_LIST);
//                             },
//                             child: SvgPicture.asset(
//                               'assets/icons/box_move_right.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                     children: [
//                       ExpansionTile(
//                         title: Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/icons/folder.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Phase 01: Design',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: OctopusTheme.of(context)
//                                     .textTheme
//                                     .primaryGreyBody,
//                               ),
//                             ),
//                           ],
//                         ),
//                         leading: (context, animation) {
//                           return RotationTransition(
//                             turns: animation.drive(
//                               Tween<double>(begin: 0.0, end: 0.37).chain(
//                                 CurveTween(curve: Curves.easeOut),
//                               ),
//                             ),
//                             child: SizedBox(
//                                 height: double.infinity,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/sort_right.svg',
//                                   width: 10,
//                                   height: 10,
//                                 )),
//                           );
//                         },
//                         trailing: (context, animation) {
//                           return Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   showNewTaskModal(context);
//                                 },
//                                 child: SvgPicture.asset(
//                                   'assets/icons/plus.svg',
//                                   width: 24,
//                                   height: 24,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               SvgPicture.asset(
//                                 'assets/icons/box_move_right.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ],
//                           );
//                         },
//                         tilePadding:
//                             const EdgeInsets.only(left: 60, right: 8).r,
//                         expandedCrossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 01',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 02',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ExpansionTile(
//                         title: Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/icons/folder.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Phase 02: Development',
//                                 style: OctopusTheme.of(context)
//                                     .textTheme
//                                     .primaryGreyBody,
//                               ),
//                             ),
//                           ],
//                         ),
//                         leading: (context, animation) {
//                           return RotationTransition(
//                             turns: animation.drive(
//                               Tween<double>(begin: 0.0, end: 0.37).chain(
//                                 CurveTween(curve: Curves.easeOut),
//                               ),
//                             ),
//                             child: SizedBox(
//                                 height: double.infinity,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/sort_right.svg',
//                                   width: 10,
//                                   height: 10,
//                                 )),
//                           );
//                         },
//                         trailing: (context, animation) {
//                           return Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   showNewTaskModal(context);
//                                 },
//                                 child: SvgPicture.asset(
//                                   'assets/icons/plus.svg',
//                                   width: 24,
//                                   height: 24,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               SvgPicture.asset(
//                                 'assets/icons/box_move_right.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ],
//                           );
//                         },
//                         tilePadding:
//                             const EdgeInsets.only(left: 60, right: 8).r,
//                         expandedCrossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 01',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 02',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   ExpansionTile(
//                     title: Row(
//                       children: [
//                         SpaceAvatar(
//                           name: 'To do app',
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Expanded(
//                           child: Text(
//                             'To do app',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: theme.textTheme.primaryGreyBody,
//                           ),
//                         ),
//                       ],
//                     ),
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 8).r,
//                     leading: (context, animation) {
//                       return RotationTransition(
//                         turns: animation.drive(
//                           Tween<double>(begin: 0.0, end: 0.37).chain(
//                             CurveTween(curve: Curves.easeOut),
//                           ),
//                         ),
//                         child: SizedBox(
//                             height: double.infinity,
//                             child: SvgPicture.asset(
//                               'assets/icons/sort_right.svg',
//                               width: 10,
//                               height: 10,
//                             )),
//                       );
//                     },
//                     trailing: (context, animation) {
//                       return Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               showNewTaskModal(context);
//                             },
//                             child: SvgPicture.asset(
//                               'assets/icons/plus.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           SvgPicture.asset(
//                             'assets/icons/box_move_right.svg',
//                             width: 24,
//                             height: 24,
//                           ),
//                         ],
//                       );
//                     },
//                     children: [
//                       ExpansionTile(
//                         title: Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/icons/folder.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Phase 01: Design',
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: OctopusTheme.of(context)
//                                     .textTheme
//                                     .primaryGreyBody,
//                               ),
//                             ),
//                           ],
//                         ),
//                         leading: (context, animation) {
//                           return RotationTransition(
//                             turns: animation.drive(
//                               Tween<double>(begin: 0.0, end: 0.37).chain(
//                                 CurveTween(curve: Curves.easeOut),
//                               ),
//                             ),
//                             child: SizedBox(
//                                 height: double.infinity,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/sort_right.svg',
//                                   width: 10,
//                                   height: 10,
//                                 )),
//                           );
//                         },
//                         trailing: (context, animation) {
//                           return Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/icons/plus.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               SvgPicture.asset(
//                                 'assets/icons/box_move_right.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ],
//                           );
//                         },
//                         tilePadding:
//                             const EdgeInsets.only(left: 60, right: 8).r,
//                         expandedCrossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 01',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 02',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ExpansionTile(
//                         title: Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/icons/folder.svg',
//                               width: 24,
//                               height: 24,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Phase 02: Development',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: OctopusTheme.of(context)
//                                     .textTheme
//                                     .primaryGreyBody,
//                               ),
//                             ),
//                           ],
//                         ),
//                         leading: (context, animation) {
//                           return RotationTransition(
//                             turns: animation.drive(
//                               Tween<double>(begin: 0.0, end: 0.37).chain(
//                                 CurveTween(curve: Curves.easeOut),
//                               ),
//                             ),
//                             child: SizedBox(
//                                 height: double.infinity,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/sort_right.svg',
//                                   width: 10,
//                                   height: 10,
//                                 )),
//                           );
//                         },
//                         trailing: (context, animation) {
//                           return Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/icons/plus.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               SvgPicture.asset(
//                                 'assets/icons/box_move_right.svg',
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ],
//                           );
//                         },
//                         tilePadding:
//                             const EdgeInsets.only(left: 60, right: 8).r,
//                         expandedCrossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 01',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                           ListTile(
//                             leading: SvgPicture.asset(
//                               'assets/icons/document.svg',
//                               color: OctopusTheme.of(context).colorTheme.icon,
//                             ),
//                             horizontalTitleGap: 0,
//                             contentPadding: const EdgeInsets.only(left: 100).r,
//                             title: Text(
//                               'Content 02',
//                               style: OctopusTheme.of(context)
//                                   .textTheme
//                                   .primaryGreyBody,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
