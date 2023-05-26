import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/create_project/bloc/create_project_bloc.dart';
import 'package:octopus/pages/statuses/statuses_page.dart';
import 'package:octopus/core/extensions/extension_color.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  bool? _showChannelSetting = false;
  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final workspace = OctopusWorkspace.of(context).workspace;
    final bloc = CreateProjectBloc(workspace);
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
          elevation: 0,
          leading: Center(
            child: TextButton(
              style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ),
          leadingWidth: 70,
          title: Text(
            'Create Project',
            style: OctopusTheme.of(context).textTheme.navigationTitle,
          ),
          actions: [
            BlocConsumer<CreateProjectBloc, CreateProjectState>(
              listener: (context, state) {
                state.successOrFail.fold(() => null, (a) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              builder: (context, state) {
                return TextButton(
                  style:
                      OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                  onPressed: state.name.isEmpty
                      ? null
                      : () {
                          Octopus.of(context).showLoadingOverlay(context);
                          bloc.add(const Submitted());
                        },
                  child: const Text('Create'),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: OctopusTheme.of(context).colorTheme.border,
              height: 1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Space name',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Space name',
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
                    onChanged: (value) {
                      bloc.add(NameChanged(value));
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Space settings',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<CreateProjectBloc, CreateProjectState>(
                  builder: (context, state) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      color: theme.colorTheme.contentViewSecondary,
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatusesPage(
                                      statuses: bloc.state.statusList,
                                      onStatusChanged: (statusList) {
                                        bloc.add(StatusChanged(statusList
                                            .mapIndexed((index, status) =>
                                                status.copyWith(
                                                    numOrder: index))
                                            .toList()));
                                      });
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: theme.colorTheme.border,
                                        width: 1,
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/double_square.svg'),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text('Statuses',
                                      style: theme.textTheme.primaryGreyBody),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Spacer(),
                                  ...List<Widget>.generate(
                                    state.statusList.length,
                                    (index) => Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: HexColor.fromHex(
                                            state.statusList[index].color ??
                                                '#000000'),
                                      ),
                                    ),
                                  ).insertBetween(
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      fillColor: MaterialStatePropertyAll(
                          OctopusTheme.of(context).colorTheme.brandPrimary),
                      value: _showChannelSetting,
                      onChanged: (value) {
                        setState(() {
                          _showChannelSetting = value;
                        });
                      },
                    ),
                    Text(
                      'Create channel for project',
                      style: theme.textTheme.primaryGreyBody,
                    ),
                  ],
                ),
                AnimatedOpacity(
                    opacity: _showChannelSetting ?? false ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Text(
                          'Channel Settings',
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBodyBold,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
