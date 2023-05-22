import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel_file_display_screen.dart';
import 'package:octopus/pages/channel_media_display_screen.dart';
import 'package:octopus/pages/pinned_messages_page.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/options/options_list.dart';

/// Detail screen for a 1:1 chat correspondence
class ChannelInfoPage extends StatefulWidget {
  /// User in consideration
  final User? user;

  final OCMessageThemeData messageTheme;

  const ChannelInfoPage({
    Key? key,
    required this.messageTheme,
    this.user,
  }) : super(key: key);

  @override
  _ChannelInfoPageState createState() => _ChannelInfoPageState();
}

class _ChannelInfoPageState extends State<ChannelInfoPage> {
  ValueNotifier<bool?> mutedBool = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    mutedBool =
        ValueNotifier(OctopusChannel.of(context).channel.isActiveNotify);
  }

  @override
  Widget build(BuildContext context) {
    final channel = OctopusChannel.of(context).channel;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      body: ListView(
        children: [
          _buildUserHeader(),
          Container(
            height: 8.0,
            color: OctopusTheme.of(context).colorTheme.disabled,
          ),
          _buildOptionListTiles(),
          Container(
            height: 8.0,
            color: OctopusTheme.of(context).colorTheme.disabled,
          ),
          // if (channel.ownCapabilities.contains(PermissionType.deleteChannel))
          _buildDeleteListTile(),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Material(
      color: OctopusTheme.of(context).colorTheme.contentView,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: UserAvatar(
                    user: widget.user!,
                    constraints: const BoxConstraints.tightFor(
                      width: 72.0,
                      height: 72.0,
                    ),
                    borderRadius: BorderRadius.circular(36.0),
                    showOnlineStatus: false,
                  ),
                ),
                Text(
                  widget.user!.name,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7.0),
                _buildConnectedTitleState(),
                const SizedBox(height: 15.0),
                OptionListTile(
                  title: '@${widget.user!.id}',
                  tileColor: OctopusTheme.of(context).colorTheme.contentView,
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.user!.name,
                      style: TextStyle(
                          color: OctopusTheme.of(context)
                              .colorTheme
                              .primaryGrey
                              .withOpacity(0.5),
                          fontSize: 16.0),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const Positioned(
              top: 0,
              left: 0,
              width: 58,
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionListTiles() {
    var channel = OctopusChannel.of(context);

    return Column(
      children: [
        // _OptionListTile(
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
        StreamBuilder<bool>(
            stream: OctopusChannel.of(context).channel.isActiveNotifyStream,
            builder: (context, snapshot) {
              mutedBool.value = snapshot.data;

              return OptionListTile(
                tileColor: OctopusTheme.of(context).colorTheme.contentView,
                title: 'Mute user',
                titleTextStyle:
                    OctopusTheme.of(context).textTheme.primaryGreyBody,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
                                channel.channel.unmute();
                              } else {
                                channel.channel.mute();
                              }
                            },
                          );
                        }),
                onTap: () {},
              );
            }),
        // _OptionListTile(
        //   title: 'Block User',
        //   leading: StreamSvgIcon.Icon_user_delete(
        //     size: 24.0,
        //     color: StreamChatTheme.of(context).colorTheme.textHighEmphasis.withOpacity(0.5),
        //   ),
        //   trailing: CupertinoSwitch(
        //     value: widget.user.banned,
        //     onChanged: (val) {
        //       if (widget.user.banned) {
        //         channel.channel.shadowBan(widget.user.id, {});
        //       } else {
        //         channel.channel.unbanUser(widget.user.id);
        //       }
        //     },
        //   ),
        //   onTap: () {},
        // ),
        OptionListTile(
          title: "Pinned messages",
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
          title: 'Photos & Videos',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              'assets/icons/pictures.svg',
              width: 36.0,
              height: 36.0,
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
          title: 'Files',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
            final channel = OctopusChannel.of(context).channel;

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
        OptionListTile(
          title: 'Share group',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: SvgPicture.asset(
              'assets/icons/share.svg',
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _SharedGroupsScreen(
                        Octopus.of(context).currentUser, widget.user)));
          },
        ),
      ],
    );
  }

  Widget _buildDeleteListTile() {
    return OptionListTile(
      title: 'Delete Conversation',
      tileColor: OctopusTheme.of(context).colorTheme.contentView,
      titleTextStyle:
          OctopusTheme.of(context).textTheme.primaryGreyBody.copyWith(
                color: OctopusTheme.of(context).colorTheme.error,
              ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SvgPicture.asset(
          'assets/icons/trash.svg',
          color: OctopusTheme.of(context).colorTheme.error,
          width: 24.0,
          height: 24.0,
        ),
      ),
      onTap: () {
        // _showDeleteDialog();
      },
      titleColor: OctopusTheme.of(context).colorTheme.error,
    );
  }

  // void _showDeleteDialog() async {
  //   final res = await showConfirmationDialog(
  //     context,
  //     title: AppLocalizations.of(context).deleteConversationTitle,
  //     okText: AppLocalizations.of(context).delete.toUpperCase(),
  //     question: AppLocalizations.of(context).deleteConversationAreYouSure,
  //     cancelText: AppLocalizations.of(context).cancel.toUpperCase(),
  //     icon: StreamSvgIcon.delete(
  //       color: StreamChatTheme.of(context).colorTheme.accentError,
  //     ),
  //   );
  //   var channel = StreamChannel.of(context).channel;
  //   if (res == true) {
  //     await channel.delete().then((value) {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //     });
  //   }
  // }

  Widget _buildConnectedTitleState() {
    var alternativeWidget;

    final otherMember = widget.user;

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.user!.active ?? false)
          Material(
            type: MaterialType.circle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              constraints: const BoxConstraints.tightFor(
                width: 24,
                height: 12,
              ),
              child: Material(
                shape: const CircleBorder(),
                color: OctopusTheme.of(context).colorTheme.accentInfo,
              ),
            ),
            color: OctopusTheme.of(context).colorTheme.contentView,
          ),
        alternativeWidget,
        if (widget.user!.active ?? false)
          const SizedBox(
            width: 24.0,
          ),
      ],
    );
  }
}

