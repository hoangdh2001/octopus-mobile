import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/octopus.dart';
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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            leadingWidth: 0,
            title: Text('Users',
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
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: () {
                  widget.onDoneTap(_selectedUsers.toList());
                  Navigator.pop(context);
                },
                child: const Text('Done'),
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
                  placeholder: "Search",
                  itemColor: OctopusTheme.of(context).colorTheme.icon,
                  placeholderStyle: OctopusTheme.of(context).textTheme.hint,
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  prefixInsets:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5).r,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0).r,
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
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: _selectedUsers.isEmpty
                      ? Text(
                          'People',
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
                                'Remove All',
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
        child: UserListView(
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
                            'No users found',
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
