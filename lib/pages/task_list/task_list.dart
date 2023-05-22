import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/models/space.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
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
  final List<Space> spaces;

  TaskListPageArgs({required this.spaces});
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key, required this.spaces});

  final List<Space> spaces;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // final List<BoardListObject> _listData = [
  //   BoardListObject(title: "TO DO", items: [
  //     BoardItemObject(
  //         title:
  //             "Android - Program lead button is overlapping the description"),
  //     BoardItemObject(
  //         title: "Android - Program lead button is overlapping the description")
  //   ]),
  //   BoardListObject(
  //     title: "IN PROGRESS",
  //     color: Color(0xFF7C68EC),
  //   ),
  //   BoardListObject(title: "DONE", color: Colors.green)
  // ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final space = widget.spaces[0];
    List<BoardList> _lists = [];
    for (int i = 0; i < space.setting.statuses.length; i++) {
      final status = space.setting.statuses[i];
      _lists.add(_createBoardList(BoardListObject(
        title: status.name,
        color: HexColor.fromHex(status.color),
        items: space.tasks,
      )) as BoardList);
    }
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentViewSecondary,
      appBar: TaskListHeader(
        showBackButton: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/more.svg',
                width: 26,
                color: OctopusTheme.of(context).colorTheme.icon,
              ),
            ),
          ),
        ],
        subtitleWidget: Row(
          children: [
            SvgPicture.asset('assets/icons/description.svg'),
            Text(
              "List",
              style: OctopusTheme.of(context).textTheme.primaryGreyBody,
            ),
            SvgPicture.asset('assets/icons/arrow_down.svg'),
          ].insertBetween(const SizedBox(
            width: 6,
          )),
        ),
      ),
      body: BoardView(
        lists: _lists,
        boardViewController: boardViewController,
        width: 0.9.sw,
      ),
    );
  }

  Widget buildBoardItem(Task task) {
    return BoardItem(
      onStartDragItem:
          (int? listIndex, int? itemIndex, BoardItemState? state) {},
      onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
          int? oldItemIndex, BoardItemState? state) {
        //Used to update our local item data
        // var item = _listData[oldListIndex!].items![oldItemIndex!];
        // _listData[oldListIndex].items!.removeAt(oldItemIndex!);
        // _listData[listIndex!].items!.insert(itemIndex!, item);
      },
      onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {
        Navigator.pushNamed(context, Routes.TASK_DETAIL);
      },
      item: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            task.name!,
            style: OctopusTheme.of(context).textTheme.primaryGreyBody,
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
          icon: SvgPicture.asset('assets/icons/plus.svg'),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/more.svg'),
        )
      ],
      items: items,
    );
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
