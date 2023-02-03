import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'colors.dart';

class CpSlider extends StatefulWidget {
  const CpSlider({
    Key? key,
    required this.text,
    required this.onSlideCompleted,
  }) : super(key: key);

  final String text;
  final VoidCallback? onSlideCompleted;

  @override
  State<CpSlider> createState() => _CpSliderState();
}

class _CpSliderState extends State<CpSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController reverseAnimationController;

  final valueListener = ValueNotifier<double>(.0);
  final reverseAnimation = Tween<double>(end: .0);

  bool hasCompleted = false;
  Curve curve = Curves.bounceInOut;

  @override
  void initState() {
    super.initState();
    reverseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(_reverseListener)
      ..addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    reverseAnimationController
      ..removeListener(_reverseListener)
      ..removeStatusListener(_statusListener)
      ..dispose();
    super.dispose();
  }

  void _onDone() {
    if (hasCompleted) return;
    widget.onSlideCompleted?.call();
    setState(() {
      hasCompleted = true;
      curve = Curves.easeOut;
    });
  }

  void _resetPosition() {
    reverseAnimation.begin = valueListener.value;
    reverseAnimationController
      ..reset()
      ..forward();
  }

  void _reverseListener() {
    valueListener.value = reverseAnimationController.value
        .let(curve.transform)
        .let(reverseAnimation.transform);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        hasCompleted = false;
        curve = Curves.bounceOut;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 65,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxRight = constraints.maxWidth - _controlWidth;

            return Stack(
              children: [
                _Background(text: widget.text),
                AnimatedBuilder(
                  animation: valueListener,
                  builder: (context, child) => Visibility(
                    visible: valueListener.value != 0,
                    child: SizedBox(
                      width: valueListener.value + _controlWidth,
                      child: child,
                    ),
                  ),
                  child: const _ActiveBar(),
                ),
                AnimatedBuilder(
                  animation: valueListener,
                  builder: (context, child) => Positioned.fill(
                    left: valueListener.value,
                    // ignore: avoid-non-null-assertion, child is declared below
                    child: child!,
                  ),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      final value = valueListener.value + details.delta.dx;
                      if (value < 0) return;
                      if (value > maxRight) return _onDone();
                      valueListener.value = value;
                    },
                    onHorizontalDragEnd: (_) => _resetPosition(),
                    child: const _Control(),
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: _controlWidth / 2),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              style: const TextStyle(fontSize: 17, letterSpacing: 0.13),
            ),
          ),
        ),
      );
}

class _ActiveBar extends StatelessWidget {
  const _ActiveBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DecoratedBox(
        decoration: ShapeDecoration(
          color: CpColors.sliderActiveColor,
          shape: StadiumBorder(),
        ),
        child: Center(
          child: SizedBox(width: double.infinity),
        ),
      );
}

class _Control extends StatelessWidget {
  const _Control({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Visibility(
        visible: true,
        child: Assets.animations.slider.rive(
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
      );
}

const _controlWidth = 100.0;
