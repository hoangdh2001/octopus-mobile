import 'package:flutter/material.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Text(
              'Trending',
              style: OctopusTheme.of(context).textTheme.headerSection,
            ),
          ),
        ],
      ),
    );
  }
}
