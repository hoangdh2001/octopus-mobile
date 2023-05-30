import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:octopus/widgets/user_list/user_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController? _controller;

  String _userNameQuery = '';

  bool _isSearchActive = false;

  final _selectedUsers = <User>{};

  Timer? _debounce;

  TextEditingController? _groupNameController;

  bool _isGroupNameEmpty = true;

  int get _totalUsers => _selectedUsers.length;

  void _groupNameListener() {
    final name = _groupNameController!.text;
    if (mounted) {
      setState(() {
        _isGroupNameEmpty = name.isEmpty;
      });
    }
  }

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
    ),
  );

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
    _groupNameController = TextEditingController()
      ..addListener(_groupNameListener);
  }

  @override
  void dispose() {
    _controller?.clear();
    _controller?.removeListener(_userNameListener);
    _controller?.dispose();
    userListController.close();
    _groupNameController?.removeListener(_groupNameListener);
    _groupNameController?.clear();
    _groupNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "New group",
        actions: [
          TextButton(
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            onPressed: _totalUsers < 2
                ? null
                : () async {
                    try {
                      final groupName = _groupNameController!.text;
                      final client = Octopus.of(context).client;
                      Octopus.of(context).showLoadingOverlay(context);
                      final channel = await client.createChannel(
                        members: _selectedUsers
                            .map((e) => e.id)
                            .toList(growable: false),
                        name: groupName.isEmpty ? null : groupName,
                      );
                      await channel.watch();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.CHANNEL_PAGE,
                        ModalRoute.withName(Routes.MAIN),
                        arguments: ChannelPageArgs(channel: channel),
                      );
                    } catch (err) {
                      Navigator.pop(context);
                      // _showErrorAlert();
                    }
                  },
            child: Text(
              'Create',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Group name (optional)',
                    hintStyle: OctopusTheme.of(context).textTheme.hint,
                  ),
                  style: OctopusTheme.of(context).textTheme.primaryGreyInput,
                  cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                  enableSuggestions: true,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
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
            if (_selectedUsers.isNotEmpty)
              SliverToBoxAdapter(
                child: Container(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedUsers.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                    itemBuilder: (_, index) {
                      final user = _selectedUsers.elementAt(index);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              UserAvatar(
                                user: user,
                                constraints: const BoxConstraints.tightFor(
                                    width: 50, height: 50),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedUsers.remove(user);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: OctopusTheme.of(context)
                                            .colorTheme
                                            .contentView,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: OctopusTheme.of(context)
                                              .colorTheme
                                              .contentView,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade700,
                                            offset: const Offset(1, 1),
                                            blurRadius: 0.5,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 0.5,
                                          ),
                                        ]),
                                    child: SvgPicture.asset(
                                      'assets/icons/close.svg',
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .icon,
                                      width: 10,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 60,
                            ),
                            child: Text(
                              '${user.firstName} ${user.lastName}',
                              style: OctopusTheme.of(context)
                                  .textTheme
                                  .primaryGreyBodyBold,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      _isSearchActive
                          ? 'Matches for "$_userNameQuery"'
                          : 'Suggested',
                      style: OctopusTheme.of(context)
                          .textTheme
                          .primaryGreyBodyBold,
                      overflow: TextOverflow.visible,
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
