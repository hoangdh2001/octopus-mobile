import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/workspace.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/paged_value_scroll_view.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_empty_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_index_widget_builder.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_load_more_indicator.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_loading_widget.dart';
import 'package:octopus/widgets/workspace_list/workspace_list_bloc.dart';
import 'package:octopus/widgets/workspace_list/workspace_list_tile.dart';

Widget defaultWorkspaceListViewSeparatorBuilder(
  BuildContext context,
  List<Workspace> users,
  int index,
) =>
    const WorkspaceListSeparator();

typedef WorkspaceListViewIndexedWidgetBuilder
    = ScrollViewIndexedWidgetBuilder<Workspace, WorkspaceListTile>;

class WorkspaceList extends StatelessWidget {
  const WorkspaceList({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.separatorBuilder = defaultWorkspaceListViewSeparatorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onWorkspaceTap,
    this.onWorkspaceLongPress,
    this.loadMoreTriggerIndex = 3,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.shrinkWrap = false,
    this.physics,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  });

  final WorkspaceListBloc controller;

  final WorkspaceListViewIndexedWidgetBuilder? itemBuilder;

  final PagedValueScrollViewIndexedWidgetBuilder<Workspace> separatorBuilder;

  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext, OCError)? errorBuilder;

  final void Function(Workspace)? onWorkspaceTap;

  final void Function(Workspace)? onWorkspaceLongPress;

  final int loadMoreTriggerIndex;

  final Axis scrollDirection;

  final EdgeInsetsGeometry? padding;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final bool reverse;

  final ScrollController? scrollController;

  final bool? primary;

  final bool shrinkWrap;

  final ScrollPhysics? physics;

  final double? cacheExtent;

  final DragStartBehavior dragStartBehavior;

  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  final String? restorationId;

  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return PagedValueListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      itemBuilder: (context, workspaces, index) {
        final workspace = workspaces[index];
        final onTap = onWorkspaceTap;
        final onLongPress = onWorkspaceLongPress;

        final workspaceListTile = WorkspaceListTile(
          workspace: workspace,
          onTap: onTap == null ? null : () => onTap(workspace),
          onLongPress:
              onLongPress == null ? null : () => onLongPress(workspace),
        );

        return itemBuilder?.call(
              context,
              workspaces,
              index,
              workspaceListTile,
            ) ??
            workspaceListTile;
      },
      separatorBuilder: separatorBuilder,
      emptyBuilder: (context) {
        return emptyBuilder?.call(context) ??
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ScrollViewEmptyWidget(
                  emptyIcon: Container(),
                  emptyTitle: const Text('Empty'),
                ),
              ),
            );
      },
      loadMoreIndicatorBuilder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ScrollViewLoadMoreIndicator(),
        ),
      ),
      loadingBuilder: (context) =>
          loadingBuilder?.call(context) ??
          const Center(
            child: ScrollViewLoadingWidget(),
          ),
      errorBuilder: (context, error) =>
          errorBuilder?.call(context, error) ??
          Center(
            child: Text('Error: $error'),
          ),
      loadMoreErrorBuilder: (context, error) => Container(),
    );
  }
}

class WorkspaceListSeparator extends StatelessWidget {
  const WorkspaceListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
    );
  }
}
