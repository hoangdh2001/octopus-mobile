import 'package:flutter/cupertino.dart' show CupertinoSlidingSegmentedControl;
import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';

enum RecentSegment {
  mywork,
  calendar,
}

class RecentSection extends StatefulWidget {
  const RecentSection({super.key});

  @override
  State<RecentSection> createState() => _RecentSectionState();
}

class _RecentSectionState extends State<RecentSection> {
  RecentSegment _selectedSegment = RecentSegment.mywork;

  bool get isSelectMyWork => _selectedSegment == RecentSegment.mywork;

  @override
  Widget build(BuildContext context) {
    final theme = OctopusTheme.of(context);
    return Column(
      children: [],
    );
  }
}
