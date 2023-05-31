import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/models/task_status.dart';
import 'package:octopus/core/extensions/extension_color.dart';
import 'package:octopus/core/extensions/extension_iterable.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ChooseStatusPage extends StatefulWidget {
  const ChooseStatusPage(
      {super.key, required this.statuses, required this.onStatusSelected});

  final List<TaskStatus> statuses;

  final void Function(TaskStatus) onStatusSelected;

  @override
  State<ChooseStatusPage> createState() => _ChooseStatusPageState();
}

class _ChooseStatusPageState extends State<ChooseStatusPage> {
  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final activeStatuses = widget.statuses
        .where((status) => !status.closeStatus)
        .toList()
      ..sort((a, b) => a.numOrder?.compareTo(b.numOrder ?? 0) ?? 0);
    final closeStatuses = widget.statuses.where((status) => status.closeStatus);
    return Scaffold(
      backgroundColor: theme.colorTheme.contentView,
      appBar: AppBar(
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
        elevation: 0,
        leadingWidth: 0,
        centerTitle: false,
        title: Text(
          'choose_status_title'.tr(),
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icons/close.svg'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('active_status'.tr()),
                  const SizedBox(
                    height: 8,
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
                        title: Text(status.name ?? ''),
                        onTap: () {
                          Navigator.pop(context);
                          widget.onStatusSelected(status);
                        },
                        trailing: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          shape: const CircleBorder(),
                          activeColor: theme.colorTheme.brandPrimary,
                          checkColor: Colors.white,
                          side: BorderSide(
                            width: 2,
                            color: theme.colorTheme.border,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                      );
                    },
                  ).insertBetween(const SizedBox(
                    height: 16,
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('closed_status'.tr()),
                  const SizedBox(
                    height: 8,
                  ),
                  ...List.generate(
                    closeStatuses.length,
                    (index) {
                      final status = closeStatuses.elementAt(index);
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
                        title: Text(status.name ?? ''),
                        onTap: () {
                          Navigator.pop(context);
                          widget.onStatusSelected(status);
                        },
                        trailing: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          shape: const CircleBorder(),
                          activeColor: theme.colorTheme.brandPrimary,
                          checkColor: Colors.white,
                          side: BorderSide(
                            width: 2,
                            color: theme.colorTheme.border,
                          ),
                        ),
                        visualDensity: VisualDensity.compact,
                      );
                    },
                  ),
                ],
              ),
            )
          ].insertBetween(
            Divider(
              height: 16,
              thickness: 1,
              color: OctopusTheme.of(context).colorTheme.border,
            ),
          ),
        ),
      ),
    );
  }
}
