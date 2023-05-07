import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/widgets/chip_input_text_field.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:octopus/widgets/user_list/user_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({super.key});

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  final _chipInputTextFieldStateKey =
      GlobalKey<ChipInputTextFieldState<User>>();

  late TextEditingController _controller;

  final _searchFocusNode = FocusNode();

  ChipInputTextFieldState? get _chipInputTextFieldState =>
      _chipInputTextFieldStateKey.currentState;

  Timer? _debounce;

  final _selectedUsers = <User>{};

  bool _isSearchActive = false;

  bool _showUserList = true;

  void _userNameListener() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted)
        // setState(() {
        //   _userNameQuery = _controller.text;
        //   _isSearchActive = _userNameQuery.isNotEmpty;
        // });
        // userListController.filter = Filter.and([
        //   if (_userNameQuery.isNotEmpty)
        //     Filter.autoComplete('name', _userNameQuery),
        //   Filter.notEqual('id', StreamChat.of(context).currentUser!.id),
        // ]);
        getIt<UserListBloc>().add(const DoInitialLoad());
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _controller.clear();
    _controller.removeListener(_userNameListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "News message",
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
      body: Column(
        children: [
          ChipsInputTextField<User>(
            key: _chipInputTextFieldStateKey,
            controller: _controller,
            focusNode: _searchFocusNode,
            hint: '',
            chipBuilder: (context, user) {
              return GestureDetector(
                onTap: () {},
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: OctopusTheme.of(context)
                            .colorTheme
                            .primaryGrey
                            .withOpacity(.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(right: 18),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                        child: Text(
                          '${user.firstName} ${user.lastName}',
                          maxLines: 1,
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBodyBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: IconButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              OctopusTheme.of(context).colorTheme.icon),
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                        ),
                        splashColor: Colors.transparent,
                        hoverColor:
                            OctopusTheme.of(context).colorTheme.lightGrey,
                        onPressed: () {
                          _chipInputTextFieldState?.removeItem(user);
                          _searchFocusNode.requestFocus();
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/close.svg',
                          color: OctopusTheme.of(context).colorTheme.icon,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            onChipAdded: (user) {
              setState(() => _selectedUsers.add(user));
            },
            onChipRemoved: (user) {
              setState(() => _selectedUsers.remove(user));
            },
          ),
          if (!_isSearchActive && !_selectedUsers.isNotEmpty)
            SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.NEW_GROUP_CHAT);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: OctopusTheme.of(context)
                              .colorTheme
                              .cardBackgroundSecondary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child:
                              SvgPicture.asset('assets/icons/user_group.svg'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Create a new group',
                        style: OctopusTheme.of(context)
                            .textTheme
                            .primaryGreyBodyBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_showUserList)
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  'Suggested',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
              ),
            ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) => FocusScope.of(context).unfocus(),
              child: UserListView(
                controller: getIt<UserListBloc>(),
                // groupAlphabetically:
                //     _isSearchActive ? false : true,
                onUserTap: (user) {
                  _controller.clear();
                  if (!_selectedUsers.contains(user)) {
                    _chipInputTextFieldState
                      ?..addItem(user)
                      ..pauseItemAddition();
                  } else {
                    _chipInputTextFieldState!.removeItem(user);
                  }
                },
                itemBuilder: (
                  context,
                  users,
                  index,
                  defaultWidget,
                ) {
                  return defaultWidget.copyWith(
                    selectedWidget: null,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
