import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:collection/collection.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  late TextEditingController _emailController;

  late TextEditingController _controller;

  late TextEditingController _teamController;

  Workspace get workspace => OctopusWorkspace.of(context).workspace;

  @override
  void initState() {
    _emailController = TextEditingController();
    _controller = TextEditingController(
        text: workspace.state!.workspaceState.workspaceRoles!
            .firstWhere((role) => role.name == 'Guest')
            .name);
    _teamController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _controller.dispose();
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workspace = OctopusWorkspace.of(context).workspace;
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          "Invite team",
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        centerTitle: true,
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                const TextSpan(
                  children: [
                    TextSpan(text: "Email address"),
                    TextSpan(text: " (*)", style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter email address to invite',
                    hintStyle: OctopusTheme.of(context).textTheme.hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: OctopusTheme.of(context).colorTheme.brandPrimary,
                      ),
                    ),
                  ),
                  autofocus: true,
                  cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                  enableSuggestions: true,
                  autocorrect: false,
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Role',
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                hintText: 'Select role',
                hintStyle: OctopusTheme.of(context).textTheme.hint,
                selectedStyle:
                    OctopusTheme.of(context).textTheme.primaryGreyBody,
                listItemStyle:
                    OctopusTheme.of(context).textTheme.primaryGreyBody,
                items: workspace.state!.workspaceState.workspaceRoles
                        ?.map((role) => role.name)
                        .toList() ??
                    [],
                controller: _controller,
                borderSide: BorderSide(
                  width: 1,
                  color: OctopusTheme.of(context).colorTheme.border,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(
                height: 10,
              ),
              if (workspace.state!.workspaceState.workspaceGroups != null &&
                  workspace.state!.workspaceState.workspaceGroups!.isNotEmpty)
                Text(
                  'Team',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
              if (workspace.state!.workspaceState.workspaceGroups != null &&
                  workspace.state!.workspaceState.workspaceGroups!.isNotEmpty)
                const SizedBox(height: 10),
              if (workspace.state!.workspaceState.workspaceGroups != null &&
                  workspace.state!.workspaceState.workspaceGroups!.isNotEmpty)
                CustomDropdown(
                  hintText: 'Select team',
                  hintStyle: OctopusTheme.of(context).textTheme.hint,
                  selectedStyle:
                      OctopusTheme.of(context).textTheme.primaryGreyBody,
                  listItemStyle:
                      OctopusTheme.of(context).textTheme.primaryGreyBody,
                  items: workspace.state!.workspaceState.workspaceGroups
                          ?.map((group) => group.name ?? 'Unnamed')
                          .toList() ??
                      [],
                  controller: _teamController,
                  borderSide: BorderSide(
                    width: 1,
                    color: OctopusTheme.of(context).colorTheme.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              Container(
                height: 40.h,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                  onPressed: () async {
                    Octopus.of(context).showLoadingOverlay(context);
                    final team = workspace.state!.workspaceState.workspaceGroups
                        ?.firstWhereOrNull(
                            (group) => group.name == _teamController.text);
                    final role = workspace.state!.workspaceState.workspaceRoles!
                        .firstWhere((role) => role.name == _controller.text);
                    await workspace.addMember(
                        _emailController.text, role, team);
                    Fluttertoast.showToast(
                        msg: "Invite email successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Invite email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
