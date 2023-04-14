import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum _LoadingStatus { loading, stable }

class LazyLoadScrollView extends StatefulWidget {
  const LazyLoadScrollView({
    super.key,
    required this.child,
    this.onStartOfPage,
    this.onEndOfPage,
    this.onPageScrollStart,
    this.onPageScrollEnd,
    this.onInBetweenOfPage,
    this.scrollOffset = 100,
    this.allowNotificationBubbling = false,
  });

  final Widget child;

  final AsyncCallback? onStartOfPage;

  final AsyncCallback? onEndOfPage;

  final VoidCallback? onPageScrollStart;

  final VoidCallback? onPageScrollEnd;

  final VoidCallback? onInBetweenOfPage;

  final double scrollOffset;

  final bool allowNotificationBubbling;

  @override
  State<StatefulWidget> createState() => _LazyLoadScrollViewState();
}

class _LazyLoadScrollViewState extends State<LazyLoadScrollView> {
  var _loadMoreStatus = _LoadingStatus.stable;
  double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: widget.child,
      );

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (widget.onPageScrollStart != null) {
        widget.onPageScrollStart!();
        return !widget.allowNotificationBubbling;
      }
    }
    if (notification is ScrollEndNotification) {
      if (widget.onPageScrollEnd != null) {
        widget.onPageScrollEnd!();
        return !widget.allowNotificationBubbling;
      }
    }
    if (notification is ScrollUpdateNotification) {
      final pixels = notification.metrics.pixels;
      final maxScrollExtent = notification.metrics.maxScrollExtent;
      final minScrollExtent = notification.metrics.minScrollExtent;
      final scrollOffset = widget.scrollOffset;

      if (pixels > (minScrollExtent + scrollOffset) &&
          pixels < (maxScrollExtent - scrollOffset)) {
        if (widget.onInBetweenOfPage != null) {
          widget.onInBetweenOfPage!();
          return !widget.allowNotificationBubbling;
        }
      }

      final extentBefore = notification.metrics.extentBefore;
      final extentAfter = notification.metrics.extentAfter;
      final scrollingDown = _scrollPosition < pixels;
      _scrollPosition = pixels;

      if (scrollingDown) {
        if (extentAfter <= scrollOffset) {
          _onEndOfPage();
          return !widget.allowNotificationBubbling;
        }
      } else {
        if (extentBefore <= scrollOffset) {
          _onStartOfPage();
          return !widget.allowNotificationBubbling;
        }
      }
    }
    if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _onEndOfPage();
      }
      if (notification.overscroll < 0) {
        _onStartOfPage();
      }
      return !widget.allowNotificationBubbling;
    }
    return false;
  }

  void _onEndOfPage() {
    if (_loadMoreStatus == _LoadingStatus.stable) {
      if (widget.onEndOfPage != null) {
        _loadMoreStatus = _LoadingStatus.loading;
        widget.onEndOfPage!().whenComplete(() {
          _loadMoreStatus = _LoadingStatus.stable;
        });
      }
    }
  }

  void _onStartOfPage() {
    if (_loadMoreStatus == _LoadingStatus.stable) {
      if (widget.onStartOfPage != null) {
        _loadMoreStatus = _LoadingStatus.loading;
        widget.onStartOfPage!().whenComplete(() {
          _loadMoreStatus = _LoadingStatus.stable;
        });
      }
    }
  }
}
