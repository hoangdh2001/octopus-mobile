import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/pages/statuses/colorpicker/color_picker_page.dart';

class AddStatusPage extends StatefulWidget {
  const AddStatusPage({
    super.key,
    required this.onCreate,
    this.name,
    this.color,
  });

  final String? name;

  final Color? color;

  final void Function(String name, Color? color) onCreate;

  @override
  State<AddStatusPage> createState() => _AddStatusPageState();
}

class _AddStatusPageState extends State<AddStatusPage> {
  late TextEditingController _controller;

  late Color? color = widget.color;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
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
          'New Status',
          style: OctopusTheme.of(context).textTheme.navigationTitle,
        ),
        actions: [
          TextButton(
            style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
            onPressed: _controller.text.isEmpty
                ? null
                : () {
                    widget.onCreate.call(_controller.text, color);
                    Navigator.pop(context);
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
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            right: 16,
            top: 16,
            left: 16,
          ),
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type status name',
                    hintStyle: OctopusTheme.of(context).textTheme.hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: OctopusTheme.of(context).colorTheme.brandPrimary,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  autofocus: true,
                  cursorColor: OctopusTheme.of(context).colorTheme.brandPrimary,
                  enableSuggestions: true,
                  autocorrect: false,
                  style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
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
                        showCustomModalBottomSheet(
                          context: context,
                          expand: false,
                          builder: (context) {
                            return ColorPickerPage(
                              color: color,
                              onColorPicker: (color) {
                                setState(() {
                                  this.color = color;
                                });
                              },
                            );
                          },
                          backgroundColor: Colors.transparent,
                          containerWidget: (BuildContext context,
                              Animation<double> animation, Widget child) {
                            return Container(
                              height: 0.5.sh +
                                  MediaQuery.of(context).padding.bottom,
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
                                  'assets/icons/color_picker.svg'),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('Pick a color',
                                style: theme.textTheme.primaryGreyBody),
                            const Spacer(),
                            color != null
                                ? Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )
                                : SvgPicture.asset('assets/icons/plus.svg'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
