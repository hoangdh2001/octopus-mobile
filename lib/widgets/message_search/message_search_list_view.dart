import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/get_message_response.dart';
import 'package:octopus/core/data/socketio/chat_error.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/paged_value_scroll_view.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_empty_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_error_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_index_widget_builder.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_load_more_error_widget.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_load_more_indicator.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_loading_widget.dart';
import 'package:octopus/widgets/message_search/bloc/message_search_list_bloc.dart';
import 'package:octopus/widgets/message_search/message_search_list_tile.dart';

Widget defaultMessageSearchListViewSeparatorBuilder(
  BuildContext context,
  List<GetMessageResponse> responses,
  int index,
) =>
    const StreamMessageSearchListSeparator();

typedef MessageSearchListViewIndexedWidgetBuilder
    = ScrollViewIndexedWidgetBuilder<GetMessageResponse, MessageSearchListTile>;

class MessageSearchListView extends StatelessWidget {
  const MessageSearchListView({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.separatorBuilder = defaultMessageSearchListViewSeparatorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onMessageTap,
    this.onMessageLongPress,
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

  final MessageSearchListBloc controller;

  final MessageSearchListViewIndexedWidgetBuilder? itemBuilder;

  final PagedValueScrollViewIndexedWidgetBuilder<GetMessageResponse>
      separatorBuilder;

  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext, OCError)? errorBuilder;

  final void Function(GetMessageResponse)? onMessageTap;

  final void Function(GetMessageResponse)? onMessageLongPress;

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
  Widget build(BuildContext context) =>
      PagedValueListView<String, GetMessageResponse>(
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
        itemBuilder: (context, messageResponses, index) {
          final messageResponse = messageResponses[index];
          final onTap = onMessageTap;
          final onLongPress = onMessageLongPress;

          final streamMessageSearchListTile = MessageSearchListTile(
            messageResponse: messageResponse,
            onTap: onTap == null ? null : () => onTap(messageResponse),
            onLongPress:
                onLongPress == null ? null : () => onLongPress(messageResponse),
          );

          return itemBuilder?.call(
                context,
                messageResponses,
                index,
                streamMessageSearchListTile,
              ) ??
              streamMessageSearchListTile;
        },
        emptyBuilder: (context) {
          final chatThemeData = OctopusTheme.of(context);
          return emptyBuilder?.call(context) ??
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ScrollViewEmptyWidget(
                    emptyIcon: SvgPicture.asset(
                      'assets/icons/messages.svg',
                      width: 148,
                      height: 148,
                      color: chatThemeData.colorTheme.disabled,
                    ),
                    emptyTitle: Text(
                      'Message empty',
                      style: chatThemeData.textTheme.primaryGreyH1,
                    ),
                  ),
                ),
              );
        },
        loadMoreErrorBuilder: (context, error) => ScrollViewLoadMoreError.list(
          onTap: () {
            controller.add(const Retry());
          },
          error: const Text('Loading message error'),
        ),
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
              child: ScrollViewErrorWidget(
                errorTitle: const Text('Loading message error'),
                onRetryPressed: () {
                  controller.add(const Refresh());
                },
              ),
            ),
      );
}

class StreamMessageSearchListSeparator extends StatelessWidget {
  const StreamMessageSearchListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final effect = OctopusTheme.of(context).colorTheme.border;
    return Container(
      height: 1,
      color: effect.withOpacity(1.0),
    );
  }
}
