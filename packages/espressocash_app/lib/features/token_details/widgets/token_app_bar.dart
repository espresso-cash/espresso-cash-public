// ignore_for_file: avoid-single-child-column-or-row

import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class TokenAppBar extends StatelessWidget {
  const TokenAppBar({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        pinned: true,
        delegate: _TokenAppBarDelegate(token),
      );
}

class _TokenAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _TokenAppBarDelegate(this.token);

  final Token token;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    /// Scroll ratio, should vary between [0,1] from expanded to collapsed.
    final ratio = (shrinkOffset / maxExtent)
        .let(Curves.ease.transform)
        .let((it) => 1 - it);
    final iconSize = max(_tokenSize * ratio, 24.0);

    return Material(
      color: CpColors.darkGoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Stack(
          children: [
            _buildIcon(ratio, iconSize),
            _buildText(ratio, iconSize),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _Buttons(
                token: token,
                opacity: ratio,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(double ratio, double iconSize) => Positioned(
        top: (iconSize * ratio) - iconSize + 10,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: ratio,
          child: TokenIcon(token: token, size: iconSize),
        ),
      );

  Widget _buildText(double ratio, double iconSize) => Positioned.fill(
        top: iconSize * ratio + 16,
        left: _buttonSize,
        right: _buttonSize,
        child: Center(
          child: FittedBox(
            child: Text(
              '${token.name} (${token.symbol})',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => _tokenSize + (_minExtent - 20);

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _TokenAppBarDelegate oldDelegate) =>
      oldDelegate.token != token;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.token, required this.opacity});

  final Token token;
  final double opacity;

  @override
  Widget build(BuildContext context) => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _minExtent,
            child: CpBackButton(),
          ),
        ],
      );
}

const double _tokenSize = 68;
const double _buttonSize = 48;
const double _minExtent = kToolbarHeight;
