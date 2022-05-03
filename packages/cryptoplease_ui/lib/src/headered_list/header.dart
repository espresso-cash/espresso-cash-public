import 'dart:math' as math;

import 'package:cryptoplease_ui/src/app_bar.dart';
import 'package:flutter/material.dart';

class HeaderedListHeader extends StatelessWidget {
  const HeaderedListHeader({
    Key? key,
    required this.child,
    this.stickyBottomHeader,
    this.allowBackNavigation = false,
    required this.minHeight,
    required this.buttons,
    required this.appBar,
  }) : super(key: key);

  final Widget child;
  final bool allowBackNavigation;
  final PreferredSizeWidget? stickyBottomHeader;
  final double minHeight;
  final List<Widget> buttons;
  final Widget appBar;

  final _buttonRowHeight = 75.0;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        pinned: true,
        delegate: _HeaderDelegate(
          stickyBottomHeader: stickyBottomHeader,
          minHeight: minHeight,
          appBarHeight: kToolbarHeight,
          buttonsHeight: _buttonRowHeight,
          child: child,
          backButton: allowBackNavigation
              ? BackButton(onPressed: Navigator.of(context).maybePop)
              : null,
          appBarWidget: CpAppBar(
            automaticallyImplyLeading: false,
            title: Center(child: appBar),
          ),
          buttonsWidget: SizedBox(
            height: _buttonRowHeight,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
          ),
        ),
      );
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({
    required this.backButton,
    required this.buttonsWidget,
    required this.appBarWidget,
    required this.minHeight,
    required this.buttonsHeight,
    required this.appBarHeight,
    required this.stickyBottomHeader,
    required this.child,
  });

  final Widget? backButton;
  final Widget child;
  final Widget appBarWidget;
  final Widget buttonsWidget;
  final double minHeight;
  final double buttonsHeight;
  final double appBarHeight;
  final PreferredSizeWidget? stickyBottomHeader;

  @override
  double get maxExtent {
    final stickyBottomHeader = this.stickyBottomHeader;
    if (stickyBottomHeader == null) {
      return _stackHeight;
    } else {
      return _stackHeight + stickyBottomHeader.preferredSize.height;
    }
  }

  @override
  double get minExtent {
    final stickyBottomHeader = this.stickyBottomHeader;
    if (stickyBottomHeader == null) {
      return minHeight;
    } else {
      return minHeight + stickyBottomHeader.preferredSize.height;
    }
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final percent = math.min(shrinkOffset / (_stackHeight - minHeight), 1.0);
    final topOffset = 0 - percent * 2 * minHeight;
    final bottomOpacity = Curves.easeInExpo.transform(1 - percent);
    final topDisplacement = math.max(topOffset + appBarHeight, 0.0);
    final bottomDisplacement = buttonsHeight +
        _buttonBottomOffset -
        (1 - bottomOpacity) * (buttonsHeight + _buttonBottomOffset);
    final stickyBottomHeader = this.stickyBottomHeader;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                _buildAppBar(topOffset),
                _buildBalance(percent, topDisplacement, bottomDisplacement),
                _buildButtons(bottomOpacity),
                _buildBackButton(),
              ],
            ),
          ),
        ),
        if (stickyBottomHeader != null) stickyBottomHeader
      ],
    );
  }

  Widget _buildBackButton() => Positioned(
        top: 4,
        left: 4,
        child: backButton ?? const SizedBox.shrink(),
      );

  Widget _buildAppBar(double top) => Positioned.fill(
        top: top,
        child: appBarWidget,
      );

  Widget _buildBalance(double percent, double top, double bottom) => Positioned(
        top: top,
        right: 0,
        left: 0,
        bottom: bottom,
        child: Center(
          child: Transform.scale(
            scale: 1 - math.min(percent, 0.5),
            child: child,
          ),
        ),
      );

  Widget _buildButtons(double opactity) => Positioned(
        bottom: _buttonBottomOffset,
        right: 0,
        left: 0,
        child: Opacity(
          opacity: opactity,
          child: buttonsWidget,
        ),
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

const double _buttonBottomOffset = 16;
const double _stackHeight = 300;
