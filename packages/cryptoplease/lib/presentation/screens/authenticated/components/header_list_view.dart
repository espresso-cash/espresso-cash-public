import 'package:cryptoplease/presentation/screens/authenticated/components/header.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeHeaderListWidget extends StatelessWidget {
  const HomeHeaderListWidget({
    Key? key,
    required this.balanceWidget,
    required this.child,
    required this.onAddFundsPressed,
    required this.onReceivePressed,
    required this.onRefresh,
    required this.onSendPressed,
    this.allowBackNavigation = false,
    this.stickyBottomHeader,
  }) : super(key: key);

  final AsyncCallback onRefresh;
  final bool allowBackNavigation;
  final VoidCallback? onAddFundsPressed;
  final VoidCallback onReceivePressed;
  final VoidCallback onSendPressed;
  final Widget balanceWidget;
  final Widget child;
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
                sliver: HomeScreenHeader(
                  allowBackNavigation: allowBackNavigation,
                  balanceWidget: balanceWidget,
                  onAddFundsPressed: onAddFundsPressed,
                  onReceivePressed: onReceivePressed,
                  onSendPressed: onSendPressed,
                  stickyBottomHeader: stickyBottomHeader,
                  minHeight: minHeight,
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
