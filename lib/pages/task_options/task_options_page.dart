import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class TaskOptionsPage extends StatefulWidget {
  const TaskOptionsPage(
      {super.key, required this.onDelete, required this.onEdit});

  final Function() onDelete;

  final Function() onEdit;

  @override
  State<TaskOptionsPage> createState() => _TaskOptionsPageState();
}

class _TaskOptionsPageState extends State<TaskOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: OctopusTheme.of(context).colorTheme.contentView,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Scaffold(
          backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
          appBar: AppBar(
            leading: const Offstage(),
            backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
            elevation: 0,
            leadingWidth: 0,
            centerTitle: false,
            title: Text(
              'edit_bottom_sheet.title'.tr(),
              style: OctopusTheme.of(context).textTheme.navigationTitle,
            ),
            actions: [
              TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('done'.tr()),
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onEdit.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/move.svg',
                            width: 24,
                            height: 24,
                            color: OctopusTheme.of(context).colorTheme.icon),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            'edit_bottom_sheet.move_option'.tr(),
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onDelete.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/trash.svg',
                          color: OctopusTheme.of(context).colorTheme.error,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            'edit_bottom_sheet.delete_option'.tr(),
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody
                                .copyWith(
                                  color:
                                      OctopusTheme.of(context).colorTheme.error,
                                ),
                          ),
                        )
                      ],
                    ),
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