class _SharedGroupsScreen extends StatefulWidget {
  final User? mainUser;
  final User? otherUser;

  _SharedGroupsScreen(this.mainUser, this.otherUser);

  @override
  __SharedGroupsScreenState createState() => __SharedGroupsScreenState();
}

class __SharedGroupsScreenState extends State<_SharedGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    var chat = Octopus.of(context);

    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Share group',
          style: TextStyle(
              color: OctopusTheme.of(context).colorTheme.primaryGrey,
              fontSize: 16.0),
        ),
        leading: const BackButton(),
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: Container(),
      // StreamBuilder<List<Channel>>(
      //   stream: chat.client.queryChannels(
      //     filter: Filter.and([
      //       Filter.in_('members', [widget.otherUser!.id]),
      //       Filter.in_('members', [widget.mainUser!.id]),
      //     ]),
      //   ),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     if (snapshot.data!.isEmpty) {
      //       return Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             StreamSvgIcon.message(
      //               size: 136.0,
      //               color: StreamChatTheme.of(context).colorTheme.disabled,
      //             ),
      //             const SizedBox(height: 16.0),
      //             Text(
      //               AppLocalizations.of(context).noSharedGroups,
      //               style: TextStyle(
      //                 fontSize: 14.0,
      //                 color: StreamChatTheme.of(context)
      //                     .colorTheme
      //                     .textHighEmphasis,
      //               ),
      //             ),
      //             const SizedBox(height: 8.0),
      //             Text(
      //               AppLocalizations.of(context).groupSharedWithUserAppearHere,
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 14.0,
      //                 color: StreamChatTheme.of(context)
      //                     .colorTheme
      //                     .textHighEmphasis
      //                     .withOpacity(0.5),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }

      //     final channels = snapshot.data!
      //         .where((c) =>
      //             c.state!.members.any((m) =>
      //                 m.userId != widget.mainUser!.id &&
      //                 m.userId != widget.otherUser!.id) ||
      //             !c.isDistinct)
      //         .toList();

      //     return ListView.builder(
      //       itemCount: channels.length,
      //       itemBuilder: (context, position) {
      //         return StreamChannel(
      //           channel: channels[position],
      //           child: _buildListTile(channels[position]),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }

  // Widget _buildListTile(Channel channel) {
  //   var extraData = channel.extraData;
  //   var members = channel.state!.members;

  //   var textStyle =
  //       const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

  //   return Container(
  //     height: 64.0,
  //     child: LayoutBuilder(builder: (context, constraints) {
  //       String? title;
  //       if (extraData['name'] == null) {
  //         final otherMembers = members.where((member) =>
  //             member.userId != StreamChat.of(context).currentUser!.id);
  //         if (otherMembers.isNotEmpty) {
  //           final maxWidth = constraints.maxWidth;
  //           final maxChars = maxWidth / textStyle.fontSize!;
  //           var currentChars = 0;
  //           final currentMembers = <Member>[];
  //           otherMembers.forEach((element) {
  //             final newLength = currentChars + element.user!.name.length;
  //             if (newLength < maxChars) {
  //               currentChars = newLength;
  //               currentMembers.add(element);
  //             }
  //           });

  //           final exceedingMembers =
  //               otherMembers.length - currentMembers.length;
  //           title =
  //               '${currentMembers.map((e) => e.user!.name).join(', ')} ${exceedingMembers > 0 ? '+ $exceedingMembers' : ''}';
  //         } else {
  //           title = 'No title';
  //         }
  //       } else {
  //         title = extraData['name'] as String;
  //       }

  //       return Column(
  //         children: [
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: StreamChannelAvatar(
  //                     channel: channel,
  //                     constraints:
  //                         const BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
  //                   ),
  //                 ),
  //                 Expanded(
  //                     child: Text(
  //                   title,
  //                   style: textStyle,
  //                 )),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     '${channel.memberCount} ${AppLocalizations.of(context).members.toLowerCase()}',
  //                     style: TextStyle(
  //                         color: StreamChatTheme.of(context)
  //                             .colorTheme
  //                             .textHighEmphasis
  //                             .withOpacity(0.5)),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Container(
  //             height: 1.0,
  //             color: StreamChatTheme.of(context)
  //                 .colorTheme
  //                 .textHighEmphasis
  //                 .withOpacity(.08),
  //           ),
  //         ],
  //       );
  //     }),
  //   );
  // }
}
