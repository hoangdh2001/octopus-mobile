import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/workspace/workspace_page.dart';
import 'package:octopus/widgets/avatars/workspace_avatar.dart';
import 'package:octopus/widgets/options/options_list.dart';
import 'package:octopus/widgets/user_list/user_list_tile.dart';

class WorkspaceSetting extends StatefulWidget {
  const WorkspaceSetting({super.key, required this.workspace});

  final Workspace workspace;

  @override
  State<WorkspaceSetting> createState() => _WorkspaceSettingState();
}

class _WorkspaceSettingState extends State<WorkspaceSetting> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
        elevation: 0,
        leadingWidth: 0,
        leading: Container(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            child: const Text('Done'),
          )
        ],
      ),
      body: ListView(
        children: [
          _buildUserHeader(),
          _buildOptionListTiles(),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    final workspace = OctopusWorkspace.of(context).workspace;
    return Material(
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
            style: OctopusTheme.of(context).textTheme.primaryGreyH1,
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
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            child: const Text('Switch workspace'),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Widget _buildOptionListTiles() {
    return Column(
      children: [
        OptionListTile(
          title: 'Invite people to workspace',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgPicture.asset(
              'assets/icons/user_add.svg',
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
          onTap: () {},
        ),
        OptionListTile(
          title: 'Push notifications',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
          ),
          onTap: () {},
        ),
        OptionListTile(
          title: 'Share app with your team',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
          onTap: () {},
        ),
        OptionListTile(
          title: 'Settings',
          tileColor: OctopusTheme.of(context).colorTheme.contentView,
          titleTextStyle: OctopusTheme.of(context).textTheme.primaryGreyBody,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
          ),
          onTap: () {},
        ),
      ],
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


// Padding(
//             padding: const EdgeInsets.all(16),
//             child: BetterStreamBuilder(
//               stream: _workspace.state!.workspaceStateStream,
//               builder: (context, data) {
//                 _controller.text = data.name;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Workspace name',
//                         hintStyle: OctopusTheme.of(context).textTheme.hintLarge,
//                       ),
//                       style:
//                           OctopusTheme.of(context).textTheme.primaryGreyInput,
//                       cursorColor:
//                           OctopusTheme.of(context).colorTheme.brandPrimary,
//                       enableSuggestions: true,
//                       onChanged: (value) {},
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       'Members',
//                       style: OctopusTheme.of(context)
//                           .textTheme
//                           .primaryGreyBodyBold,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Column(
//                       children: List<Widget>.generate(
//                         data.members?.length ?? 0,
//                         (index) {
//                           return UserListTile(
//                             visualDensity: VisualDensity.compact,
//                             user: data.members![index].user,
//                             subtitle: Text(data.members![index].user.email),
//                             showSubtitle: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8)),
//                               side: BorderSide(
//                                   width: 1,
//                                   color: OctopusTheme.of(context)
//                                       .colorTheme
//                                       .border),
//                             ),
//                           );
//                         },
//                       ).insertBetween(
//                         SizedBox(
//                           height: 8.h,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     SizedBox(
//                       height: 50,
//                       child: TextButton.icon(
//                         style: OctopusTheme.of(context).buttonTheme.greyButton,
//                         onPressed: () {
//                           showNewWorkspaceDialog();
//                         },
//                         icon: SvgPicture.asset('assets/icons/plus.svg'),
//                         label: const Text('Add members'),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),