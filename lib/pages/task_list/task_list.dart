import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/project.dart';
import 'package:octopus/core/data/models/space_state.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus_project.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/task_detail/task_detail_page.dart';
import 'package:octopus/pages/task_options/task_options_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/task/task_list_header.dart';

class BoardItemObject {
  String? title;

  BoardItemObject({this.title}) {
    if (this.title == null) {
      this.title = "";
    }
  }
}

class BoardListObject {
  String? title;
  Color? color;
  List<Task>? items;

  BoardListObject({this.title, Color? color, this.items})
      : color = color ?? Colors.grey {
    if (this.title == null) {
      this.title = "";
    }
    if (this.items == null) {
      this.items = [];
    }
  }
}

class TaskListPageArgs {
  final List<SpaceState> spaces;

  final Project project;

  TaskListPageArgs({required this.spaces, required this.project});
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key, required this.spaces});

  final List<SpaceState> spaces;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  late SpaceState space = widget.spaces.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final workspace = OctopusWorkspace.of(context).workspace;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentViewSecondary,
      appBar: TaskListHeader(
        showBackButton: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              showCustomModalBottomSheet(
                context: context,
                expand: false,
                builder: (context) {
                  return TaskOptionsPage(
                    onDelete: () {
                      deleteList();
                    },
                    onEdit: () {},
                  );
                },
                backgroundColor: Colors.transparent,
                containerWidget: (BuildContext context,
                    Animation<double> animation, Widget child) {
                  return Container(
                    height: 200 + MediaQuery.of(context).padding.bottom,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: child,
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/more.svg',
                  width: 26,
                  color: OctopusTheme.of(context).colorTheme.icon,
                ),
              ),
            ),
          ),
        ],
        subtitleWidget: Row(
          children: [
            SvgPicture.asset('assets/icons/description.svg',
                color: OctopusTheme.of(context).colorTheme.icon),
            Text(
              "Board",
              style: OctopusTheme.of(context).textTheme.primaryGreyBody,
            ),
            SvgPicture.asset('assets/icons/arrow_down.svg',
                color: OctopusTheme.of(context).colorTheme.icon),
          ].insertBetween(const SizedBox(
            width: 6,
          )),
        ),
      ),
      body: BetterStreamBuilder(
          stream: OctopusProject.of(context).project.state!.spacesStateStream,
          builder: (context, data) {
            final inSpace = widget.spaces[0];
            space = data.firstWhere((space) => space.id == inSpace.id);
            final statuses = space.setting.statuses
              ..sort((a, b) => a.numOrder?.compareTo(b.numOrder ?? 0) ?? 0);
            List<BoardList> _lists = [];
            for (int i = 0; i < statuses.length; i++) {
              final status = statuses[i];
              final tasks = space.tasks
                      ?.where((task) => task.taskStatus?.id == status.id)
                      .toList() ??
                  [];
              _lists.add(_createBoardList(BoardListObject(
                title: status.name,
                color: HexColor.fromHex(status.color),
                items: tasks,
              )) as BoardList);
            }
            return BoardView(
              lists: _lists,
              boardViewController: boardViewController,
              width: 0.9.sw,
            );
          }),
    );
  }

  Widget buildBoardItem(Task task) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        final workspace = OctopusWorkspace.of(context).workspace;
        final project = OctopusProject.of(context).project;
        final newTask = task.copyWith(
            taskStatus: space.setting.statuses.firstWhere(
                (status) => status.numOrder == listIndex,
                orElse: () => space.setting.statuses.first));
        project.updateTask(space.id, newTask);
        workspace.updatePartialTask(newTask);
      },
      onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {
        Navigator.pushNamed(context, Routes.TASK_DETAIL,
            arguments: TaskDetailPageArgs(
              task: task,
              space: widget.spaces[0],
              projectID:
                  OctopusProject.of(context).project.state!.projectState.id,
            ));
      },
      item: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: HexColor.fromHex(task.taskStatus?.color),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      task.name!,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/calendar.svg',
                                color:
                                    OctopusTheme.of(context).colorTheme.icon),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              task.startDate != null
                                  ? '${DateFormat('MMMM dd').format(task.startDate!)} - '
                                  : 'Start date - ',
                              style: OctopusTheme.of(context)
                                  .textTheme
                                  .primaryGreyBody,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              task.dueDate != null
                                  ? DateFormat('MMMM dd').format(task.dueDate!)
                                  : 'Due date',
                              style: OctopusTheme.of(context)
                                  .textTheme
                                  .primaryGreyBody,
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 30.h,
                            child: Builder(builder: (context) {
                              final workspace =
                                  OctopusWorkspace.of(context).workspace;
                              final assignees = workspace
                                  .state!.workspaceState.members
                                  ?.where((member) =>
                                      task.assignees
                                          ?.contains(member.user.id) ??
                                      false)
                                  .toList();
                              return Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.centerRight,
                                children: List.generate(
                                  assignees?.length ?? 0,
                                  (index) {
                                    final user = assignees![index];
                                    return Positioned(
                                      right: index * 20,
                                      child: UserAvatar(
                                        user: user.user,
                                        showOnlineStatus: false,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items!.length; i++) {
      items.insert(i, buildBoardItem(list.items![i]) as BoardItem);
    }

    return BoardList(
      draggable: false,
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor:
          OctopusTheme.of(context).colorTheme.contentViewSecondary,
      backgroundColor: OctopusTheme.of(context).colorTheme.contentViewSecondary,
      header: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: list.color,
            ),
            child: Center(
              child: Text(
                list.title!.toUpperCase(),
                style: OctopusTheme.of(context)
                    .textTheme
                    .primaryGreyBodyBold
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/plus.svg',
              color: OctopusTheme.of(context).colorTheme.icon),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/more.svg',
              color: OctopusTheme.of(context).colorTheme.icon),
        )
      ],
      items: items,
    );
  }

  void deleteList() {
    Navigator.pop(context);
    final projectID = OctopusProject.of(context).project.state!.projectState.id;
    final workspace = OctopusWorkspace.of(context).workspace;
    workspace.deleteSpace(projectID, space.id);
  }
}

