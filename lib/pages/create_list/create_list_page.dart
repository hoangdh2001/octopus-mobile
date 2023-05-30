import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/project_state.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/create_list/bloc/create_list_bloc.dart';
import 'package:octopus/widgets/avatars/space_avatar.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key, required this.project});

  final ProjectState project;

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  late CreateListBloc bloc;

  @override
  void initState() {
    bloc = CreateListBloc(
        OctopusWorkspace.of(context).workspace,
        widget.project.copyWith(
            setting: widget.project.setting.copyWith(statuses: [
          ...widget.project.setting.statuses
            ..sort((a, b) => a.numOrder?.compareTo(b.numOrder ?? 0) ?? 0)
        ])));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
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
            'Create List',
            style: OctopusTheme.of(context).textTheme.navigationTitle,
          ),
          actions: [
            BlocConsumer<CreateListBloc, CreateListState>(
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
                  'List name',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 10),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter list name',
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
                  'List settings',
                  style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  color: theme.colorTheme.contentViewSecondary,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
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
                                    'assets/icons/folder_location.svg'),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text('Location',
                                  style: theme.textTheme.primaryGreyBody),
                              const SizedBox(
                                width: 16,
                              ),
                              const Spacer(),
                              SpaceAvatar(
                                name: widget.project.name,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  widget.project.name,
                                  style: theme.textTheme.primaryGreyBody,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
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
                              if (widget.project.setting.statuses.isNotEmpty)
                                ...List<Widget>.generate(
                                  widget.project.setting.statuses.length,
                                  (index) => Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: HexColor.fromHex(widget.project
                                              .setting.statuses[index].color ??
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
                    ].insertBetween(Divider(
                      height: 1,
                      color: theme.colorTheme.border,
                    )),
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
