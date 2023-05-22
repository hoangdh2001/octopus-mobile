import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/config/app_routes.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/octopus_core.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/typedef.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/utils/constants.dart';
import 'package:octopus/widgets/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Octopus extends StatefulWidget {
  const Octopus({
    super.key,
    required this.client,
    required this.builder,
    this.workspaceState,
    this.octopusThemeData,
    this.onBackgroundEventReceived,
    this.backgroundKeepAlive = const Duration(minutes: 1),
    this.connectivityStream,
    required this.firebaseMessaging,
  });

  final Client client;

  final Widget Function(BuildContext context, String initRoute) builder;

  final OctopusThemeData? octopusThemeData;

  final Duration backgroundKeepAlive;

  final EventHandler? onBackgroundEventReceived;

  final FirebaseMessaging firebaseMessaging;

  final WorkspaceState? workspaceState;

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

  late Future<List<Workspace>> _future = client.getWorkspace();

  Map<String, Workspace> get workspaces => widget.client.state.workspaces;

  Stream<Map<String, Workspace>> get workspacesStream =>
      widget.client.state.workspacesStream;

  Workspace? get currentWorkspace => widget.client.state.currentWorkspace;

  Stream<Workspace?> get currentWorkspaceStream =>
      widget.client.state.currentWorkspaceStream;

  @override
  void initState() {
    _future = client.getWorkspace();
    super.initState();
  }

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
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String initRoute = Routes.CREATE_WORKSPACE;
                    if (snapshot.data?.isNotEmpty ?? false) {
                      final index = snapshot.data!.indexWhere((workspace) =>
                          workspace.id == widget.workspaceState?.id);
                      if (index > -1) {
                        client.state.currentWorkspace = snapshot.data![index];
                        initRoute = Routes.MAIN;
                      } else {
                        client.state.currentWorkspace = snapshot.data!.first;

                        initRoute = Routes.MAIN;
                      }
                      getIt<SharedPreferences>().setString(
                          workspaceLocal,
                          jsonEncode(client
                              .state.currentWorkspace!.state!.workspaceState));
                    }
                    return widget.builder.call(
                      context,
                      initRoute,
                    );
                  } else {
                    return Scaffold(
                      backgroundColor:
                          OctopusTheme.of(context).colorTheme.contentView,
                      body: Center(
                        child: _getIndicatorWidget(Theme.of(context).platform),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
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

  void showLoadingOverlay(BuildContext context) {
    showDialog(
      useRootNavigator: false,
      context: context,
      barrierColor: widget.octopusThemeData?.colorTheme.overlay,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) => const LoadingOverlay(),
    );
  }

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
