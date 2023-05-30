import 'dart:convert';

import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/new_workspace/bloc/new_workspace_bloc.dart';
import 'package:octopus/utils/constants.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewWorkspacePageArgs {
  final bool showBack;

  NewWorkspacePageArgs({this.showBack = false});
}

class NewWorkspacePage extends StatefulWidget {
  const NewWorkspacePage({super.key, this.showBack = false});

  final bool showBack;

  @override
  State<NewWorkspacePage> createState() => _NewWorkspacePageState();
}

class _NewWorkspacePageState extends State<NewWorkspacePage> {
  @override
  Widget build(BuildContext context) {
    final client = Octopus.of(context).client;
    final bloc = NewWorkspaceBloc(client);
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: widget.showBack
            ? AppBar(
                backgroundColor:
                    OctopusTheme.of(context).colorTheme.contentView,
                leading: const BackButton(),
                elevation: 0,
                title: Text(
                  "Create Workspace",
                  style: OctopusTheme.of(context).textTheme.primaryGreyH1,
                ),
              )
            : null,
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
        body: SafeArea(
          child: Padding(
            padding: widget.showBack
                ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 0)
                : EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!widget.showBack)
                  Text(
                    "Create Workspace",
                    style: OctopusTheme.of(context).textTheme.primaryGreyH1,
                  ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Give a name to your workspace - that's where all the work happens!",
                  textAlign: TextAlign.center,
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workspace name',
                      style: OctopusTheme.of(context)
                          .textTheme
                          .secondaryGreyLabelSecondary,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Workspace name',
                          hintStyle: OctopusTheme.of(context).textTheme.hint,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .brandPrimary,
                            ),
                          ),
                        ),
                        cursorColor:
                            OctopusTheme.of(context).colorTheme.brandPrimary,
                        enableSuggestions: true,
                        autocorrect: false,
                        style:
                            OctopusTheme.of(context).textTheme.primaryGreyBody,
                        onChanged: (value) {
                          bloc.add(NameChanged(value));
                        },
                      ),
                    ),
                    BlocConsumer<NewWorkspaceBloc, NewWorkspaceState>(
                      bloc: bloc,
                      listener: (context, state) {
                        state.successOrFail.fold(
                          () {},
                          (workspace) {
                            client.state.currentWorkspace = workspace;
                            getIt<SharedPreferences>().setString(
                              workspaceLocal,
                              jsonEncode(client.state.currentWorkspace!.state!
                                  .workspaceState),
                            );
                            if (widget.showBack) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      builder: (context, state) {
                        return Container(
                          width: 0.9.sw,
                          height: 40.h,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: TextButton(
                            style: OctopusTheme.of(context)
                                .buttonTheme
                                .brandPrimaryButton,
                            onPressed: state.name.isEmpty
                                ? null
                                : () {
                                    bloc.add(const Submitted());
                                  },
                            child: const Text('Create Workspace'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
