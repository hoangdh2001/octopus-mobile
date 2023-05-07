import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/new_group_page/bloc/new_group_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "New group",
        actions: [
          TextButton(
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            onPressed: () {
              getIt<NewGroupBloc>().add(const NewGroup());
            },
            child: Text(
              'Create',
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NewGroupBloc, NewGroupState>(
        bloc: getIt<NewGroupBloc>(),
        builder: (context, state) {
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Group name (optional)',
                        hintStyle: OctopusTheme.of(context).textTheme.hint,
                      ),
                      style:
                          OctopusTheme.of(context).textTheme.primaryGreyInput,
                      cursorColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      enableSuggestions: true,
                      onChanged: (value) {
                        getIt<NewGroupBloc>().add(ChangedGroupName(value));
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                    child: CupertinoSearchTextField(
                      // controller: _controller,
                      placeholder: "Search",
                      itemColor: OctopusTheme.of(context).colorTheme.icon,
                      placeholderStyle: OctopusTheme.of(context).textTheme.hint,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                      prefixInsets: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5)
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
                if (state.users.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.users.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemBuilder: (_, index) {
                          final user = state.users.elementAt(index);
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
                                        width: 40, height: 40),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        getIt<NewGroupBloc>()
                                            .add(RemoveUser(user));
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
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) => FocusScope.of(context).unfocus(),
              child: BlocBuilder<NewGroupBloc, NewGroupState>(
                bloc: getIt<NewGroupBloc>(),
                builder: (context, state) {
                  return UserListView(
                    controller: getIt<UserListBloc>(),
                    // groupAlphabetically:
                    //     _isSearchActive ? false : true,
                    onUserTap: (user) {
                      if (!state.users.contains(user)) {
                        getIt<NewGroupBloc>().add(AddUser(user));
                      } else {
                        getIt<NewGroupBloc>().add(RemoveUser(user));
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
                        selected: state.users.contains(users[index]),
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
                                    // children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(24),
                                    //   child: StreamSvgIcon.search(
                                    //     size: 96,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   AppLocalizations.of(context)
                                    //       .noUserMatchesTheseKeywords,
                                    //   style: StreamChatTheme.of(context)
                                    //       .textTheme
                                    //       .footnote
                                    //       .copyWith(
                                    //           color: StreamChatTheme.of(context)
                                    //               .colorTheme
                                    //               .textHighEmphasis
                                    //               .withOpacity(.5)),
                                    // ),
                                    // ],
                                    ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
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
