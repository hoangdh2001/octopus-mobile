import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/models/space_state.dart';
import 'package:octopus/core/data/models/task.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/assign_user/assign_user_page.dart';
import 'package:octopus/pages/choose_status/choose_status_page.dart';
import 'package:octopus/pages/date_picker/date_picker_page.dart';
import 'package:octopus/pages/task_options/task_options_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/screen_header.dart';

class TaskDetailPageArgs {
  const TaskDetailPageArgs({required this.task, required this.space});

  final SpaceState space;
  final Task task;
}

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, required this.task, required this.space});

  final Task task;

  final SpaceState space;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TextEditingController _controller;

  late Task task;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.task.name);
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final workspace = OctopusWorkspace.of(context).workspace;
    final theme = OctopusTheme.of(context);
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: '',
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/visibility.svg',
              color: OctopusTheme.of(context).colorTheme.icon,
              width: 24,
              height: 24,
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              showCustomModalBottomSheet(
                context: context,
                expand: false,
                builder: (context) {
                  return TaskOptionsPage(
                    onDelete: () {},
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
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: OctopusTheme.of(context).colorTheme.icon,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Task Name',
                          hintStyle:
                              OctopusTheme.of(context).textTheme.hintLarge,
                        ),
                        style:
                            OctopusTheme.of(context).textTheme.primaryGreyInput,
                        cursorColor:
                            OctopusTheme.of(context).colorTheme.brandPrimary,
                        enableSuggestions: true,
                        onSubmitted: (value) {
                          setState(() {
                            task = task.copyWith(name: value);
                          });
                          workspace.updatePartialTask(task);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _HeaderDelegate(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: theme.colorTheme.contentView,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.colorTheme.border,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TabBar(
                      dividerColor: theme.colorTheme.border,
                      indicatorColor: theme.colorTheme.brandPrimary,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: theme.colorTheme.brandPrimary,
                      unselectedLabelColor: theme.colorTheme.primaryGrey,
                      labelStyle: OctopusTheme.of(context)
                          .textTheme
                          .brandPrimaryBodyBold,
                      automaticIndicatorColorAdjustment: true,
                      tabs: const [
                        Tab(
                          text: 'Overview',
                        ),
                        Tab(
                          text: 'Comments',
                        ),
                        Tab(
                          text: 'Attachments',
                        ),
                      ],
                    ),
                  ),
                  height: 35,
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorTheme.contentViewSecondary,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: theme.colorTheme.contentView,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: theme.colorTheme.contentViewSecondary,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Status',
                                    style: theme.textTheme.primaryGreyBody),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        useSafeArea: true,
                                        builder: (context) => Dialog(
                                          backgroundColor:
                                              OctopusTheme.of(context)
                                                  .colorTheme
                                                  .contentView,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          insetPadding:
                                              const EdgeInsets.all(16),
                                          clipBehavior: Clip.antiAlias,
                                          child: ChooseStatusPage(
                                            statuses:
                                                widget.space.setting.statuses,
                                            onStatusSelected: (statusTask) {
                                              setState(() {
                                                task = task.copyWith(
                                                  taskStatus: statusTask,
                                                );
                                              });
                                              workspace.updatePartialTask(task);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: HexColor.fromHex(
                                          task.taskStatus!.color ?? '',
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          task.taskStatus!.name ?? '',
                                          style: theme
                                              .textTheme.primaryGreyBodyBold
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              child: Builder(
                                builder: (context) {
                                  final assignees = workspace
                                      .state!.workspaceState.members
                                      ?.where((member) =>
                                          task.assignees?.contains(member.id) ??
                                          false)
                                      .toList();
                                  return Row(
                                    children: [
                                      Text('Assignee',
                                          style:
                                              theme.textTheme.primaryGreyBody),
                                      const Spacer(),
                                      assignees != null && assignees.isNotEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                showBarModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                20)
                                                            .r,
                                                  ),
                                                  builder: (context) =>
                                                      AssignUserPage(
                                                    onDoneTap: (users) {
                                                      setState(() {
                                                        task = task.copyWith(
                                                          assignees: users
                                                              .map((user) =>
                                                                  user.id)
                                                              .toList(),
                                                        );
                                                      });
                                                      workspace
                                                          .updatePartialTask(
                                                        task.copyWith(
                                                          assignees: users
                                                              .map((user) =>
                                                                  user.id)
                                                              .toList(),
                                                        ),
                                                      );
                                                    },
                                                    users: assignees,
                                                  ),
                                                );
                                              },
                                              child: SizedBox(
                                                width: 100.w,
                                                height: 30.h,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  children: List.generate(
                                                    assignees.length,
                                                    (index) {
                                                      final user =
                                                          assignees[index];
                                                      return Positioned(
                                                        right: index * 20,
                                                        child: UserAvatar(
                                                          user: user,
                                                          showOnlineStatus:
                                                              false,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            )
                                          : TextButton.icon(
                                              onPressed: () {
                                                showBarModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                20)
                                                            .r,
                                                  ),
                                                  builder: (context) =>
                                                      AssignUserPage(
                                                    onDoneTap: (users) {
                                                      setState(() {
                                                        task = task.copyWith(
                                                          assignees: users
                                                              .map((user) =>
                                                                  user.id)
                                                              .toList(),
                                                        );
                                                      });
                                                      workspace
                                                          .updatePartialTask(
                                                        task.copyWith(
                                                          assignees: users
                                                              .map((user) =>
                                                                  user.id)
                                                              .toList(),
                                                        ),
                                                      );
                                                    },
                                                    users: const [],
                                                  ),
                                                );
                                              },
                                              icon: SvgPicture.asset(
                                                'assets/icons/user_add.svg',
                                                color: theme.colorTheme.icon,
                                              ),
                                              label: Text(
                                                'Add Assignee',
                                                style: theme
                                                    .textTheme.primaryGreyBody,
                                              ),
                                            )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context) => Dialog(
                                  backgroundColor: OctopusTheme.of(context)
                                      .colorTheme
                                      .contentView,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: DatePickerPage(
                                    onDone: (startDate, dueDate) {
                                      setState(() {
                                        task = task.copyWith(
                                          startDate: startDate,
                                          dueDate: dueDate,
                                        );
                                      });
                                    },
                                    startDate: task.startDate,
                                    dueDate: task.dueDate,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text('Dates',
                                      style: theme.textTheme.primaryGreyBody),
                                  const Spacer(),
                                  (widget.task.startDate != null ||
                                          widget.task.dueDate != null)
                                      ? Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/calendar.svg'),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              widget.task.startDate != null
                                                  ? '${DateFormat('MMMM dd').format(task.startDate!)} - '
                                                  : 'Start date - ',
                                              style: theme
                                                  .textTheme.primaryGreyBody,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            SvgPicture.asset(
                                                'assets/icons/calendar.svg'),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              widget.task.dueDate != null
                                                  ? DateFormat('MMMM dd')
                                                      .format(task.dueDate!)
                                                  : 'Due date',
                                              style: theme
                                                  .textTheme.primaryGreyBody,
                                            ),
                                          ],
                                        )
                                      : TextButton.icon(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              useSafeArea: true,
                                              builder: (context) => Dialog(
                                                backgroundColor:
                                                    OctopusTheme.of(context)
                                                        .colorTheme
                                                        .contentView,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: DatePickerPage(
                                                  onDone: (startDate, dueDate) {
                                                    setState(() {
                                                      task.copyWith(
                                                        startDate: startDate,
                                                        dueDate: dueDate,
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/icons/calendar_plus.svg',
                                            color: theme.colorTheme.icon,
                                          ),
                                          label: Text(
                                            'Add dates',
                                            style:
                                                theme.textTheme.primaryGreyBody,
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ].insertBetween(Divider(
                          height: 1,
                          thickness: 1,
                          color: theme.colorTheme.border,
                        )),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: theme.colorTheme.contentView,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: theme.colorTheme.contentViewSecondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Description',
                              style: theme.textTheme.primaryGreyBody,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            (task.description == null ||
                                    (task.description?.isEmpty ?? false))
                                ? TextButton.icon(
                                    icon: SvgPicture.asset(
                                        'assets/icons/plus.svg'),
                                    style: OctopusTheme.of(context)
                                        .buttonTheme
                                        .greyButton,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: const Text(
                                      'Add Description',
                                    ),
                                  )
                                : Text(
                                    task.description ?? '',
                                    style: theme.textTheme.primaryGreyBody,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ].insertBetween(
                  const SizedBox(
                    height: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const _HeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: OctopusTheme.of(context).colorTheme.contentView,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) => true;
}
