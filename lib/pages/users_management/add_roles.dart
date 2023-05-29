import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/chips_dropdown_textfield.dart';
import 'package:octopus/widgets/user_list/user_list_tile.dart';

class AddRoles extends StatefulWidget {
  const AddRoles({super.key});

  @override
  State<AddRoles> createState() => _AddRolesState();
}

class _AddRolesState extends State<AddRoles> {
  late TextEditingController _controller;

  late TextEditingController _teamController;

  late TextEditingController? _chipController;

  final _chipsFocusNode = FocusNode();

  final _selectedUsers = <WorkspaceMember>{};

  final _chipInputTextFieldStateKey =
      GlobalKey<ChipDropDownTextFieldState<WorkspaceState>>();

  ChipDropDownTextFieldState? get _chipInputTextFieldState =>
      _chipInputTextFieldStateKey.currentState;
  @override
  void initState() {
    _controller = TextEditingController();
    _teamController = TextEditingController();
    _chipController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
              Text(
                'Role name',
                style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
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
            ],
          ),
        ),
      ),
    );
  }
}
