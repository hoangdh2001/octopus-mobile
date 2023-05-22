import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key, required this.onColorPicker, this.color});

  final void Function(Color? color) onColorPicker;

  final Color? color;

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
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
            backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
            elevation: 0,
            leadingWidth: 0,
            centerTitle: false,
            title: Text(
              'Pick a color',
              style: OctopusTheme.of(context).textTheme.navigationTitle,
            ),
            actions: [
              TextButton(
                style: OctopusTheme.of(context).buttonTheme.buttonBrandPrimary,
                onPressed: () {},
                child: const Text('Done'),
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
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: SingleChildScrollView(
                child: Column(
              children: [
                BlockPicker(
                    pickerColor: widget.color ?? Colors.red,
                    onColorChanged: (value) {
                      widget.onColorPicker.call(value);
                      Navigator.pop(context);
                    },
                    layoutBuilder: (context, colors, child) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisExtent: 60,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                widget.onColorPicker.call(null);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SvgPicture.asset(
                                  'assets/icons/unavailable.svg',
                                  color:
                                      OctopusTheme.of(context).colorTheme.icon,
                                ),
                              ),
                            );
                          }
                          return child(colors[index - 1]);
                        },
                        itemCount: colors.length + 1,
                      );
                    }),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