// SingleChildScrollView(
//         child: Column(
//           children: [
//             ExpansionTile(
//               title: Row(
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey,
//                     ),
//                     child: Text(
//                       'TO DO',
//                       style: OctopusTheme.of(context)
//                           .textTheme
//                           .primaryGreyBodyBold
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               dense: true,
//               visualDensity: VisualDensity.compact,
//               horizontalTitleGap: 0,
//               leading: (context, animation) {
//                 return SizedBox(
//                   height: double.infinity,
//                   child: RotationTransition(
//                     turns: animation.drive(
//                       Tween<double>(begin: 0.0, end: 0.37).chain(
//                         CurveTween(curve: Curves.easeOut),
//                       ),
//                     ),
//                     child: SvgPicture.asset(
//                       'assets/icons/sort_right.svg',
//                       width: 10,
//                       height: 10,
//                     ),
//                   ),
//                 );
//               },
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 100,
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Card(
//                     child: ListTile(
//                       title: Text('Task 1'),
//                       subtitle: Text('Description'),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             ExpansionTile(
//               title: Row(
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: OctopusTheme.of(context).colorTheme.brandPrimary,
//                     ),
//                     child: Text(
//                       'IN PROGRESS',
//                       style: OctopusTheme.of(context)
//                           .textTheme
//                           .primaryGreyBodyBold
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               dense: true,
//               visualDensity: VisualDensity.compact,
//               horizontalTitleGap: 0,
//               leading: (context, animation) {
//                 return SizedBox(
//                   height: double.infinity,
//                   child: RotationTransition(
//                     turns: animation.drive(
//                       Tween<double>(begin: 0.0, end: 0.37).chain(
//                         CurveTween(curve: Curves.easeOut),
//                       ),
//                     ),
//                     child: SvgPicture.asset(
//                       'assets/icons/sort_right.svg',
//                       width: 10,
//                       height: 10,
//                     ),
//                   ),
//                 );
//               },
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 100,
//                   color: Colors.red,
//                 )
//               ],
//             ),
//             ExpansionTile(
//               title: Row(
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.green,
//                     ),
//                     child: Text(
//                       'DONE',
//                       style: OctopusTheme.of(context)
//                           .textTheme
//                           .primaryGreyBodyBold
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               horizontalTitleGap: 0,
//               leading: (context, animation) {
//                 return SizedBox(
//                   height: double.infinity,
//                   child: RotationTransition(
//                     turns: animation.drive(
//                       Tween<double>(begin: 0.0, end: 0.37).chain(
//                         CurveTween(curve: Curves.easeOut),
//                       ),
//                     ),
//                     child: SvgPicture.asset(
//                       'assets/icons/sort_right.svg',
//                       width: 10,
//                       height: 10,
//                     ),
//                   ),
//                 );
//               },
//               dense: true,
//               visualDensity: VisualDensity.compact,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 100,
//                   color: Colors.red,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
