import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/assign_user/assign_user_page.dart';
import 'package:octopus/pages/choose_status/choose_status_page.dart';
import 'package:octopus/pages/date_picker/date_picker_page.dart';
import 'package:octopus/pages/new_task/bloc/new_task_bloc.dart';
import 'package:octopus/widgets/avatars/space_avatar.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';
import 'package:octopus/widgets/custom_expansion_tile/expansion_tile.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final workspace = OctopusWorkspace.of(context).workspace;
    final bloc = NewTaskBloc(workspace);
    return BlocProvider(
      create: (context) => bloc,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20).r,
          color: OctopusTheme.of(context).colorTheme.contentView,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/icons/close.svg',
                      color: OctopusTheme.of(context).colorTheme.icon),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Task name',
                hintStyle: OctopusTheme.of(context).textTheme.hintLarge,
              ),
              autofocus: true,
              style: OctopusTheme.of(context).textTheme.primaryGreyInput,
              cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              enableSuggestions: true,
              onChanged: (value) {
                bloc.add(NameChanged(value));
              },
            ),
            BlocConsumer<NewTaskBloc, NewTaskState>(
              listener: (context, state) {
                state.successOrFail.fold(() => null, (a) {
                  a.fold(
                    (l) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    (r) {
                      Navigator.pop(context);
                      // ignore: unused_result
                      showOkAlertDialog(context: context, title: r);
                    },
                  );
                });
              },
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      style: OctopusTheme.of(context)
                          .buttonTheme
                          .buttonPrimaryGreyBorder,
                      onPressed: () {
                        showPickLocationModal(bloc);
                      },
                      child: Text(
                        state.space == null
                            ? 'Choose list'
                            : 'In ${state.space!.name}',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(
                      width: (state.assignees?.length ?? 0) * 25 + 10,
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.centerRight,
                        children: List.generate(
                          (state.assignees?.length ?? 0) + 1,
                          (index) {
                            Widget child;
                            if (index == 0) {
                              child = InkWell(
                                onTap: () {
                                  showBarModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20).r,
                                    ),
                                    builder: (context) => AssignUserPage(
                                      onDoneTap: (users) {
                                        bloc.add(
                                          AssigneesChanged(users),
                                        );
                                      },
                                      users: state.assignees ?? [],
                                    ),
                                  );
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    DottedBorder(
                                      borderType: BorderType.Circle,
                                      color: OctopusTheme.of(context)
                                          .colorTheme
                                          .border,
                                      radius: const Radius.circular(12),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                            'assets/icons/user.svg'),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -3,
                                      right: -3,
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: OctopusTheme.of(context)
                                              .colorTheme
                                              .mediumGrey,
                                        ),
                                        child: SvgPicture.asset(
                                            'assets/icons/plus.svg'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final user = state.assignees![index - 1];
                              child = UserAvatar(
                                user: user,
                                showOnlineStatus: false,
                              );
                            }

                            return Positioned(
                              left: index * -25,
                              child: child,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SvgPicture.asset('assets/icons/double_square.svg',
                      color: OctopusTheme.of(context).colorTheme.icon),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      useSafeArea: true,
                      builder: (context) => Dialog(
                        backgroundColor:
                            OctopusTheme.of(context).colorTheme.contentView,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        insetPadding: const EdgeInsets.all(16),
                        clipBehavior: Clip.antiAlias,
                        child: ChooseStatusPage(
                          statuses: bloc.state.space?.setting.statuses ??
                              TaskStatus.defaultStatusList(),
                          onStatusSelected: (statusTask) {
                            bloc.add(StatusChanged(statusTask));
                          },
                        ),
                      ),
                    );
                  },
                  child: BlocBuilder<NewTaskBloc, NewTaskState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor.fromHex(state.taskStatus.color),
                        ),
                        child: Center(
                          child: Text(
                            state.taskStatus.name ?? 'No status',
                            style: theme.textTheme.primaryGreyBodyBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Description',
                hintStyle: OctopusTheme.of(context).textTheme.hint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    'assets/icons/description.svg',
                    color: OctopusTheme.of(context).colorTheme.icon,
                  ),
                ),
              ),
              autofocus: true,
              style: OctopusTheme.of(context).textTheme.primaryGreyInput,
              cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              enableSuggestions: true,
              onChanged: (value) {
                bloc.add(DescriptionChanged(value));
              },
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (context) => Dialog(
                    backgroundColor:
                        OctopusTheme.of(context).colorTheme.contentView,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: DatePickerPage(
                      onDone: (startDate, dueDate) {
                        bloc.add(StartDateChanged(startDate));
                        bloc.add(DueDateChanged(dueDate));
                      },
                    ),
                  ),
                );
              },
              child: BlocBuilder<NewTaskBloc, NewTaskState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SvgPicture.asset(
                            'assets/icons/calendar_plus.svg',
                            color: OctopusTheme.of(context).colorTheme.icon),
                      ),
                      Text(
                        state.startDate != null || state.dueDate != null
                            ? '${DateFormat('dd MMMM').format(state.startDate!)}${state.dueDate != null ? ' - ${DateFormat('dd MMMM').format(state.dueDate!)}' : ''}'
                            : 'Add Dates',
                        style: theme.textTheme.primaryGreyBody,
                      ),
                    ],
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Subtask',
                hintStyle: OctopusTheme.of(context).textTheme.hint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    'assets/icons/plus.svg',
                    color: OctopusTheme.of(context).colorTheme.icon,
                  ),
                ),
              ),
              autofocus: true,
              style: OctopusTheme.of(context).textTheme.primaryGreyInput,
              cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
              enableSuggestions: true,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
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
                BlocBuilder<NewTaskBloc, NewTaskState>(
                  builder: (context, state) {
                    return TextButton(
                      style: OctopusTheme.of(context)
                          .buttonTheme
                          .brandPrimaryButton,
                      onPressed: state.name.isEmpty ||
                              state.space == null ||
                              state.project == null
                          ? null
                          : () {
                              Octopus.of(context).showLoadingOverlay(context);
                              bloc.add(const Submitted());
                            },
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showPickLocationModal(NewTaskBloc bloc) {
    final theme = OctopusTheme.of(context);
    final workspace = OctopusWorkspace.of(context).workspace;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      barrierColor: Colors.black87,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20).r,
            ),
            color: OctopusTheme.of(context).colorTheme.contentView,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
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
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BetterStreamBuilder(
                    stream: workspace.state!.projectsMapStream,
                    builder: (context, data) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final project = data[index];
                          return ExpansionTile(
                            title: Row(
                              children: [
                                SpaceAvatar(
                                  name: project.state!.projectState.name,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Text(
                                    project.state!.projectState.name,
                                    style: theme.textTheme.primaryGreyBody,
                                  ),
                                ),
                              ],
                            ),
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 8).r,
                            trailing: (context, animation) {
                              return RotationTransition(
                                turns: animation.drive(
                                  Tween<double>(begin: 0.0, end: 0.37).chain(
                                    CurveTween(curve: Curves.easeOut),
                                  ),
                                ),
                                child: SizedBox(
                                  height: double.infinity,
                                  child: SvgPicture.asset(
                                    'assets/icons/arrow_right.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              );
                            },
                            children: project.state!.spacesState != null
                                ? List.generate(
                                    project.state!.spacesState.length, (index) {
                                    final space =
                                        project.state!.spacesState[index];
                                    return ListTile(
                                      leading: SizedBox(
                                        height: double.infinity,
                                        child: SvgPicture.asset(
                                          'assets/icons/dot.svg',
                                          color: OctopusTheme.of(context)
                                              .colorTheme
                                              .icon,
                                        ),
                                      ),
                                      onTap: () {
                                        bloc.add(SelectList(project, space));
                                        Navigator.pop(context);
                                      },
                                      horizontalTitleGap: 0,
                                      contentPadding:
                                          const EdgeInsets.only(left: 50).r,
                                      title: Text(
                                        space.name,
                                        style: OctopusTheme.of(context)
                                            .textTheme
                                            .primaryGreyBody,
                                      ),
                                    );
                                  })
                                : [],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
