import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../gen/assets.gen.dart';
import 'colors.dart';

class CpSlider extends StatefulWidget {
  const CpSlider({
    super.key,
    required this.text,
    required this.onSlideCompleted,
  });

  final String text;
  final VoidCallback? onSlideCompleted;

  @override
  State<CpSlider> createState() => _CpSliderState();
}

class _CpSliderState extends State<CpSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _reverseAnimationController;

  final _positionNotifier = ValueNotifier<double>(.0);
  final _reverseAnimation = Tween<double>(end: .0);

  bool _hasCompleted = false;
  Curve _curve = Curves.bounceOut;

  @override
  void initState() {
    super.initState();
    _reverseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(_reverseListener)
      ..addStatusListener(_statusListener);
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _reverseAnimationController
      ..removeListener(_reverseListener)
      ..removeStatusListener(_statusListener)
      ..dispose();
    super.dispose();
  }

  void _onDone() {
    if (_hasCompleted) return;
    widget.onSlideCompleted?.call();
    setState(() {
      _hasCompleted = true;
      _curve = Curves.easeOut;
    });
  }

  void _resetPosition() {
    _reverseAnimation.begin = _positionNotifier.value;
    _reverseAnimationController
      ..reset()
      ..forward();
  }

  void _reverseListener() {
    _positionNotifier.value = _reverseAnimationController.value
        .let(_curve.transform)
        .let(_reverseAnimation.transform);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _hasCompleted = false;
        _curve = Curves.bounceOut;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _maxBarHeight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(_radius)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = min(_maxBarWidth, constraints.maxWidth);
              final maxSlideWidth = maxWidth - _minBarWidth;
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
                      animation: _positionNotifier,
                      builder: (context, child) => Positioned(
                        left: _exposedBarPosition(_positionNotifier.value),
                        // ignore: avoid-non-null-assertion, child is declared below
                        child: child!,
                      ),
                      child: AbsorbPointer(
                        absorbing: !enabled,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            final value =
                                _positionNotifier.value + details.delta.dx;
                            if (value < 0) return;
                            if (value > maxSlideWidth) return _onDone();
                            _positionNotifier.value = value;
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
    required this.text,
    required this.enabled,
  });

  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: CpColors.darkBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: _minBarWidth / 2),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 0.13,
                fontWeight: FontWeight.w500,
                color: enabled ? Colors.white : CpColors.sliderDisabledColor,
              ),
            ),
          ),
        ),
      );
}

class _SlideBar extends StatefulWidget {
  const _SlideBar({
    required this.enabled,
  });

  final bool enabled;

  @override
  State<_SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<_SlideBar> {
  SMIInput<bool>? _enabledInput;

  void _onInit(Artboard artboard) {
    final ctrl = StateMachineController.fromArtboard(artboard, 'StateMachine');
    if (ctrl == null) return;
    artboard.addController(ctrl..isActive = true);
    final input = ctrl.findInput<bool>('enabled');
    setState(() => _enabledInput = input);
    _updateEnabled();
  }

  @override
  void didUpdateWidget(covariant _SlideBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateEnabled();
  }

  void _updateEnabled() => _enabledInput?.value = widget.enabled;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: _maxBarWidth,
        height: _maxBarHeight,
        child: Assets.rive.slider.rive(
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          onInit: _onInit,
        ),
      );
}

double _exposedBarPosition(double value) => value - _maxBarWidth + _minBarWidth;

const _minBarWidth = 98.0;
const _maxBarWidth = 500.0;
const _maxBarHeight = 63.0;
const _radius = 40.5;
