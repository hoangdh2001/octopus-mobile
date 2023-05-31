import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/config/app_routes.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';

import 'package:octopus/core/data/models/workspace_state.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/navigator_service.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_workspace.dart';
import 'package:octopus/pages/new_workspace/new_workspace_page.dart';

class HomePageArgs {
  final Client chatClient;
  final WorkspaceState? workspaceState;

  HomePageArgs(this.chatClient, this.workspaceState);
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.chatClient,
    this.workspaceState,
  }) : super(key: key);

  final Client chatClient;

  final WorkspaceState? workspaceState;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client get chatClient => widget.chatClient;

  @override
  Widget build(BuildContext context) {
    return Octopus(
      client: chatClient,
      workspaceState: widget.workspaceState,
      firebaseMessaging: getIt<FirebaseMessaging>(),
      builder: (context, initRoute) {
        return WillPopScope(
          onWillPop: () async {
            final canPop = await NavigationService
                    .instance.navigationKey.currentState
                    ?.maybePop() ??
                false;
            return !canPop;
          },
          child: BetterStreamBuilder(
            stream: chatClient.state.currentWorkspaceStream,
            builder: (context, data) {
              return OctopusWorkspace(
                worspace: data,
                child: Navigator(
                  onGenerateRoute: AppRoutes.generateRoute,
                  key: NavigationService.instance.navigationKey,
                  observers: [NavigationService.instance.routeObserver],
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    if (initialRoute == Routes.HOME) {
                      return [
                        AppRoutes.generateRoute(
                          RouteSettings(
                            name: Routes.HOME,
                            arguments: HomePageArgs(
                              widget.chatClient,
                              widget.workspaceState,
                            ),
                          ),
                        )!
                      ];
                    }
                    return [
                      AppRoutes.generateRoute(
                        RouteSettings(name: initialRoute),
                      )!,
                    ];
                  },
                  initialRoute: Routes.MAIN,
                ),
              );
            },
            noDataBuilder: (context) {
              return const NewWorkspacePage();
            },
          ),
        );
      },
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
}
