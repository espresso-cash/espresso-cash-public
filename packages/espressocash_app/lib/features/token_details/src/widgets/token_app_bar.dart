import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/tokens/token.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/token_icon.dart';
import '../../../favorite_tokens/widgets/favorite_button.dart';

class TokenAppBar extends StatelessWidget {
  const TokenAppBar({
    Key? key,
    required this.token,
  }) : super(key: key);

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
      color: CpColors.darkBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            _buildIcon(ratio, iconSize),
            _buildText(ratio, iconSize),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _Buttons(token: token),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(double ratio, double iconSize) => Positioned(
        top: (iconSize * ratio) - iconSize,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: ratio,
          child: CpTokenIcon(token: token, size: iconSize),
        ),
      );

  Widget _buildText(double ratio, double iconSize) => Positioned.fill(
        top: iconSize * ratio,
        left: _buttonSize,
        right: _buttonSize,
        child: Center(
          child: FittedBox(
            child: Text(
              token.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => _tokenSize + _minExtent;

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
  const _Buttons({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _minExtent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButton(onPressed: () => context.router.pop()),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FavoriteButton(token: token),
            ),
          ],
        ),
      );
}

const double _tokenSize = 68;
const double _buttonSize = 48;
const double _minExtent = kToolbarHeight; // Default Flutter toolbar height
