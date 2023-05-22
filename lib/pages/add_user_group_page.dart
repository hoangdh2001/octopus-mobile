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
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/button/neumorphic_button.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:octopus/widgets/user_list/user_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _selectedUsers = <User>{};

  TextEditingController? _controller;

  String _userNameQuery = '';

  bool _isSearchActive = false;

  Timer? _debounce;

  late final channel = OctopusChannel.of(context).channel;

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
        Filter.notIn(
          'id',
          [
            Octopus.of(context).currentUser!.id,
            ...channel.state!.members
                .map<String?>(((e) => e.userID))
                .whereType<String>(),
          ],
          fieldType: FieldType.UUID,
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
        userListController.filter = Filter.and([
          if (_userNameQuery.isNotEmpty)
            Filter.autoComplete('name', _userNameQuery),
          Filter.notEqual('id', Octopus.of(context).currentUser!.id),
        ]);
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
    userListController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "New members",
        subtitle: "Selected: ${_selectedUsers.length}",
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: OctopusTheme.of(context).colorTheme.icon,
          ),
        ),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
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
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                child: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      'Suggested',
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
        body: Stack(
          children: [
            GestureDetector(
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
                                  'Nothing found',
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
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: _selectedUsers.isEmpty ? -70 - bottomPadding : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                height: 70 + bottomPadding,
                padding: EdgeInsets.only(bottom: bottomPadding),
                decoration: BoxDecoration(
                  color: OctopusTheme.of(context).colorTheme.contentView,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, -1),
                      color: Colors.grey,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedUsers.length,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemBuilder: (_, index) {
                          final user = _selectedUsers.elementAt(index);
                          return Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              UserAvatar(
                                user: user,
                                constraints: const BoxConstraints.tightFor(
                                  width: 50,
                                  height: 50,
                                ),
                                borderRadius: BorderRadius.circular(30),
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
                          );
                        },
                      ),
                    ),
                    NeumorphicButton(
                      size: 50,
                      backgroundColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      child: InkWell(
                        onTap: () async {
                          final membersID =
                              _selectedUsers.map((e) => e.id).toList();
                          Octopus.of(context).showLoadingOverlay(context);
                          await channel.addMembers(membersID);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/Right.svg',
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
