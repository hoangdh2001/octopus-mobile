import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/statuses/add_status_page.dart';
import 'package:octopus/pages/statuses/edit_page.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';

class StatusesPage extends StatefulWidget {
  const StatusesPage(
      {super.key, this.statuses = const [], required this.onStatusChanged});

  final List<TaskStatus> statuses;

  final void Function(List<TaskStatus> status) onStatusChanged;

  @override
  State<StatusesPage> createState() => _StatusesPageState();
}

class _StatusesPageState extends State<StatusesPage> {
  final _statuses = <TaskStatus>[];

  @override
  void initState() {
    super.initState();
    _statuses.addAll(widget.statuses);
  }

  @override
  Widget build(BuildContext context) {
    final activeStatuses = _statuses.where((status) => !status.closeStatus);
    final closedStatuses = _statuses.where((status) => status.closeStatus);
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          'Custom Statuses',
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        actions: [
          TextButton(
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            onPressed: () {
              Navigator.pop(context);
              widget.onStatusChanged.call(_statuses);
            },
            child: const Text('Create'),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Active'),
              const Text('For tasks that have been started'),
              const SizedBox(
                height: 16,
              ),
              ...List<Widget>.generate(
                activeStatuses.length,
                (index) {
                  final status = activeStatuses.elementAt(index);
                  return ListTile(
                    leading: Card(
                      elevation: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex(status.color ?? ''),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    horizontalTitleGap: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: OctopusTheme.of(context).colorTheme.border,
                      ),
                    ),
                    title: Text(status.name ?? ''),
                    trailing: GestureDetector(
                      onTap: () {
                        showCustomModalBottomSheet(
                          context: context,
                          expand: false,
                          builder: (context) {
                            return EditPage(
                              onDelete: () {
                                setState(() {
                                  _statuses.remove(status);
                                });
                              },
                              onEdit: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddStatusPage(
                                      name: status.name,
                                      color: HexColor.fromHex(status.color),
                                      onCreate: (name, color) {
                                        setState(
                                          () {
                                            _statuses[index] = status.copyWith(
                                                name: name,
                                                color: color?.toHex());
                                          },
                                        );
                                      },
                                    );
                                  },
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            );
                          },
                          backgroundColor: Colors.transparent,
                          containerWidget: (BuildContext context,
                              Animation<double> animation, Widget child) {
                            return Container(
                              height:
                                  200 + MediaQuery.of(context).padding.bottom,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: child,
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        height: double.infinity,
                        child: SvgPicture.asset('assets/icons/more.svg'),
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                  );
                },
              ).insertBetween(const SizedBox(
                height: 16,
              )),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: TextButton.icon(
                  style: OctopusTheme.of(context).buttonTheme.greyButton,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return AddStatusPage(
                          onCreate: (name, color) {
                            setState(() {
                              _statuses.add(TaskStatus(
                                name: name,
                                color: color?.toHex(),
                                closeStatus: false,
                              ));
                            });
                          },
                        );
                      },
                      useSafeArea: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  icon: SvgPicture.asset('assets/icons/plus.svg'),
                  label: const Text('Add status'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Closed Status'),
              const Text('Completed tasks that are hidden by default'),
              const SizedBox(
                height: 16,
              ),
              ...List.generate(
                closedStatuses.length,
                (index) {
                  final status = closedStatuses.elementAt(index);
                  return ListTile(
                    leading: Card(
                      elevation: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: HexColor.fromHex(status.color ?? ''),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    horizontalTitleGap: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: OctopusTheme.of(context).colorTheme.border,
                      ),
                    ),
                    title: Text(status.name ?? ''),
                    trailing: SizedBox(
                      height: double.infinity,
                      child: SvgPicture.asset('assets/icons/more.svg'),
                    ),
                    visualDensity: VisualDensity.compact,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
