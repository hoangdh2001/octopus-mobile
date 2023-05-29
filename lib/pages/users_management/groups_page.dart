import 'package:flutter/material.dart' hide BackButton;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
              Text(
                "Groups",
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final group =
                workspace.state!.workspaceState.workspaceGroups![index];
            return ListTile(
              title: group.name != null
                  ? Text(group.name!)
                  : const Text('Unnamed group'),
              subtitle: group.description != null
                  ? Text(group.description!)
                  : const Text('No description'),
              contentPadding: EdgeInsets.zero,
            );
          },
          itemCount:
              workspace.state!.workspaceState.workspaceGroups?.length ?? 0,
        )
      ],
    );
  }
}
