import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/workspace_member.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/user_list/user_list_tile.dart';

typedef ChipBuilder<T> = Widget Function(BuildContext context, T chip);
typedef OnChipAdded<T> = void Function(T chip);
typedef OnChipRemoved<T> = void Function(T chip);

class ChipsDropdownTextField<T extends Object> extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onInputChanged;
  final ChipBuilder<T> chipBuilder;
  final OnChipAdded<T>? onChipAdded;
  final OnChipRemoved<T>? onChipRemoved;
  final String hint;
  final List<T> items;
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOptionsViewBuilder<T> optionsViewBuilder;

  const ChipsDropdownTextField({
    Key? key,
    required this.chipBuilder,
    required this.controller,
    required this.items,
    required this.optionsBuilder,
    required this.optionsViewBuilder,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.onInputChanged,
    this.focusNode,
    this.onChipAdded,
    this.onChipRemoved,
    this.hint = 'Type a name',
  }) : super(key: key);

  @override
  ChipDropDownTextFieldState<T> createState() =>
      ChipDropDownTextFieldState<T>();
}

class ChipDropDownTextFieldState<T extends Object>
    extends State<ChipsDropdownTextField<T>> {
  final _chips = <T>{};
  bool _pauseItemAddition = false;

  void addItem(T item) {
    setState(() => _chips.add(item));
    if (widget.onChipAdded != null) widget.onChipAdded!(item);
  }

  void removeItem(T item) {
    setState(() {
      _chips.remove(item);
      if (_chips.isEmpty) resumeItemAddition();
    });
    if (widget.onChipRemoved != null) widget.onChipRemoved!(item);
  }

  void pauseItemAddition() {
    if (!_pauseItemAddition) {
      setState(() => _pauseItemAddition = true);
    }
    widget.focusNode?.unfocus();
  }

  void resumeItemAddition() {
    if (_pauseItemAddition) {
      setState(() => _pauseItemAddition = false);
    }
    widget.focusNode?.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: resumeItemAddition,
      child: Material(
        color: OctopusTheme.of(context).colorTheme.contentView,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: OctopusTheme.of(context).colorTheme.border,
            width: 1,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ..._chips.map((item) {
                      return widget.chipBuilder(context, item);
                    }).toList(),
                    if (!_pauseItemAddition)
                      RawAutocomplete<T>(
                        textEditingController: widget.controller!,
                        optionsBuilder: widget.optionsBuilder,
                        focusNode: widget.focusNode,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: widget.hint,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              hintStyle:
                                  OctopusTheme.of(context).textTheme.hint,
                            ),
                            focusNode: focusNode,
                            cursorColor: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                            enableSuggestions: true,
                            autocorrect: false,
                            style: OctopusTheme.of(context)
                                .textTheme
                                .primaryGreyBody,
                            onSubmitted: (value) {},
                          );
                        },
                        onSelected: addItem,
                        displayStringForOption: widget.displayStringForOption,
                        optionsViewBuilder: widget.optionsViewBuilder,
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

// TextField(
//                           controller: widget.controller,
//                           onChanged: widget.onInputChanged,
//                           focusNode: widget.focusNode,
//                           cursorColor:
//                               OctopusTheme.of(context).colorTheme.brandPrimary,
//                           decoration: InputDecoration(
//                             isDense: true,
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             contentPadding: const EdgeInsets.all(0),
//                             hintText: widget.hint,
//                             hintStyle: OctopusTheme.of(context).textTheme.hint,
//                           ),
//                           style: OctopusTheme.of(context)
//                               .textTheme
//                               .primaryGreyBody,
//                         ),
//                       ),
