import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/users_management/add_roles.dart';
import 'package:octopus/pages/users_management/groups_page.dart';
import 'package:octopus/pages/users_management/add_members.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/options/options_list.dart';

class UsersManagementPage extends StatefulWidget {
  const UsersManagementPage({super.key});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage> {
  Workspace get workspace => OctopusWorkspace.of(context).workspace;

  bool listExpanded = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WorkspaceState>(
        stream: workspace.state!.workspaceStateStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: OctopusTheme.of(context).colorTheme.disabled,
              child: Center(
                  child: _getIndicatorWidget(Theme.of(context).platform)),
            );
          }

          return Scaffold(
            backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
            appBar: AppBar(
              elevation: 0,
              leading: const BackButton(),
              title: Text(
                "workspace_setting_page.users_management".tr(),
                style: OctopusTheme.of(context).textTheme.navigationTitle,
              ),
              centerTitle: true,
              backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
            ),
            body: ListView(
              controller: ModalScrollController.of(context),
              physics: const ClampingScrollPhysics(),
              children: [
                _buildMembers(workspace.state!.workspaceState.members ??
                    <WorkspaceMember>[]),
                Container(
                  height: 8.0,
                  color: OctopusTheme.of(context).colorTheme.disabled,
                ),
                OptionListTile(
                  title: 'workspace_setting_page.invite_members'.tr(),
                  leading: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      'assets/icons/user_add.svg',
                      width: 24,
                      height: 24,
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
                        builder: (context) {
                          return const AddMembers();
                        },
                      ),
                    );
                  },
                ),
                OptionListTile(
                  title: 'workspace_setting_page.groups'.tr(),
                  leading: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      'assets/icons/users_group.svg',
                      width: 24,
                      height: 24,
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
                      MaterialWithModalsPageRoute(
                        builder: (context) {
                          return const GroupsPage();
                        },
                      ),
                    );
                  },
                ),
                OptionListTile(
                  title: 'workspace_setting_page.roles'.tr(),
                  leading: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      'assets/icons/roles.svg',
                      width: 24,
                      height: 24,
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
                        builder: (context) {
                          return const AddRoles();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildMembers(List<WorkspaceMember> members) {
    final groupMembers = members
      ..sort((prev, curr) {
        if (curr.role!.ownCapabilities
                ?.contains(WorkspaceOwnCapability.allCapabilities) ??
            false) return 1;
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
                  // final userMember = groupMembers.firstWhereOrNull(
                  //   (e) => e.user!.id == Octopus.of(context).currentUser!.id,
                  // );
                  // _showUserInfoModal(
                  //     member.user, userMember?.userID == channel.createdBy?.id);
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
                              user: member.user,
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
                                  member.user.firstName != null &&
                                          member.user.lastName != null
                                      ? member.user.name
                                      : 'unnamed'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                Text(
                                  '${member.role!.name} (${member.user.email})',
                                  style: TextStyle(
                                    color: OctopusTheme.of(context)
                                        .colorTheme
                                        .primaryGrey
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/icons/more.svg'),
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
                                  'value_more'.tr(namedArgs: {
                                    'count':
                                        (members.length - groupMembersLength)
                                            .toString()
                                  }),
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

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
  }
}
