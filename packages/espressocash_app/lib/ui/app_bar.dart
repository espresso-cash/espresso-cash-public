import 'package:flutter/material.dart';

import 'back_button.dart';

class CpAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CpAppBar({
    super.key,
    this.title,
    this.leading,
    this.nextButton,
    this.scrolledUnderColor,
    this.isAutomaticallyImplyLeading = true,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? nextButton;
  final Color backgroundColor = Colors.transparent;
  final Color? scrolledUnderColor;
  final bool isAutomaticallyImplyLeading;

  @override
  State<CpAppBar> createState() => _CpAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CpAppBarState extends State<CpAppBar> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _isScrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver?.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return;

    final bool isOldScrolledUnder = _isScrolledUnder;
    final ScrollMetrics metrics = notification.metrics;
    switch (metrics.axisDirection) {
      case AxisDirection.up:
        // Scroll view is reversed
        _isScrolledUnder = metrics.extentAfter > 0;
      case AxisDirection.down:
        _isScrolledUnder = metrics.extentBefore > 0;
      case AxisDirection.right:
      case AxisDirection.left:
        // Scrolled under is only supported in the vertical axis, and should
        // not be altered based on horizontal notifications of the same
        // predicate since it could be a 2D scroller.
        break;
    }

    if (_isScrolledUnder != isOldScrolledUnder) {
      setState(() {
        // React to a change in MaterialState.scrolledUnder
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrolledUnderColor = widget.scrolledUnderColor;

    return AppBar(
      title: widget.title,
      automaticallyImplyLeading: widget.isAutomaticallyImplyLeading,
      backgroundColor:
          scrolledUnderColor == null
              ? widget.backgroundColor
              : WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.scrolledUnder)
                        ? scrolledUnderColor
                        : widget.backgroundColor,
              ),
      clipBehavior: Clip.none,
      leading: widget.leading ?? const CpBackButton(),
      actions:
          widget.nextButton != null
              ? [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 93),
                      child: widget.nextButton,
                    ),
                  ),
                ),
              ]
              : null,
      elevation: 0,
      shape: const Border(),
      scrolledUnderElevation: scrolledUnderColor == null ? 0 : 4,
      forceMaterialTransparency: scrolledUnderColor != null && !_isScrolledUnder,
    );
  }
}
