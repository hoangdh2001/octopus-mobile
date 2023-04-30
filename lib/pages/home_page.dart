import 'package:flutter/material.dart' hide MenuItem;
import 'package:octopus/core/theme/oc_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Home",
            style: OctopusTheme.of(context).textTheme.primaryGreyBody),
      ),
    );
  }
}
