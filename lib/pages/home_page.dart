import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:octopus/core/config/app_routes.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/socketio/event_type.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:octopus/core/ui/notification_service.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/navigator_service.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/channel/channel_page.dart';

class HomePageArgs {
  final Client chatClient;

  HomePageArgs(this.chatClient);
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.chatClient,
  }) : super(key: key);

  final Client chatClient;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Octopus(
      client: widget.chatClient,
      firebaseMessaging: getIt<FirebaseMessaging>(),
      child: WillPopScope(
        onWillPop: () async {
          final canPop = await NavigationService
                  .instance.navigationKey.currentState
                  ?.maybePop() ??
              false;
          return !canPop;
        },
        child: const Navigator(
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: Routes.MAIN,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
