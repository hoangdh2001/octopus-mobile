import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/attachment_file.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/add_user_group_page.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/pages/channel_file_display_screen.dart';
import 'package:octopus/pages/channel_media_display_screen.dart';
import 'package:octopus/pages/pinned_messages_page.dart';
import 'package:octopus/utils.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/channel_preview/channel_avatar.dart';
import 'package:octopus/widgets/options/options_list.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';

class GroupInfoScreen extends StatefulWidget {
  final OCMessageThemeData messageTheme;

  const GroupInfoScreen({
    Key? key,
    required this.messageTheme,
  }) : super(key: key);

  @override
  _GroupInfoScreenState createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  TextEditingController? _nameController;

  TextEditingController? _searchController;
  String _userNameQuery = '';

  Timer? _debounce;
  Function? modalSetStateCallback;

  final FocusNode _focusNode = FocusNode();

  bool listExpanded = false;

  ValueNotifier<bool?> mutedBool = ValueNotifier(true);

  late final channel = OctopusChannel.of(context).channel;

  late UserListBloc userListController;

  final _imagePicker = ImagePicker();

  void _userNameListener() {
    if (_searchController!.text == _userNameQuery) {
      return;
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        _userNameQuery = _searchController!.text;
        // userListController.filter = Filter.and(
        //   [
        //     if (_searchController!.text.isNotEmpty)
        //       Filter.autoComplete('name', _userNameQuery),
        //     Filter.notIn('id', [
        //       StreamChat.of(context).currentUser!.id,
        //       ...channel.state!.members
        //           .map<String?>(((e) => e.userId))
        //           .whereType<String>(),
        //     ]),
        //   ],
        // );
        userListController.add(const DoInitialLoad());
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController.fromValue(
      TextEditingValue(text: (channel.name) ?? ''),
    );
    _searchController = TextEditingController()..addListener(_userNameListener);

    _nameController!.addListener(() {
      setState(() {});
    });
    mutedBool = ValueNotifier(channel.isActiveNotify);
  }

  @override
  void didChangeDependencies() {
    userListController = UserListBloc(
      client: Octopus.of(context).client,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    userListController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Member>>(
        stream: channel.state!.membersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: OctopusTheme.of(context).colorTheme.disabled,
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
            appBar: AppBar(
              elevation: 1.0,
              toolbarHeight: 56.0,
              backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
              leading: const BackButton(),
              title: Column(
                children: [
                  StreamBuilder<ChannelState>(
                      stream: channel.state?.channelStateStream,
                      builder: (context, state) {
                        if (!state.hasData) {
                          return Text(
                            'Loading...',
                            style: TextStyle(
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .primaryGrey,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }

                        return Text(
                          _getChannelName(
                            2 * MediaQuery.of(context).size.width / 3,
                            members: snapshot.data,
                            name: state.data!.channel!.name,
                            maxFontSize: 16.0,
                          )!,
                          style: TextStyle(
                            color:
                                OctopusTheme.of(context).colorTheme.primaryGrey,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    '${channel.memberCount} Members, ${snapshot.data?.where((e) => e.user!.active ?? false).length ?? 0} Online',
                    style: TextStyle(
                      color: OctopusTheme.of(context)
                          .colorTheme
                          .primaryGrey
                          .withOpacity(0.5),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OctopusChannel(
                          channel: channel,
                          child: const AddUserPage(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/user_add.svg',
                      width: 24,
                      height: 24,
                      color: OctopusTheme.of(context).colorTheme.primaryGrey,
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                _buildMembers(snapshot.data!),
                Container(
                  height: 8.0,
                  color: OctopusTheme.of(context).colorTheme.disabled,
                ),
                // if (channel.ownCapabilities
                //     .contains(PermissionType.updateChannel))
                _buildNameTile(),
                _buildOptionListTiles(),
              ],
            ),
          );
        });
  }

  Widget _buildMembers(List<Member> members) {
    final groupMembers = members
      ..sort((prev, curr) {
        if (curr.userID == channel.createdBy?.id) return 1;
        return 0;
      });

    int groupMembersLength;

    if (listExpanded) {
      groupMembersLength = groupMembers.length;
    } else {
      groupMembersLength = groupMembers.length > 6 ? 6 : groupMembers.length;
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: groupMembersLength,
          itemBuilder: (context, index) {
            final member = groupMembers[index];
            return Material(
              color: OctopusTheme.of(context).colorTheme.contentView,
              child: InkWell(
                onTap: () {
                  final userMember = groupMembers.firstWhereOrNull(
                    (e) => e.user!.id == Octopus.of(context).currentUser!.id,
                  );
                  _showUserInfoModal(
                      member.user, userMember?.userID == channel.createdBy?.id);
                },
                child: SizedBox(
                  height: 65.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 12.0,
                            ),
                            child: UserAvatar(
                              user: member.user!,
                              constraints: const BoxConstraints.tightFor(
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  member.user!.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                Text(
                                  _getLastSeen(member.user!),
                                  style: TextStyle(
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .primaryGrey
                                          .withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              member.userID == channel.createdBy?.id
                                  ? 'Owner'
                                  : '',
                              style: TextStyle(
                                  color: OctopusTheme.of(context)
                                      .colorTheme
                                      .primaryGrey
                                      .withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1.0,
                        color: OctopusTheme.of(context).colorTheme.disabled,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (groupMembersLength != groupMembers.length)
          InkWell(
            onTap: () {
              setState(() {
                listExpanded = true;
              });
            },
            child: Material(
              color: OctopusTheme.of(context).colorTheme.contentView,
              child: Container(
                height: 65.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 21.0, vertical: 12.0),
                            child: SvgPicture.asset(
                              'arrow_down.svg',
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .primaryGrey,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${members.length - groupMembersLength} more',
                                  style: TextStyle(
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .primaryGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: OctopusTheme.of(context).colorTheme.disabled,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNameTile() {
    var channelName = (channel.name) ?? '';

    return Material(
      color: OctopusTheme.of(context).colorTheme.contentView,
      child: Container(
        height: 56.0,
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'NAME',
                style: OctopusTheme.of(context)
                    .textTheme
                    .primaryGreyFootnote
                    .copyWith(
                        color: OctopusTheme.of(context)
                            .colorTheme
                            .primaryGrey
                            .withOpacity(0.5)),
              ),
            ),
            const SizedBox(
              width: 7.0,
            ),
            Expanded(
              child: TextField(
                // enabled: channel.ownCapabilities
                //     .contains(PermissionType.updateChannel),
                focusNode: _focusNode,
                controller: _nameController,
                cursorColor: OctopusTheme.of(context).colorTheme.primaryGrey,
                decoration: InputDecoration.collapsed(
                    hintText: 'Add a group name',
                    hintStyle: OctopusTheme.of(context)
                        .textTheme
                        .primaryGreyBodyBold
                        .copyWith(
                            color: OctopusTheme.of(context)
                                .colorTheme
                                .primaryGrey
                                .withOpacity(0.5))),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 0.82,
                ),
              ),
            ),
            if (channelName != _nameController!.text.trim())
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: SvgPicture.asset(
                      'assets/icons/close_sml.svg',
                      width: 24,
                    ),
                    onTap: () {
                      setState(() {
                        _nameController!.text = _getChannelName(
                          2 * MediaQuery.of(context).size.width / 3,
                          members: channel.state!.members,
                          name: channel.name,
                          maxFontSize: 16.0,
                        )!;
                        _focusNode.unfocus();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: InkWell(
                      child: SvgPicture.asset(
                        'assets/icons/check.svg',
                        color: OctopusTheme.of(context).colorTheme.brandPrimary,
                        width: 24.0,
                      ),
                      onTap: () async {
                        try {
                          await channel.update({
                            'name': _nameController!.text.trim(),
                          });
                          _focusNode.unfocus();
                        } catch (e) {
                          setState(() {
                            _nameController!.text = channelName;
                            _focusNode.unfocus();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionListTiles() {
    return Column(
      children: [
        // OptionListTile(
        //   title: 'Notifications',
        //   leading: StreamSvgIcon.Icon_notification(
        //     size: 24.0,
        //     color: StreamChatTheme.of(context).colorTheme.textHighEmphasis.withOpacity(0.5),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: true,
        //     onChanged: (val) {},
        //   ),
        //   onTap: () {},
        // ),
        // if (channel.ownCapabilities.contains(PermissionType.muteChannel))
        OptionListTile(
          title: 'Change Avatar',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ChannelAvatar(
              channel: channel,
              constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            ),
          ),
          onTap: () {
            showOptionDialog();
          },
        ),
        StreamBuilder<bool>(
            stream: channel.isActiveNotifyStream,
            builder: (context, snapshot) {
              mutedBool.value = snapshot.data;

              return OptionListTile(
                tileColor: OctopusTheme.of(context).colorTheme.contentView,
                separatorColor: OctopusTheme.of(context).colorTheme.disabled,
                title: 'Mute group',
                titleTextStyle:
                    OctopusTheme.of(context).textTheme.primaryGreyBody,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SvgPicture.asset(
                    'assets/icons/mute.svg',
                    width: 24.0,
                    height: 24.0,
                    color: OctopusTheme.of(context)
                        .colorTheme
                        .primaryGrey
                        .withOpacity(0.5),
                  ),
                ),
                trailing: snapshot.data == null
                    ? const CircularProgressIndicator()
                    : ValueListenableBuilder<bool?>(
                        valueListenable: mutedBool,
                        builder: (context, value, _) {
                          return CupertinoSwitch(
                            value: !value!,
                            onChanged: (val) {
                              mutedBool.value = !val;
                              if (snapshot.data!) {
                                channel.mute();
                              } else {
                                channel.unmute();
                              }
                            },
                          );
                        }),
                onTap: () {},
              );
            }),
        OptionListTile(
          title: 'Pinned Messages',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              'assets/icons/pin.svg',
              width: 24.0,
              height: 24.0,
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5),
            ),
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow_right.svg',
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
          ),
          onTap: () {
            final channel = OctopusChannel.of(context).channel;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OctopusChannel(
                  channel: channel,
                  child: const PinnedMessagesScreen(),
                ),
              ),
            );
          },
        ),
        OptionListTile(
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          separatorColor: OctopusTheme.of(context).colorTheme.disabled,
          title: 'Photos and videos',
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              'assets/icons/pictures.svg',
              width: 32.0,
              height: 32.0,
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5),
            ),
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow_right.svg',
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
          ),
          onTap: () {
            final channel = OctopusChannel.of(context).channel;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OctopusChannel(
                  channel: channel,
                  child: ChannelMediaDisplayScreen(
                    messageTheme: widget.messageTheme,
                  ),
                ),
              ),
            );
          },
        ),
        OptionListTile(
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          separatorColor: OctopusTheme.of(context).colorTheme.disabled,
          title: 'Files',
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              'assets/icons/files.svg',
              width: 32.0,
              height: 32.0,
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5),
            ),
          ),
          trailing: SvgPicture.asset(
            'assets/icons/arrow_right.svg',
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
          ),
          onTap: () {
            var channel = OctopusChannel.of(context).channel;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OctopusChannel(
                  channel: channel,
                  child: ChannelFileDisplayScreen(
                    messageTheme: widget.messageTheme,
                  ),
                ),
              ),
            );
          },
        ),
        // if (!channel.isDistinct &&
        //     channel.ownCapabilities.contains(PermissionType.leaveChannel))
        OptionListTile(
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          separatorColor: OctopusTheme.of(context).colorTheme.disabled,
          title: 'Leave group',
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              'assets/icons/user_deselect.svg',
              width: 24.0,
              height: 24.0,
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5),
            ),
          ),
          trailing: Container(
            height: 24.0,
            width: 24.0,
          ),
          onTap: () async {
            final res = await showConfirmationDialog(
              context,
              title: "Leave channel",
              okText: 'LEAVE',
              question:
                  'You will leave this group and will no longer receive messages. Are you sure?',
              cancelText: 'CANCEL',
              icon: SvgPicture.asset(
                'assets/icons/user_remove.svg',
                color: OctopusTheme.of(context).colorTheme.error,
              ),
            );
            if (res == true) {
              final channel = OctopusChannel.of(context).channel;
              final client = Octopus.of(context).client;
              await client.leaveChannel(
                  channel, Octopus.of(context).currentUser!.id);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  void _showUserInfoModal(User? user, bool isUserAdmin) {
    final color = OctopusTheme.of(context).colorTheme.contentView;

    showModalBottomSheet(
      useRootNavigator: false,
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      backgroundColor: color,
      builder: (context) {
        return SafeArea(
          child: OctopusChannel(
            channel: channel,
            child: Material(
              color: color,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  Center(
                    child: Text(
                      user!.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  _buildConnectedTitleState(user)!,
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: UserAvatar(
                        user: user,
                        constraints: const BoxConstraints.tightFor(
                          height: 64.0,
                          width: 64.0,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  if (Octopus.of(context).currentUser!.id != user.id)
                    _buildModalListTile(
                      context,
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        color: OctopusTheme.of(context).colorTheme.primaryGrey,
                        width: 24.0,
                        height: 24.0,
                      ),
                      'View Info',
                      () async {
                        var client = Octopus.of(context).client;

                        // var c = client.channel('messaging', extraData: {
                        //   'members': [
                        //     user.id,
                        //     StreamChat.of(context).currentUser!.id,
                        //   ],
                        // });

                        // await c.watch();

                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => StreamChannel(
                        //       channel: c,
                        //       child: ChatInfoScreen(
                        //         messageTheme: widget.messageTheme,
                        //         user: user,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  if (Octopus.of(context).currentUser!.id != user.id)
                    _buildModalListTile(
                      context,
                      SvgPicture.asset(
                        'assets/icons/message.svg',
                        color: OctopusTheme.of(context).colorTheme.primaryGrey,
                        width: 24.0,
                        height: 24.0,
                      ),
                      "Message",
                      () async {
                        var client = Octopus.of(context).client;

                        final newChannel =
                            await client.createChannel(members: [user.id]);

                        await newChannel.watch();

                        Navigator.pop(context);

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OctopusChannel(
                              channel: newChannel,
                              child: ChannelPage(),
                            ),
                          ),
                        );
                      },
                    ),
                  if (Octopus.of(context).currentUser!.id != user.id &&
                      isUserAdmin)
                    _buildModalListTile(
                        context,
                        SvgPicture.asset(
                          'assets/icons/user_remove.svg',
                          color: OctopusTheme.of(context).colorTheme.error,
                          width: 24.0,
                          height: 24.0,
                        ),
                        'Remove from group', () async {
                      final res = await showConfirmationDialog(
                        context,
                        title: 'Remove member',
                        okText: 'OK',
                        question:
                            'Are you sure you want to remove this member?',
                        cancelText: 'Cancel',
                      );

                      if (res == true) {
                        await channel.removeMember(user.id, 'remove');
                      }
                      Navigator.pop(context);
                    }, color: OctopusTheme.of(context).colorTheme.error),
                  _buildModalListTile(
                      context,
                      SvgPicture.asset(
                        'assets/icons/close_sml.svg',
                        color: OctopusTheme.of(context).colorTheme.primaryGrey,
                        width: 24.0,
                        height: 24.0,
                      ),
                      'Cancel', () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget? _buildConnectedTitleState(User? user) {
    var alternativeWidget;

    final otherMember = user;

    if (otherMember != null) {
      if (otherMember.active ?? false) {
        alternativeWidget = Text(
          'Online',
          style: TextStyle(
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5)),
        );
      } else {
        alternativeWidget = Text(
          'Last seen ${Jiffy(otherMember.lastActive).fromNow()}',
          style: TextStyle(
              color: OctopusTheme.of(context)
                  .colorTheme
                  .primaryGrey
                  .withOpacity(0.5)),
        );
      }
    }

    return alternativeWidget;
  }

  Widget _buildModalListTile(
      BuildContext context, Widget leading, String title, VoidCallback onTap,
      {Color? color}) {
    color ??= OctopusTheme.of(context).colorTheme.primaryGrey;

    return Material(
      color: OctopusTheme.of(context).colorTheme.contentView,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 1.0,
              color: OctopusTheme.of(context).colorTheme.disabled,
            ),
            Container(
              height: 64.0,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: leading,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showOptionDialog() {
    final platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  pickImageFromGallery();
                },
                child: const Text('Select photo from gallery'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  takePhoto();
                },
                child: const Text('Take photo'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ),
        );
        break;
      default:
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromGallery();
                },
                leading: const Icon(Icons.photo_library),
                title: const Text('Select photo from gallery'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  takePhoto();
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take photo'),
              ),
            ],
          ),
        );
    }
  }

  void pickImageFromGallery() async {
    XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
            showCancelConfirmationDialog: true,
            aspectRatioPickerButtonHidden: true,
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile == null) return;
      Octopus.of(context).showLoadingOverlay(context);
      final bytes = await croppedFile.readAsBytes();
      final attachmentFile = AttachmentFile(
        bytes: bytes,
        size: bytes.length,
        path: croppedFile.path,
      );

      await channel.changeAvatar(attachmentFile);
      Navigator.pop(context);
    }
  }

  void takePhoto() async {
    XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
            showCancelConfirmationDialog: true,
            aspectRatioPickerButtonHidden: true,
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile == null) return;
      Octopus.of(context).showLoadingOverlay(context);
      final bytes = await croppedFile.readAsBytes();
      final attachmentFile = AttachmentFile(
        bytes: bytes,
        size: bytes.length,
        path: croppedFile.path,
      );

      await channel.changeAvatar(attachmentFile);
      Navigator.pop(context);
    }
  }

  String? _getChannelName(
    double width, {
    List<Member>? members,
    required String? name,
    double? maxFontSize,
  }) {
    String? title;
    var client = Octopus.of(context);
    if (name == null) {
      final otherMembers =
          members!.where((member) => member.user!.id != client.currentUser!.id);
      if (otherMembers.isNotEmpty) {
        final maxWidth = width;
        final maxChars = maxWidth / maxFontSize!;
        var currentChars = 0;
        final currentMembers = <Member>[];
        otherMembers.forEach((element) {
          final newLength = currentChars + element.user!.name.length;
          if (newLength < maxChars) {
            currentChars = newLength;
            currentMembers.add(element);
          }
        });

        final exceedingMembers = otherMembers.length - currentMembers.length;
        title =
            '${currentMembers.map((e) => e.user!.name).join(', ')} ${exceedingMembers > 0 ? '+ $exceedingMembers' : ''}';
      } else {
        title = 'No title';
      }
    } else {
      title = name;
    }
    return title;
  }

  String _getLastSeen(User user) {
    if (user.active ?? false) {
      return 'Online';
    } else {
      return 'Last seen ${Jiffy(user.lastActive).fromNow()}';
    }
  }
}
