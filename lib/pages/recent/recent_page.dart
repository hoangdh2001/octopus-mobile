import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' show CupertinoSlidingSegmentedControl;
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/new_task/new_task_page.dart';
import 'package:octopus/widgets/custom_expansion_tile/expansion_tile.dart';

enum RecentSegment {
  mywork,
  calendar,
}

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  RecentSegment _selectedSegment = RecentSegment.mywork;

  bool get isSelectMyWork => _selectedSegment == RecentSegment.mywork;
  @override
  Widget build(BuildContext context) {
    final workspace = OctopusWorkspace.of(context).workspace;
    final theme = OctopusTheme.of(context);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: CupertinoSlidingSegmentedControl<RecentSegment>(
                    backgroundColor: theme.colorTheme.contentViewSecondary,
                    groupValue: _selectedSegment,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (RecentSegment? value) {
                      if (value != null) {
                        setState(() {
                          _selectedSegment = value;
                        });
                      }
                    },
                    children: <RecentSegment, Widget>{
                      RecentSegment.mywork: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'home_page.my_work_segment'.tr(),
                          style: isSelectMyWork
                              ? theme.textTheme.brandPrimaryBodyBold
                              : theme.textTheme.primaryGreyBodyBold,
                        ),
                      ),
                      RecentSegment.calendar: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'home_page.calendar_segment'.tr(),
                          style: isSelectMyWork
                              ? theme.textTheme.primaryGreyBodyBold
                              : theme.textTheme.brandPrimaryBodyBold,
                        ),
                      ),
                    },
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
                      tabs: [
                        const Tab(
                          text: 'To Do',
                        ),
                        Tab(
                          text: 'home_page.comment_tab'.tr(),
                        ),
                        Tab(
                          text: 'home_page.done_tab'.tr(),
                        ),
                      ],
                    ),
                  ),
                  height: 35,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              RefreshIndicator(
                color: theme.colorTheme.brandPrimary,
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      FutureBuilder(
                          future: workspace.getTodayTasks(),
                          builder: (context, snapshot) {
                            return ExpansionTile(
                              childrenPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'home_page.today_expansion'
                                                .tr(),
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBodyBold,
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${snapshot.data?.tasks.length ?? 0})',
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBody
                                                .copyWith(
                                                  color:
                                                      OctopusTheme.of(context)
                                                          .colorTheme
                                                          .primaryGrey
                                                          .withOpacity(.5),
                                                ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      style: OctopusTheme.of(context)
                                          .textTheme
                                          .primaryGreyBodyBold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showNewTaskModal();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/plus.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon,
                                    ),
                                  ),
                                ],
                              ),
                              leading: (context, animation) {
                                return RotationTransition(
                                  turns: animation.drive(
                                    Tween<double>(begin: 0.0, end: 0.37).chain(
                                      CurveTween(curve: Curves.easeOut),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/arrow_right.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon),
                                );
                              },
                              children: snapshot.hasData
                                  ? List.generate(
                                      snapshot.data!.tasks.length,
                                      (index) {
                                        final task =
                                            snapshot.data!.tasks[index];
                                        return ListTile(
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (task.startDate != null)
                                                Text(
                                                  'home_page.started_time'
                                                      .tr(namedArgs: {
                                                    'time':
                                                        Jiffy(task.startDate)
                                                            .fromNow()
                                                  }),
                                                  style: OctopusTheme.of(
                                                          context)
                                                      .textTheme
                                                      .secondaryGreyCaption2,
                                                ),
                                              Text(task.name ?? '')
                                            ],
                                          ),
                                          leading: SizedBox(
                                            height: double.infinity,
                                            child: SvgPicture.asset(
                                              'assets/icons/rounded_square.svg',
                                              color: HexColor.fromHex(
                                                task.taskStatus?.color ??
                                                    '#000000',
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data!.workspace.name,
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .secondaryGreyCaption2,
                                          ),
                                          trailing: task.dueDate != null
                                              ? Text(DateFormat('d MMM')
                                                  .format(task.dueDate!))
                                              : null,
                                          dense: true,
                                          onTap: () {},
                                          horizontalTitleGap: 0,
                                        );
                                      },
                                    )
                                  : [],
                            );
                          }),
                      FutureBuilder(
                          future: workspace.getTasksOverdue(),
                          builder: (context, snapshot) {
                            return ExpansionTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'home_page.overdue_expansion'
                                                .tr(),
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBodyBold,
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${snapshot.data?.tasks.length ?? 0})',
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBody
                                                .copyWith(
                                                  color:
                                                      OctopusTheme.of(context)
                                                          .colorTheme
                                                          .primaryGrey
                                                          .withOpacity(.5),
                                                ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      style: OctopusTheme.of(context)
                                          .textTheme
                                          .primaryGreyBodyBold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showNewTaskModal();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/plus.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon,
                                    ),
                                  ),
                                ],
                              ),
                              leading: (context, animation) {
                                return RotationTransition(
                                  turns: animation.drive(
                                    Tween<double>(begin: 0.0, end: 0.37).chain(
                                      CurveTween(curve: Curves.easeOut),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/arrow_right.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon),
                                );
                              },
                              children: snapshot.hasData
                                  ? List.generate(
                                      snapshot.data!.tasks.length,
                                      (index) {
                                        final task =
                                            snapshot.data!.tasks[index];
                                        return ListTile(
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (task.startDate != null)
                                                Text(
                                                  'home_page.started_time'
                                                      .tr(namedArgs: {
                                                    'time':
                                                        Jiffy(task.startDate)
                                                            .fromNow()
                                                  }),
                                                  style: OctopusTheme.of(
                                                          context)
                                                      .textTheme
                                                      .secondaryGreyCaption2,
                                                ),
                                              Text(task.name ?? '')
                                            ],
                                          ),
                                          leading: SizedBox(
                                            height: double.infinity,
                                            child: SvgPicture.asset(
                                              'assets/icons/rounded_square.svg',
                                              color: HexColor.fromHex(
                                                task.taskStatus?.color ??
                                                    '#000000',
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data!.workspace.name,
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .secondaryGreyCaption2,
                                          ),
                                          trailing: task.dueDate != null
                                              ? Text(DateFormat('d MMM')
                                                  .format(task.dueDate!))
                                              : null,
                                          dense: true,
                                          onTap: () {},
                                          horizontalTitleGap: 0,
                                        );
                                      },
                                    )
                                  : [],
                            );
                          }),
                      FutureBuilder(
                          future: workspace.getTasksNotDueDate(),
                          builder: (context, snapshot) {
                            return ExpansionTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'home_page.next_expansion'.tr(),
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBodyBold,
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${snapshot.data?.tasks.length ?? 0})',
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .primaryGreyBody
                                                .copyWith(
                                                  color:
                                                      OctopusTheme.of(context)
                                                          .colorTheme
                                                          .primaryGrey
                                                          .withOpacity(.5),
                                                ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      style: OctopusTheme.of(context)
                                          .textTheme
                                          .primaryGreyBodyBold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showNewTaskModal();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/plus.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon,
                                    ),
                                  ),
                                ],
                              ),
                              leading: (context, animation) {
                                return RotationTransition(
                                  turns: animation.drive(
                                    Tween<double>(begin: 0.0, end: 0.37).chain(
                                      CurveTween(curve: Curves.easeOut),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/arrow_right.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon),
                                );
                              },
                              children: snapshot.hasData
                                  ? List.generate(
                                      snapshot.data!.tasks.length,
                                      (index) {
                                        final task =
                                            snapshot.data!.tasks[index];
                                        return ListTile(
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (task.startDate != null)
                                                Text(
                                                  'home_page.started_time'
                                                      .tr(namedArgs: {
                                                    'time':
                                                        Jiffy(task.startDate)
                                                            .fromNow()
                                                  }),
                                                  style: OctopusTheme.of(
                                                          context)
                                                      .textTheme
                                                      .secondaryGreyCaption2,
                                                ),
                                              Text(task.name ?? '')
                                            ],
                                          ),
                                          leading: SizedBox(
                                            height: double.infinity,
                                            child: SvgPicture.asset(
                                              'assets/icons/rounded_square.svg',
                                              color: HexColor.fromHex(
                                                task.taskStatus?.color ??
                                                    '#000000',
                                              ),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data!.workspace.name,
                                            style: OctopusTheme.of(context)
                                                .textTheme
                                                .secondaryGreyCaption2,
                                          ),
                                          trailing: task.dueDate != null
                                              ? Text(DateFormat('d MMM')
                                                  .format(task.dueDate!))
                                              : null,
                                          dense: true,
                                          onTap: () {},
                                          horizontalTitleGap: 0,
                                        );
                                      },
                                    )
                                  : [],
                            );
                          }),
                      FutureBuilder(
                        future: workspace.getTasksNotDueDate(),
                        builder: (context, snapshot) {
                          return ExpansionTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'home_page.no_due_date_expansion'
                                                  .tr(),
                                          style: OctopusTheme.of(context)
                                              .textTheme
                                              .primaryGreyBodyBold,
                                        ),
                                        TextSpan(
                                          text:
                                              ' (${snapshot.data?.tasks.length ?? 0})',
                                          style: OctopusTheme.of(context)
                                              .textTheme
                                              .primaryGreyBody
                                              .copyWith(
                                                color: OctopusTheme.of(context)
                                                    .colorTheme
                                                    .primaryGrey
                                                    .withOpacity(.5),
                                              ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    style: OctopusTheme.of(context)
                                        .textTheme
                                        .primaryGreyBodyBold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showNewTaskModal();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/plus.svg',
                                    color: OctopusTheme.of(context)
                                        .colorTheme
                                        .icon,
                                  ),
                                ),
                              ],
                            ),
                            leading: (context, animation) {
                              return RotationTransition(
                                turns: animation.drive(
                                  Tween<double>(begin: 0.0, end: 0.37).chain(
                                    CurveTween(curve: Curves.easeOut),
                                  ),
                                ),
                                child: SvgPicture.asset(
                                    'assets/icons/arrow_right.svg',
                                    color: OctopusTheme.of(context)
                                        .colorTheme
                                        .icon),
                              );
                            },
                            children: snapshot.hasData
                                ? List.generate(
                                    snapshot.data!.tasks.length,
                                    (index) {
                                      final task = snapshot.data!.tasks[index];
                                      return ListTile(
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (task.startDate != null)
                                              Text(
                                                'home_page.started_time'
                                                    .tr(namedArgs: {
                                                  'time': Jiffy(task.startDate)
                                                      .fromNow()
                                                }),
                                                style: OctopusTheme.of(context)
                                                    .textTheme
                                                    .secondaryGreyCaption2,
                                              ),
                                            Text(task.name ?? '')
                                          ],
                                        ),
                                        leading: SizedBox(
                                          height: double.infinity,
                                          child: SvgPicture.asset(
                                            'assets/icons/rounded_square.svg',
                                            color: HexColor.fromHex(
                                              task.taskStatus?.color ??
                                                  '#000000',
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(
                                          snapshot.data!.workspace.name,
                                          style: OctopusTheme.of(context)
                                              .textTheme
                                              .secondaryGreyCaption2,
                                        ),
                                        trailing: task.dueDate != null
                                            ? Text(DateFormat('d MMM')
                                                .format(task.dueDate!))
                                            : null,
                                        dense: true,
                                        onTap: () {},
                                        horizontalTitleGap: 0,
                                      );
                                    },
                                  )
                                : [],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text('Comment'),
              ),
              RefreshIndicator(
                child: FutureBuilder(
                  future: workspace.getTaskDone(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          snapshot.data!.tasks.length,
                          (index) {
                            final task = snapshot.data!.tasks[index];
                            return ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Started 9 months ago',
                                    style: OctopusTheme.of(context)
                                        .textTheme
                                        .secondaryGreyCaption2,
                                  ),
                                  Text(task.name ?? '')
                                ],
                              ),
                              leading: SizedBox(
                                height: double.infinity,
                                child: SvgPicture.asset(
                                  'assets/icons/rounded_square.svg',
                                  color: HexColor.fromHex(
                                    task.taskStatus?.color ?? '#000000',
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data!.workspace.name,
                                style: OctopusTheme.of(context)
                                    .textTheme
                                    .secondaryGreyCaption2,
                              ),
                              trailing: task.dueDate != null
                                  ? Text(
                                      DateFormat('d MMM').format(task.dueDate!))
                                  : null,
                              dense: true,
                              onTap: () {},
                              horizontalTitleGap: 0,
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/nothing_found.svg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No task done',
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBodyBold,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(const Duration(seconds: 1));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showNewTaskModal() {
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
