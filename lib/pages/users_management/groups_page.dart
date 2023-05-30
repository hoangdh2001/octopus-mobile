import 'package:flutter/material.dart' hide BackButton;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/models/group.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/users_management/add_groups.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          "Groups",
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        centerTitle: true,
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: SingleChildScrollView(
        controller: ModalScrollController.of(context),
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Groups",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Groups are a way to organize your team members. You can use groups to assign roles and permissions to multiple people at once.",
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
              ),
              _buildMembers(),
              const Text(
                "Create a group",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  "You can create a group by clicking the button below. Once you create a group, you can add members to it and assign roles and permissions to the group.",
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const AddGroups();
                      });
                },
                style: OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                child: const Text('Create a group'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembers() {
    final workspace = OctopusWorkspace.of(context).workspace;

    final members =
        workspace.state!.workspaceState.workspaceGroups?.map((group) {
      final count = workspace.state!.workspaceState.members!
          .where((member) =>
              member.groups?.map((e) => e.id).contains(group.id) ?? false)
          .length;

      return Group(
        workspaceGroup: group,
        memberCount: count,
      );
    }).toList();

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 0.5,
            color: Color(0xFFE5E5E5),
          ),
          itemBuilder: (context, index) {
            final group = members![index];
            return ListTile(
              title: group.workspaceGroup!.name != null
                  ? Text(group.workspaceGroup!.name!)
                  : const Text('Unnamed group'),
              subtitle: group.workspaceGroup!.description != null
                  ? Text(group.workspaceGroup!.description!)
                  : const Text('No description'),
              contentPadding: EdgeInsets.zero,
              dense: false,
              visualDensity: VisualDensity.compact,
              trailing: Text('${group.memberCount} members',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody),
            );
          },
          itemCount: members?.length ?? 0,
        )
      ],
    );
  }
}
