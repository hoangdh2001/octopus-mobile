import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/avatars/workspace_avatar.dart';
import 'package:octopus/widgets/screen_header.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: theme.colorTheme.contentView,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: theme.colorTheme.contentViewSecondary,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text('Status',
                                      style: theme.textTheme.primaryGreyBody),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: theme.colorTheme.brandPrimary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'IN PROGRESS',
                                          style: theme
                                              .textTheme.primaryGreyBodyBold
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text('Assignee',
                                      style: theme.textTheme.primaryGreyBody),
                                  const Spacer(),
                                  const WorkspaceAvatar(name: 'Do Hoang')
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text('Dates',
                                      style: theme.textTheme.primaryGreyBody),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: theme.colorTheme.brandPrimary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'IN PROGRESS',
                                          style: theme
                                              .textTheme.primaryGreyBodyBold
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text('Track Time',
                                      style: theme.textTheme.primaryGreyBody),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: theme.colorTheme.brandPrimary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'IN PROGRESS',
                                          style: theme
                                              .textTheme.primaryGreyBodyBold
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                            TextButton(
                              style: OctopusTheme.of(context)
                                  .buttonTheme
                                  .brandPrimaryButton,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Add Description',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
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
                              'Field',
                              style: theme.textTheme.primaryGreyBody,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ].insertBetween(Container(
                  height: 16,
                )),
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
