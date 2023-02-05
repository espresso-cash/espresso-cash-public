import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
  Curve curve = Curves.bounceOut;

  @override
  void initState() {
    super.initState();
    reverseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
        height: _totalBarHeight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(_radius)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = min(_totalBarWidth, constraints.maxWidth);
              final maxRight = maxWidth - _exposedBarWidth;
              final enabled = widget.onSlideCompleted != null;

              return SizedBox(
                width: maxWidth,
                child: Stack(
                  children: [
                    _Background(
                      text: widget.text,
                      enabled: enabled,
                    ),
                    AnimatedBuilder(
                      animation: valueListener,
                      builder: (context, child) => Positioned(
                        left: _exposedBarPosition(valueListener.value),
                        // ignore: avoid-non-null-assertion, child is declared below
                        child: child!,
                      ),
                      child: AbsorbPointer(
                        absorbing: !enabled,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            final value =
                                valueListener.value + details.delta.dx;
                            if (value < 0) return;
                            if (value > maxRight) return _onDone();
                            valueListener.value = value;
                          },
                          onHorizontalDragEnd: (_) => _resetPosition(),
                          child: _SlideBar(
                            enabled: enabled,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
    required this.text,
    required this.enabled,
  }) : super(key: key);

  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Container(
        color: CpColors.darkBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: _exposedBarWidth / 2),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 0.13,
                fontWeight: FontWeight.w500,
                color: enabled
                    ? Colors.white
                    : CpColors.darkBackgroundDisabledColor,
              ),
            ),
          ),
        ),
      );
}

class _SlideBar extends StatefulWidget {
  const _SlideBar({
    Key? key,
    required this.enabled,
  }) : super(key: key);

  final bool enabled;

  @override
  State<_SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<_SlideBar> {
  SMIInput<bool>? enabledInput;

  void _onInit(Artboard artboard) {
    final ctrl = StateMachineController.fromArtboard(artboard, 'StateMachine');
    if (ctrl == null) return;
    artboard.addController(ctrl..isActive = true);
    final input = ctrl.findInput<bool>('enabled');
    setState(() => enabledInput = input);
    _updateEnabled();
  }

  @override
  void didUpdateWidget(covariant _SlideBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateEnabled();
  }

  void _updateEnabled() => enabledInput?.value = widget.enabled;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: true,
        child: SizedBox(
          width: _totalBarWidth,
          height: _totalBarHeight,
          child: Assets.animations.slider.rive(
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            onInit: _onInit,
          ),
        ),
      );
}

double _exposedBarPosition(double value) =>
    value - _totalBarWidth + _exposedBarWidth;

const _exposedBarWidth = 98.0;
const _totalBarWidth = 500.0;
const _totalBarHeight = 63.0;
const _radius = 40.5;
