import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:cryptoplease_ui/src/headered_list/header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'button.dart';
export 'content.dart';

class CpHeaderedList extends StatelessWidget {
  const CpHeaderedList({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.headerButtons,
    required this.headerContent,
    required this.headerAppBar,
    this.stickyBottomHeader,
    this.allowBackNavigation = false,
  }) : super(key: key);

  final AsyncCallback onRefresh;
  final Widget child;
  final List<Widget> headerButtons;
  final Widget headerContent;
  final Widget headerAppBar;
  final bool allowBackNavigation;
  final PreferredSizeWidget? stickyBottomHeader;

  @override
  Widget build(BuildContext context) {
    final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return CpTheme.dark(
      child: Material(
        color: CpColors.primaryColor,
        child: RefreshIndicator(
          displacement: 80,
          notificationPredicate: (notification) => true,
          onRefresh: onRefresh,
          backgroundColor: Colors.white,
          color: CpColors.primaryColor,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, __) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: HeaderedListHeader(
                  appBar: headerAppBar,
                  allowBackNavigation: allowBackNavigation,
                  stickyBottomHeader: stickyBottomHeader,
                  minHeight: minHeight,
                  buttons: headerButtons,
                  child: headerContent,
                ),
              ),
            ],
            body: ClipRRect(
              clipper: _Clipper(minHeight),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _Clipper extends CustomClipper<RRect> {
  const _Clipper(this.minHeight);

  final double minHeight;

  @override
  RRect getClip(Size size) => RRect.fromLTRBAndCorners(
        0,
        minHeight,
        size.width,
        size.height,
        topLeft: const Radius.circular(24),
        topRight: const Radius.circular(24),
      );

  @override
  bool shouldReclip(_Clipper oldClipper) => minHeight != oldClipper.minHeight;
}
