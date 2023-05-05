import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/paged_value_scroll_view.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_empty_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_index_widget_builder.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_load_more_indicator.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_loading_widget.dart';
import 'package:octopus/widgets/user_list/user_list_bloc.dart';
import 'package:octopus/widgets/user_list/user_list_tile.dart';

Widget defaultUserListViewSeparatorBuilder(
  BuildContext context,
  List<User> users,
  int index,
) =>
    const UserListSeparator();

typedef UserListViewIndexedWidgetBuilder
    = ScrollViewIndexedWidgetBuilder<User, UserListTile>;

class UserListView extends StatelessWidget {
  const UserListView({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.separatorBuilder = defaultUserListViewSeparatorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onUserTap,
    this.onUserLongPress,
    this.loadMoreTriggerIndex = 3,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  });

  final UserListBloc controller;

  final UserListViewIndexedWidgetBuilder? itemBuilder;

  final PagedValueScrollViewIndexedWidgetBuilder<User> separatorBuilder;

  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext, OCError)? errorBuilder;

  final void Function(User)? onUserTap;

  final void Function(User)? onUserLongPress;

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
  Widget build(BuildContext context) => PagedValueListView<int, User>(
        scrollDirection: scrollDirection,
        padding: padding,
        physics: physics,
        reverse: reverse,
        controller: controller,
        scrollController: scrollController,
        primary: primary,
        shrinkWrap: shrinkWrap,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        dragStartBehavior: dragStartBehavior,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        loadMoreTriggerIndex: loadMoreTriggerIndex,
        separatorBuilder: separatorBuilder,
        itemBuilder: (context, users, index) {
          final user = users[index];
          final onTap = onUserTap;
          final onLongPress = onUserLongPress;

          final userListTile = UserListTile(
            user: user,
            onTap: onTap == null ? null : () => onTap(user),
            onLongPress: onLongPress == null ? null : () => onLongPress(user),
          );

          return itemBuilder?.call(
                context,
                users,
                index,
                userListTile,
              ) ??
              userListTile;
        },
        emptyBuilder: (context) {
          return emptyBuilder?.call(context) ??
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ScrollViewEmptyWidget(
                    emptyIcon: Container(),
                    emptyTitle: Text('Test'),
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
              child: Container(),
            ),
        loadMoreErrorBuilder: (context, error) => Container(),
      );
}

class UserListSeparator extends StatelessWidget {
  const UserListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final effect = OctopusTheme.of(context).colorTheme.border;
    return Row(
      children: [
        const SizedBox(
          width: 80,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: effect,
          ),
        )
      ],
    );
  }
}
