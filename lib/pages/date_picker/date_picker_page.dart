import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key, required this.onDone});

  final void Function(DateTime? startDate, DateTime? dueDate) onDone;

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime _startDate = DateTime.now();
  DateTime? _dueDate;

  late TextEditingController _startDateController;

  late TextEditingController _dueDateController;

  late FocusNode _startDateFocusNode;
  late FocusNode _dueDateFocusNode;

  @override
  void initState() {
    _startDateController = TextEditingController();
    _dueDateController = TextEditingController();
    _startDateFocusNode = FocusNode();
    _dueDateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _dueDateController.dispose();
    _startDateFocusNode.dispose();
    _dueDateFocusNode.dispose();
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _startDate = args.value.startDate;
        _dueDate = args.value.endDate;
        _startDateController.text =
            DateFormat('dd MMMM').format(args.value.startDate);
        if (args.value.endDate == null) {
          _dueDateFocusNode.requestFocus();
          _dueDateController.clear();
        } else {
          _dueDateFocusNode.requestFocus();
          _dueDateController.text =
              DateFormat('dd MMMM').format(args.value.endDate);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Date',
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _startDateController,
                      decoration: InputDecoration(
                        hintText: 'Set date',
                        hintStyle: OctopusTheme.of(context).textTheme.hint,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _startDateController.clear();
                            });
                          },
                          icon: SvgPicture.asset('assets/icons/close.svg'),
                        ),
                      ),
                      focusNode: _startDateFocusNode,
                      autofocus: true,
                      readOnly: true,
                      cursorColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Date',
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      focusNode: _dueDateFocusNode,
                      controller: _dueDateController,
                      decoration: InputDecoration(
                        hintText: 'Set date',
                        hintStyle: OctopusTheme.of(context).textTheme.hint,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: OctopusTheme.of(context)
                                .colorTheme
                                .brandPrimary,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _dueDateController.clear();
                            });
                          },
                          icon: SvgPicture.asset('assets/icons/close.svg'),
                        ),
                      ),
                      readOnly: true,
                      onChanged: (value) {},
                      cursorColor:
                          OctopusTheme.of(context).colorTheme.brandPrimary,
                      style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              showTodayButton: true,
              todayHighlightColor:
                  OctopusTheme.of(context).colorTheme.brandPrimary,
              rangeSelectionColor: OctopusTheme.of(context)
                  .colorTheme
                  .brandPrimary
                  .withOpacity(.2),
              startRangeSelectionColor:
                  OctopusTheme.of(context).colorTheme.brandPrimary,
              endRangeSelectionColor:
                  OctopusTheme.of(context).colorTheme.brandPrimary,
              initialSelectedRange: PickerDateRange(
                _startDate,
                _dueDate,
              ),
              navigationMode: DateRangePickerNavigationMode.scroll,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              navigationDirection: DateRangePickerNavigationDirection.vertical,
              onSelectionChanged: _onSelectionChanged,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OctopusTheme.of(context)
                        .buttonTheme
                        .buttonPrimaryGreyBorder,
                    child: const Text('Cancel'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onDone(_startDate, _dueDate);
                    },
                    style:
                        OctopusTheme.of(context).buttonTheme.brandPrimaryButton,
                    child: const Text('Done'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
