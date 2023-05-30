import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/chips_dropdown_textfield.dart';
import 'package:octopus/widgets/user_list/user_list_tile.dart';

class AddGroups extends StatefulWidget {
  const AddGroups({super.key});

  @override
  State<AddGroups> createState() => _AddGroupsState();
}

class _AddGroupsState extends State<AddGroups> {
  late TextEditingController _controller;

  late TextEditingController _descriptionController;

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
    _descriptionController = TextEditingController();
    _chipController = TextEditingController();
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
          "Add groups",
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        centerTitle: true,
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.rich(
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                  const TextSpan(
                    children: [
                      TextSpan(text: "Name group"),
                      TextSpan(
                          text: " (*)", style: TextStyle(color: Colors.red))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter name group',
                      hintStyle: OctopusTheme.of(context).textTheme.hint,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color:
                              OctopusTheme.of(context).colorTheme.brandPrimary,
                        ),
                      ),
                    ),
                    autofocus: true,
                    cursorColor:
                        OctopusTheme.of(context).colorTheme.brandPrimary,
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
                  "You cannot change this content later.",
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Add members',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
                const SizedBox(height: 10),
                LayoutBuilder(builder: (context, constraints) {
                  return ChipsDropdownTextField<WorkspaceMember>(
                    key: _chipInputTextFieldStateKey,
                    focusNode: _chipsFocusNode,
                    chipBuilder: (context, member) {
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
                                  member.user.name,
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
                                hoverColor: OctopusTheme.of(context)
                                    .colorTheme
                                    .lightGrey,
                                onPressed: () {
                                  _chipInputTextFieldState?.removeItem(member);
                                  _chipsFocusNode.requestFocus();
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/close.svg',
                                  color:
                                      OctopusTheme.of(context).colorTheme.icon,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    controller: _chipController,
                    items: workspace.state!.workspaceState.members ??
                        <WorkspaceMember>[],
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return workspace.state!.workspaceState.members ??
                            <WorkspaceMember>[];
                      } else {
                        List<WorkspaceMember> matches = <WorkspaceMember>[];
                        matches.addAll(workspace.state!.workspaceState.members
                                ?.where((member) => member.user.name
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase())) ??
                            <WorkspaceMember>[]);

                        return matches;
                      }
                    },
                    displayStringForOption: (option) => option.user.name,
                    optionsViewBuilder: (BuildContext context,
                        void Function(WorkspaceMember) onSelected,
                        Iterable<WorkspaceMember> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color:
                              OctopusTheme.of(context).colorTheme.contentView,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 2,
                              color: OctopusTheme.of(context).colorTheme.border,
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: constraints.biggest.width,
                              height: 200.h,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: false,
                              itemBuilder: (BuildContext context, int index) {
                                final WorkspaceMember option =
                                    options.elementAt(index);
                                return UserListTile(
                                  tileColor: OctopusTheme.of(context)
                                      .colorTheme
                                      .contentView,
                                  showSubtitle: true,
                                  user: option.user,
                                  subtitle: Text(option.user.email),
                                  onTap: () {
                                    onSelected(option);
                                  },
                                );
                              },
                              itemCount: options.length,
                            ),
                          ),
                        ),
                      );
                    },
                    onChipAdded: (user) {
                      setState(() {
                        _chipController?.clear();
                        _selectedUsers.add(user);
                      });
                    },
                    onChipRemoved: (user) {
                      setState(() {
                        _selectedUsers.remove(user);
                      });
                    },
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
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
                          color:
                              OctopusTheme.of(context).colorTheme.brandPrimary,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    autofocus: true,
                    cursorColor:
                        OctopusTheme.of(context).colorTheme.brandPrimary,
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
                    onPressed: () async {
                      Octopus.of(context).showLoadingOverlay(context);
                      await workspace.addGroup(
                        _controller.text,
                        description: _descriptionController.text,
                        members: _selectedUsers
                            .map((member) => member.user.id)
                            .toList(),
                      );
                      Fluttertoast.showToast(
                          msg: "Add group successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Add group'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
