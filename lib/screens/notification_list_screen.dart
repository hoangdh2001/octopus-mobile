import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_theme.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text("Notification list",
              style: OctopusTheme.of(context).textTheme.primaryGreyBody)),
    );
  }
}
