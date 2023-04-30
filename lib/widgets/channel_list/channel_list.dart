import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/error.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/paged_value_scroll_view.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_empty_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_index_widget_builder.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_load_more_indicator.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_loading_widget.dart';
import 'package:octopus/pages/channelList/bloc/channel_list_bloc.dart';
import 'package:octopus/widgets/channel_list/channel_list_tile.dart';

Widget defaultChannelListViewSeparatorBuilder(
  BuildContext context,
  List<Channel> items,
  int index,
) =>
    const ChannelListSeparator();

typedef ChannelListViewIndexedWidgetBuilder
    = ScrollViewIndexedWidgetBuilder<Channel, ChannelListTile>;

class ChannelList extends StatelessWidget {
  const ChannelList({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.separatorBuilder = defaultChannelListViewSeparatorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onChannelTap,
    this.onChannelLongPress,
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

  final ChannelListBloc controller;

  final ChannelListViewIndexedWidgetBuilder? itemBuilder;

  final PagedValueScrollViewIndexedWidgetBuilder<Channel> separatorBuilder;

  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext, Error)? errorBuilder;

  final void Function(Channel)? onChannelTap;

  final void Function(Channel)? onChannelLongPress;

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
    return PagedValueListView<int, Channel>(
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
      itemBuilder: (context, channels, index) {
        final channel = channels[index];
        final onTap = onChannelTap;
        final onLongPress = onChannelLongPress;

        final channelListTile = ChannelListTile(
          channel: channel,
          onTap: onTap == null ? null : () => onTap(channel),
          onLongPress: onLongPress == null ? null : () => onLongPress(channel),
        );

        return itemBuilder?.call(context, channels, index, channelListTile) ??
            channelListTile;
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
}

class ChannelListSeparator extends StatelessWidget {
  const ChannelListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final effect = OctopusTheme.of(context).colorTheme.border;
    return Container(
      height: 1,
      color: effect,
    );
  }
}
