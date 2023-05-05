import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/core/octopus_core.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/notification_service.dart';
import 'package:octopus/core/ui/typedef.dart';

class Octopus extends StatefulWidget {
  const Octopus({
    super.key,
    required this.client,
    required this.child,
    this.octopusThemeData,
    this.onBackgroundEventReceived,
    this.backgroundKeepAlive = const Duration(minutes: 1),
    this.connectivityStream,
    required this.firebaseMessaging,
  });

  final Client client;

  final Widget? child;

  final OctopusThemeData? octopusThemeData;

  final Duration backgroundKeepAlive;

  final EventHandler? onBackgroundEventReceived;

  final FirebaseMessaging firebaseMessaging;

  @visibleForTesting
  final Stream<ConnectivityResult>? connectivityStream;

  @override
  OctopusState createState() => OctopusState();

  static OctopusState of(BuildContext context) {
    OctopusState? octopusState;

    octopusState = context.findAncestorStateOfType<OctopusState>();

    if (octopusState == null) {
      throw Exception(
        'You must have a Octopus widget at the top of your widget tree',
      );
    }

    return octopusState;
  }
}

class OctopusState extends State<Octopus> {
  Client get client => widget.client;

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme(context, widget.octopusThemeData);
    return Portal(
      child: OctopusTheme(
        data: theme,
        child: Builder(
          builder: (context) {
            final materialTheme = Theme.of(context);
            final streamTheme = OctopusTheme.of(context);
            return OctopusCore(
              client: client,
              onBackgroundEventReceived: widget.onBackgroundEventReceived,
              backgroundKeepAlive: widget.backgroundKeepAlive,
              connectivityStream: widget.connectivityStream,
              child: Builder(
                builder: (context) {
                  return widget.child ?? const Offstage();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  OctopusThemeData _getTheme(
    BuildContext context,
    OctopusThemeData? themeData,
  ) {
    final appBrightness = Theme.of(context).brightness;
    final defaultTheme = OctopusThemeData(brightness: appBrightness);
    return defaultTheme.merge(themeData);
  }

  User? get currentUser => widget.client.state.currentUser;

  Stream<User?> get currentUserStream => widget.client.state.currentUserStream;

  @override
  void didChangeDependencies() {
    final currentLocale = Localizations.localeOf(context).toString();
    final availableLocales = Jiffy.getAllAvailableLocales();
    if (availableLocales.contains(currentLocale)) {
      Jiffy.locale(currentLocale);
    }
    super.didChangeDependencies();
  }
}

class MyObserver extends RouteObserver<PageRoute> {
  Route? currentRoute;
  late final StreamSubscription _subscription;

  MyObserver(
    Client client,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    _subscription = client
        .on(
      EventType.messageNew,
      EventType.notificationMessageNew,
    )
        .listen((event) {
      if (event.message?.sender?.id == client.state.currentUser?.id) {
        return;
      }
      final channelId = event.channelID;
      if (currentRoute?.settings.name == '/channels') {
        final channel = currentRoute?.settings.arguments as Channel;
        if (channel.id == channelId) {
          return;
        }
      }

      showLocalNotification(
        event,
        client.state.currentUser!.id,
        navigatorKey.currentState!.context,
      );
    });
  }
}
