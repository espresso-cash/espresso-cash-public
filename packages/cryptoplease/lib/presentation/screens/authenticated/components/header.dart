import 'dart:math' as math;

import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/app_bar.dart';
import 'package:cryptoplease/presentation/screens/authenticated/elements/header_round_button.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    Key? key,
    required this.onSendPressed,
    required this.onReceivePressed,
    required this.onAddFundsPressed,
    required this.balanceWidget,
    this.stickyBottomHeader,
    this.allowBackNavigation = false,
    required this.minHeight,
  }) : super(key: key);

  final VoidCallback onSendPressed;
  final VoidCallback onReceivePressed;
  final VoidCallback? onAddFundsPressed;
  final Widget balanceWidget;
  final bool allowBackNavigation;
  final PreferredSizeWidget? stickyBottomHeader;
  final double minHeight;

  final _buttonRowHeight = 75.0;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        pinned: true,
        delegate: _HomeHeaderDelegate(
          stickyBottomHeader: stickyBottomHeader,
          minHeight: minHeight,
          appBarHeight: kToolbarHeight,
          buttonsHeight: _buttonRowHeight,
          balanceWidget: balanceWidget,
          backButton: allowBackNavigation
              ? BackButton(onPressed: Navigator.of(context).maybePop)
              : null,
          appBarWidget: const HomeScreenAppBar(),
          buttonsWidget: SizedBox(
            height: _buttonRowHeight,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (onAddFundsPressed != null)
                  HomeScreenHeaderRoundButton(
                    label: context.l10n.addFunds,
                    icon: Assets.icons.add,
                    onPressed: onAddFundsPressed!,
                  ),
                HomeScreenHeaderRoundButton(
                  label: context.l10n.send,
                  icon: Assets.icons.send,
                  onPressed: onSendPressed,
                ),
                HomeScreenHeaderRoundButton(
                  label: context.l10n.receive,
                  icon: Assets.icons.receive,
                  onPressed: onReceivePressed,
                ),
              ],
            ),
          ),
        ),
      );
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  _HomeHeaderDelegate({
    required this.backButton,
    required this.balanceWidget,
    required this.buttonsWidget,
    required this.appBarWidget,
    required this.minHeight,
    required this.buttonsHeight,
    required this.appBarHeight,
    required this.stickyBottomHeader,
  });

  final Widget? backButton;
  final Widget balanceWidget;
  final Widget appBarWidget;
  final Widget buttonsWidget;
  final double minHeight;
  final double buttonsHeight;
  final double appBarHeight;
  final PreferredSizeWidget? stickyBottomHeader;

  @override
  double get maxExtent {
    if (stickyBottomHeader == null) {
      return _stackHeight;
    } else {
      return _stackHeight + stickyBottomHeader!.preferredSize.height;
    }
  }

  @override
  double get minExtent {
    if (stickyBottomHeader == null) {
      return minHeight;
    } else {
      return minHeight + stickyBottomHeader!.preferredSize.height;
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
        if (stickyBottomHeader != null) stickyBottomHeader!
      ],
    );
  }

  Widget _buildBackButton() => Positioned(
        top: 4,
        left: 4,
        child: backButton != null ? backButton! : const SizedBox.shrink(),
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
            child: balanceWidget,
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
