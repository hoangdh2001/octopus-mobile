import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

class AddRoles extends StatefulWidget {
  const AddRoles({super.key});

  @override
  State<AddRoles> createState() => _AddRolesState();
}

class _AddRolesState extends State<AddRoles> {
  late TextEditingController _controller;

  late TextEditingController _descriptionController;

  bool admintrator = false;

  List<WorkspaceOwnCapability> ownCapabilities = [];

  @override
  void initState() {
    _controller = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
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
          "Add Roles",
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
                    TextSpan(text: "Role name"),
                    TextSpan(text: " (*)", style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter role name',
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
                'Role settings',
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              CheckboxListTile(
                value: ownCapabilities
                    .contains(WorkspaceOwnCapability.allCapabilities),
                onChanged: (value) {
                  setState(() {
                    if (value ?? false) {
                      ownCapabilities
                          .add(WorkspaceOwnCapability.allCapabilities);
                    } else {
                      ownCapabilities
                          .remove(WorkspaceOwnCapability.allCapabilities);
                      ownCapabilities
                          .remove(WorkspaceOwnCapability.createProject);
                      ownCapabilities.remove(WorkspaceOwnCapability.addMember);
                    }
                  });
                },
                title: Text('Admintrator',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              if (!ownCapabilities
                  .contains(WorkspaceOwnCapability.allCapabilities))
                CheckboxListTile(
                  value: ownCapabilities
                      .contains(WorkspaceOwnCapability.createProject),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        ownCapabilities
                            .add(WorkspaceOwnCapability.createProject);
                      } else {
                        ownCapabilities
                            .remove(WorkspaceOwnCapability.createProject);
                      }
                    });
                  },
                  title: Text('Can create project',
                      style:
                          OctopusTheme.of(context).textTheme.primaryGreyBody),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                ),
              if (!ownCapabilities
                  .contains(WorkspaceOwnCapability.allCapabilities))
                CheckboxListTile(
                  value: ownCapabilities
                      .contains(WorkspaceOwnCapability.addMember),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        ownCapabilities.add(WorkspaceOwnCapability.addMember);
                      } else {
                        ownCapabilities
                            .remove(WorkspaceOwnCapability.addMember);
                      }
                    });
                  },
                  title: Text('Can add member',
                      style:
                          OctopusTheme.of(context).textTheme.primaryGreyBody),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                ),
              Text(
                'Channel settings',
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text('Can send message',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text('Can send photo, video, file, voice message',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text('Can add member',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text('Can delete messages',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: Text('Can pin messages',
                    style: OctopusTheme.of(context).textTheme.primaryGreyBody),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description will appear in group list',
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
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
              Container(
                height: 40.h,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                  onPressed: () {
                    Octopus.of(context).showLoadingOverlay(context);
                    workspace
                        .addRole(_controller.text,
                            description: _descriptionController.text,
                            capabilities: ownCapabilities)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Invite email successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Add role'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
