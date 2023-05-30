import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/enums/workspace_own_capability.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/users_management/users_management.dart';
import 'package:octopus/pages/workspace/workspace_page.dart';
import 'package:octopus/widgets/avatars/workspace_avatar.dart';
import 'package:octopus/widgets/options/options_list.dart';
import 'package:collection/collection.dart';

class WorkspaceSettingPage extends StatefulWidget {
  const WorkspaceSettingPage({super.key, required this.workspace});

  final Workspace workspace;

  @override
  State<WorkspaceSettingPage> createState() => _WorkspaceSettingPageState();
}

class _WorkspaceSettingPageState extends State<WorkspaceSettingPage> {
  Workspace get _workspace => widget.workspace;

  late TextEditingController _controller;

  late TextEditingController _emailController;

  @override
  void initState() {
    _controller = TextEditingController(text: _workspace.name);
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext rootContext) {
    final workspace = widget.workspace;
    return Material(
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                backgroundColor:
                    OctopusTheme.of(context).colorTheme.contentView,
                appBar: AppBar(
                  backgroundColor:
                      OctopusTheme.of(context).colorTheme.contentView,
                  elevation: 0,
                  leadingWidth: 0,
                  leading: Container(),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          rootContext,
                        );
                      },
                      style: OctopusTheme.of(context)
                          .buttonTheme
                          .buttonBrandPrimary,
                      child: const Text('Done'),
                    )
                  ],
                ),
                body: ListView(
                  children: [
                    Material(
                      color: OctopusTheme.of(context).colorTheme.contentView,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: WorkspaceAvatar(
                              name: workspace.name,
                              constraints: const BoxConstraints.tightFor(
                                width: 72.0,
                                height: 72.0,
                              ),
                              borderRadius: BorderRadius.circular(36.0),
                              showOnlineStatus: false,
                            ),
                          ),
                          Text(
                            workspace.name,
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyH1,
                          ),
                          const SizedBox(height: 7.0),
                          TextButton(
                            onPressed: () {
                              final client = Octopus.of(context).client;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return WorkspacePage(
                                    client: client,
                                    onCreateWorkspaceTap: () {},
                                  );
                                },
                              );
                            },
                            style: OctopusTheme.of(context)
                                .buttonTheme
                                .buttonBrandPrimary,
                            child: const Text('Switch workspace'),
                          ),
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        OptionListTile(
                          title: 'Users Management',
                          tileColor:
                              OctopusTheme.of(context).colorTheme.contentView,
                          titleTextStyle: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody,
                          leading: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: SvgPicture.asset(
                              'assets/icons/users.svg',
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
                            color:
                                OctopusTheme.of(context).colorTheme.primaryGrey,
                          ),
                          onTap: () {
                            final currentUser =
                                Octopus.of(context).client.state.currentUser;
                            final currentMember = _workspace
                                .state!.workspaceState.members
                                ?.firstWhereOrNull(
                              (member) => member.user.id == currentUser!.id,
                            );
                            if (currentMember!.role!.ownCapabilities!.contains(
                                WorkspaceOwnCapability.allCapabilities)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UsersManagementPage(),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "You don't have permission to access",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                        OptionListTile(
                          title: 'Push notifications',
                          tileColor:
                              OctopusTheme.of(context).colorTheme.contentView,
                          titleTextStyle: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody,
                          leading: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: SvgPicture.asset(
                              'assets/icons/notification.svg',
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
                            color:
                                OctopusTheme.of(context).colorTheme.primaryGrey,
                          ),
                          onTap: () {},
                        ),
                        OptionListTile(
                          title: 'Share app with your team',
                          tileColor:
                              OctopusTheme.of(context).colorTheme.contentView,
                          titleTextStyle: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody,
                          leading: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
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
                            color:
                                OctopusTheme.of(context).colorTheme.primaryGrey,
                          ),
                          onTap: () {},
                        ),
                        OptionListTile(
                          title: 'Settings',
                          tileColor:
                              OctopusTheme.of(context).colorTheme.contentView,
                          titleTextStyle: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody,
                          leading: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: SvgPicture.asset(
                              'assets/icons/settings.svg',
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
                            color:
                                OctopusTheme.of(context).colorTheme.primaryGrey,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showNewWorkspaceDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          width: 0.9.sw,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add member',
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _emailController,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email of member',
                  hintStyle: OctopusTheme.of(context).textTheme.hint,
                ),
                style: OctopusTheme.of(context).textTheme.primaryGreyInput,
                cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                enableSuggestions: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: OctopusTheme.of(context)
                          .buttonTheme
                          .buttonPrimaryGreyBorder,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextButton(
                      style: OctopusTheme.of(context)
                          .buttonTheme
                          .buttonPrimaryGreyBorder,
                      onPressed: () {
                        // _workspace.addMember(_emailController.text);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
