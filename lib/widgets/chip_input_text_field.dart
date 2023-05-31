import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';

typedef ChipBuilder<T> = Widget Function(BuildContext context, T chip);
typedef OnChipAdded<T> = void Function(T chip);
typedef OnChipRemoved<T> = void Function(T chip);

class ChipsInputTextField<T> extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onInputChanged;
  final ChipBuilder<T> chipBuilder;
  final OnChipAdded<T>? onChipAdded;
  final OnChipRemoved<T>? onChipRemoved;
  final String hint;

  const ChipsInputTextField({
    Key? key,
    required this.chipBuilder,
    required this.controller,
    this.onInputChanged,
    this.focusNode,
    this.onChipAdded,
    this.onChipRemoved,
    this.hint = 'Type a name',
  }) : super(key: key);

  @override
  ChipInputTextFieldState<T> createState() => ChipInputTextFieldState<T>();
}

class ChipInputTextFieldState<T> extends State<ChipsInputTextField<T>> {
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
        color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'to'.tr().toUpperCase(),
                  style: OctopusTheme.of(context)
                      .textTheme
                      .primaryGreyBody
                      .copyWith(
                          color: OctopusTheme.of(context)
                              .colorTheme
                              .primaryGrey
                              .withOpacity(.5)),
                ),
              ),
              const SizedBox(width: 12),
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
                      IntrinsicWidth(
                        child: TextField(
                          controller: widget.controller,
                          onChanged: widget.onInputChanged,
                          focusNode: widget.focusNode,
                          cursorColor:
                              OctopusTheme.of(context).colorTheme.brandPrimary,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0),
                            hintText: widget.hint,
                            hintStyle: OctopusTheme.of(context).textTheme.hint,
                          ),
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Align(
                alignment: Alignment.bottomCenter,
                child: _chips.isEmpty
                    ? null
                    : Ink(
                        decoration: BoxDecoration(
                          color: OctopusTheme.of(context)
                              .colorTheme
                              .primaryGrey
                              .withOpacity(.1),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: resumeItemAddition,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: SvgPicture.asset(
                              'assets/icons/add.svg',
                              color: OctopusTheme.of(context).colorTheme.icon,
                              width: 12,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
