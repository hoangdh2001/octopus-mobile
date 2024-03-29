import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/group.dart';
import 'package:octopus/core/data/models/group_member.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_group.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/widgets/user_list/user_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class AssignUserPage extends StatefulWidget {
  const AssignUserPage(
      {super.key, required this.onDoneTap, required this.users});

  final void Function(List<User>) onDoneTap;

  final List<User> users;

  @override
  State<AssignUserPage> createState() => _AssignUserPageState();
}

class _AssignUserPageState extends State<AssignUserPage> {
  TextEditingController? _controller;

  late final userListController = UserListBloc(
    client: Octopus.of(context).client,
    sort: [
      const SortOption(
        'firstName',
        direction: 1,
      ),
    ],
    limit: 25,
    filter: Filter.and(
      [
        Filter.notEqual(
          'enabled',
          false,
          fieldType: FieldType.BOOLEAN,
          type: FilterType.SQL,
        ),
      ],
      type: FilterType.SQL,
    ),
  );

  String _userNameQuery = '';

  bool _isSearchActive = false;

  late final _selectedUsers = widget.users.toSet();

  late final _selectedGroups = <GroupMember>{};

  int currentIndex = 0;

  Timer? _debounce;

  void _userNameListener() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _userNameQuery = _controller!.text;
          _isSearchActive = _userNameQuery.isNotEmpty;
        });
        userListController.filter = Filter.and(
          [
            if (_userNameQuery.isNotEmpty)
              Filter.contains(
                'name',
                _userNameQuery,
                fieldType: FieldType.STRING,
                type: FilterType.SQL,
              ),
            Filter.notEqual(
              'id',
              Octopus.of(context).currentUser!.id,
              fieldType: FieldType.UUID,
              type: FilterType.SQL,
            ),
            Filter.notEqual(
              'enabled',
              false,
              fieldType: FieldType.BOOLEAN,
              type: FilterType.SQL,
            ),
          ],
          type: FilterType.SQL,
        );
        userListController.add(const DoInitialLoad());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_userNameListener);
  }

  @override
  void dispose() {
    _controller?.clear();
    _controller?.removeListener(_userNameListener);
    _controller?.dispose();
    userListController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Octopus.of(context).currentUser;
    final theme = OctopusTheme.of(context);
    final workspace = OctopusWorkspace.of(context).workspace;
    final groups = workspace.state!.workspaceState.workspaceGroups
            ?.map((group) {
          final count = workspace.state!.workspaceState.members!
              .where((member) =>
                  member.groups?.map((e) => e.id).contains(group.id) ?? false)
              .toList();

          return GroupMember(
            group,
            count,
          );
        }).toList() ??
        <GroupMember>[];
    return DefaultTabController(
      length: 2,
      initialIndex: currentIndex,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leadingWidth: 0,
              title: Text('assign_users_page.title'.tr(),
                  style: OctopusTheme.of(context).textTheme.navigationTitle),
              centerTitle: false,
              backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              elevation: 0,
              actions: [
                TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                  onPressed: () {
                    if (currentIndex == 0) {
                      widget.onDoneTap(_selectedUsers.toList());
                    } else {
                      final users = <User>{};
                      for (final group in _selectedGroups) {
                        users.addAll(
                            group.users?.map((e) => e.user) ?? <User>[]);
                      }
                      widget.onDoneTap(users.toList());
                    }
                    Navigator.pop(context);
                  },
                  child: Text('done'.tr()),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0).r,
                  child: CupertinoSearchTextField(
                    controller: _controller,
                    placeholder: "search".tr(),
                    itemColor: OctopusTheme.of(context).colorTheme.icon,
                    placeholderStyle: OctopusTheme.of(context).textTheme.hint,
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    prefixInsets:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                            .r,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0)
                            .r,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                    onTap: (value) {
                      currentIndex = value;
                      if (value == 0) {
                        setState(() {
                          _selectedGroups.clear();
                        });
                      } else {
                        setState(() {
                          _selectedUsers.clear();
                        });
                      }
                    },
                    dividerColor: theme.colorTheme.border,
                    indicatorColor: theme.colorTheme.brandPrimary,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: theme.colorTheme.brandPrimary,
                    unselectedLabelColor: theme.colorTheme.primaryGrey,
                    labelStyle:
                        OctopusTheme.of(context).textTheme.brandPrimaryBodyBold,
                    automaticIndicatorColorAdjustment: true,
                    tabs: [
                      Tab(
                        text: 'assign_users_page.members_tab'.tr(),
                      ),
                      Tab(
                        text: 'assign_users_page.groups_tab'.tr(),
                      ),
                    ],
                  ),
                ),
                height: 35,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: _selectedUsers.isEmpty
                        ? Text(
                            'assign_users_page.people'.tr(),
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBodyBold,
                            overflow: TextOverflow.visible,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedUsers.clear();
                              });
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/remove_message.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'assign_users_page.remove_all'.tr(),
                                  style: OctopusTheme.of(context)
                                      .textTheme
                                      .primaryGreyBodyBold,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                height: 30,
              ),
            ),
          ];
        },
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => FocusScope.of(context).unfocus(),
          child: TabBarView(
            children: [
              UserListView(
                controller: userListController,
                // groupAlphabetically:
                //     _isSearchActive ? false : true,
                onUserTap: (user) {
                  if (!_selectedUsers.contains(user)) {
                    setState(() {
                      _selectedUsers.add(user);
                    });
                  } else {
                    setState(() {
                      _selectedUsers.remove(user);
                    });
                  }
                },
                itemBuilder: (
                  context,
                  users,
                  index,
                  defaultWidget,
                ) {
                  final showText = users[index].id == currentUser!.id;
                  if (showText) {
                    return defaultWidget.copyWith(
                      showSelectWidget: true,
                      selected: _selectedUsers.contains(users[index]),
                      title: Text.rich(
                        TextSpan(
                          text: users[index].name,
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBodyBold,
                          children: [
                            TextSpan(
                              text: ' (${'you'.tr()})',
                              style: OctopusTheme.of(context)
                                  .textTheme
                                  .primaryGreyBody,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return defaultWidget.copyWith(
                    showSelectWidget: true,
                    selected: _selectedUsers.contains(users[index]),
                  );
                },
                emptyBuilder: (_) {
                  return LayoutBuilder(
                    builder: (context, viewportConstraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: SvgPicture.asset(
                                    'assets/icons/nothing_found.svg',
                                    width: 96,
                                    height: 96,
                                  ),
                                ),
                                Text(
                                  'no_users_found'.tr(),
                                  style: OctopusTheme.of(context)
                                      .textTheme
                                      .primaryGreyH1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return CheckboxListTile(
                    title: Text(group.group.name ?? 'unnamed'.tr()),
                    subtitle: Text(
                      '${group.group.description} (${'value_members'.tr(namedArgs: {
                            'count': group.users!.length.toString()
                          })})',
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                    onChanged: (bool? value) {
                      if (value ?? false) {
                        setState(
                          () {
                            _selectedGroups.add(group);
                          },
                        );
                      } else {
                        setState(
                          () {
                            _selectedGroups.remove(group);
                          },
                        );
                      }
                    },
                    value: _selectedGroups.contains(group),
                    activeColor: theme.colorTheme.brandPrimary,
                    checkboxShape: const CircleBorder(),
                  );
                },
              ),
            ],
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
