import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/pagination_params.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/chip_input_text_field.dart';
import 'package:octopus/widgets/message_input/message_input.dart';
import 'package:octopus/widgets/message_list/message_list_view.dart';
import 'package:octopus/widgets/screen_header.dart';
import 'package:octopus/widgets/user_list/user_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({super.key});

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
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

  String _userNameQuery = '';

  Channel? channel;

  final _messageInputFocusNode = FocusNode();

  void _userNameListener() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _userNameQuery = _controller.text;
          _isSearchActive = _userNameQuery.isNotEmpty;
        });
      }
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
    });
  }

  @override
  void initState() {
    super.initState();
    channel = Octopus.of(context).client.channel();
    _controller = TextEditingController()..addListener(_userNameListener);

    _searchFocusNode.addListener(() async {
      if (_searchFocusNode.hasFocus && !_showUserList) {
        setState(() {
          _showUserList = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _messageInputFocusNode.dispose();
    _controller.clear();
    _controller.removeListener(_userNameListener);
    _controller.dispose();
    userListController.close();
    super.dispose();
  }

  Future<void> _loadChannel() async {
    if (_selectedUsers.isNotEmpty) {
      final chatState = Octopus.of(context);

      final res = await chatState.client.queryChannelsOnline(
        filter: Filter.in_(
          'members.userID',
          [
            ..._selectedUsers.map((e) => e.id),
            chatState.currentUser!.id,
          ],
        ),
        messageLimit: 0,
        paginationParams: const PaginationParams(
          limit: 1,
        ),
      );

      final _channelExisted = res.length == 1;
      if (_channelExisted) {
        channel = res.first;
        await channel!.watch();
      } else {
        channel = chatState.client.channel();
      }
      _messageInputFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = Octopus.of(context).client;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: "news_message".tr(),
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
      body: OctopusChannel(
        channel: channel!,
        child: Column(
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
                setState(() {
                  _selectedUsers.add(user);
                  _showUserList = false;
                  _loadChannel();
                });
              },
              onChipRemoved: (user) {
                setState(() {
                  _selectedUsers.remove(user);
                  if (_selectedUsers.isEmpty) {
                    _showUserList = true;
                  } else {
                    _loadChannel();
                  }
                });
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
                          'create_a_new_group'.tr(),
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
                    'suggested'.tr(),
                    style:
                        OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                  ),
                ),
              ),
            Expanded(
              child: _showUserList
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (_) => FocusScope.of(context).unfocus(),
                      child: UserListView(
                        controller: userListController,
                        // groupAlphabetically:
                        //     _isSearchActive ? false : true,
                        showOnlineStatus: true,
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
                    )
                  : FutureBuilder<bool>(
                      future: channel!.initialized,
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return const MessageListView();
                        }

                        return Center(
                          child: Text(
                            'No chats here yet',
                            style: TextStyle(
                              fontSize: 12,
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .primaryGrey
                                  .withOpacity(.5),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (!_showUserList)
              MessageInput(
                preMessageSending: (message) async {
                  final members =
                      _selectedUsers.map((member) => member.id).toList();
                  final newChannel =
                      await client.createChannel(members: members);
                  setState(() {
                    channel = newChannel;
                  });
                  await channel!.watch();
                  return message;
                },
                onMessageSent: (m) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.CHANNEL_PAGE,
                    ModalRoute.withName(Routes.CHANNEL_PAGE),
                    arguments: ChannelPageArgs(channel: channel),
                  );
                },
                focusNode: _messageInputFocusNode,
              ),
          ],
        ),
      ),
    );
  }
}
