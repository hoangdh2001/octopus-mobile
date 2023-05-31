import 'package:easy_localization/easy_localization.dart';
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
          "workspace_setting_page.groups".tr(),
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
                "workspace_setting_page.groups".tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "workspace_setting_page.group_description".tr(),
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
              ),
              _buildMembers(),
              Text(
                "workspace_setting_page.create_group_label".tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("workspace_setting_page.create_group_description".tr(),
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
                child: Text('workspace_setting_page.create_group_button'.tr()),
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
                  : Text('unnamed_group'.tr()),
              subtitle: group.workspaceGroup!.description != null
                  ? Text(group.workspaceGroup!.description!)
                  : Text('no_description'.tr()),
              contentPadding: EdgeInsets.zero,
              dense: false,
              visualDensity: VisualDensity.compact,
              trailing: Text(
                  'value_members'
                      .tr(namedArgs: {'count': group.memberCount.toString()}),
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody),
            );
          },
          itemCount: members?.length ?? 0,
        )
      ],
    );
  }
}
