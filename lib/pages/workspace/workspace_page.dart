import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/utils/constants.dart';
import 'package:octopus/widgets/workspace_list/workspace_list.dart';
import 'package:octopus/widgets/workspace_list/workspace_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage(
      {super.key, required this.client, this.onCreateWorkspaceTap});

  final Function? onCreateWorkspaceTap;

  final Client client;

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  late WorkspaceListBloc controller = WorkspaceListBloc(
    client: widget.client,
    filter: Filter.join(
      'members',
      Filter.equal(
        'memberID',
        widget.client.state.currentUser!.id,
        fieldType: FieldType.STRING,
        type: FilterType.SQL,
      ),
      type: FilterType.SQL,
    ),
    limit: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20).r,
            ),
            color: OctopusTheme.of(context).colorTheme.contentView,
            child: Container(
              width: 0.9.sw,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Workspace',
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBodyBold,
                          ),
                          TextSpan(
                            text: ' (1)',
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody
                                .copyWith(
                                  color: OctopusTheme.of(context)
                                      .colorTheme
                                      .primaryGrey
                                      .withOpacity(.5),
                                ),
                          ),
                        ]),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: OctopusTheme.of(context)
                            .textTheme
                            .primaryGreyBodyBold,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/icons/close.svg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  WorkspaceList(
                    controller: controller,
                    onWorkspaceTap: (workspace) {
                      widget.client.state.currentWorkspace = workspace;
                      getIt<SharedPreferences>().setString(
                          workspaceLocal,
                          jsonEncode(widget.client.state.currentWorkspace?.state
                              ?.workspaceState));
                      Navigator.pop(context);
                    },
                    itemBuilder: (context, items, index, defaultWidget) {
                      return BetterStreamBuilder(
                        stream: widget.client.state.currentWorkspaceStream,
                        builder: (context, data) {
                          final isSelect = items[index].id == data.id;

                          return defaultWidget.copyWith(
                            showSelectWidget: true,
                            selected: isSelect,
                          );
                        },
                        noDataBuilder: (context) {
                          return defaultWidget.copyWith(
                            showSelectWidget: true,
                          );
                        },
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      widget.onCreateWorkspaceTap?.call();
                    },
                    child: Container(
                      height: 42.h,
                      margin: const EdgeInsets.symmetric(vertical: 5).h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OctopusTheme.of(context)
                            .colorTheme
                            .cardBackgroundSecondary,
                      ),
                      padding: const EdgeInsets.all(6).r,
                      child: Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints.tightFor(
                              width: 35,
                              height: 35,
                            ),
                            padding: const EdgeInsets.all(6).r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: OctopusTheme.of(context)
                                    .colorTheme
                                    .brandPrimary
                                    .withOpacity(.5),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/plus.svg',
                              color: OctopusTheme.of(context)
                                  .colorTheme
                                  .brandPrimary,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "New workspace",
                            style: OctopusTheme.of(context)
                                .textTheme
                                .brandPrimaryBodyBold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                'New workspace',
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name your Workspace',
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
                      onPressed: () {},
                      child: Text(
                        'Create',
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
