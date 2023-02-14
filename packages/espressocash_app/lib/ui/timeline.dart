import 'dart:async';
import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CpTimelineItem {
  CpTimelineItem({
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String? trailing;
}

enum CpTimelineStatus { inProgress, success, failure }

class CpTimeline extends StatelessWidget {
  const CpTimeline({
    super.key,
    required this.items,
    required this.status,
    required this.active,
  })  : assert(items.length > 0, 'Items must not be empty'),
        assert(
          active >= 0 && active < items.length,
          'Active item must be in range [0, items.length)',
        );

  final List<CpTimelineItem> items;
  final CpTimelineStatus status;
  final int active;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final bool isFirst = index == 0;
          final bool isLast = index == items.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _Border(
                    backgroundColor: status.backgroundColor,
                    isFirst: isFirst,
                    isLast: isLast,
                    child: _Indicator(
                      color: index > active
                          ? Colors.white
                          : CpColors.darkBackground,
                      shouldBounce: active == index,
                      icon: index == active ? status.icon : null,
                    ),
                  ),
                  if (!isLast)
                    _Connector(
                      color: index >= active
                          ? Colors.white
                          : CpColors.darkBackground,
                      backgroundColor: status.backgroundColor,
                      shouldBounce: index < active,
                    ),
                ],
              ),
              Expanded(child: _TileInfo(tile: items[index])),
            ],
          );
        },
      );
}

class _TileInfo extends StatelessWidget {
  const _TileInfo({
    required this.tile,
  });

  final CpTimelineItem tile;

  @override
  Widget build(BuildContext context) {
    final subtitle = tile.subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tile.title, style: _titleStyle),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                if (subtitle != null) Text(subtitle, style: _subtitleStyle)
              ],
            ),
          ),
          Text(tile.trailing ?? '', style: _titleStyle)
        ],
      ),
    );
  }
}

class _Connector extends StatefulWidget {
  const _Connector({
    required this.color,
    required this.backgroundColor,
    required this.shouldBounce,
  });

  final Color color;
  final Color backgroundColor;
  final bool shouldBounce;

  @override
  State<_Connector> createState() => _ConnectorState();
}

class _ConnectorState extends State<_Connector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _completeDuration);
    _updateAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Connector oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation() {
    if (!mounted) return;
    if (!widget.shouldBounce) {
      _controller.reset();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        width: _timelineWidth,
        height: _connectorHeight,
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Positioned(
                top: _controller.value
                    .let(Curves.linear.transform)
                    .let(_transformConnector),
                child: child!,
              ),
              child: Container(
                height: _connectorHeight,
                width: _connectorWidth,
                color: widget.color,
              ),
            ),
          ],
        ),
      );
}

class _Indicator extends StatefulWidget {
  const _Indicator({
    required this.color,
    required this.shouldBounce,
    this.icon,
  });

  final Color color;
  final Widget? icon;
  final bool shouldBounce;

  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _bounceDuration)
      ..addStatusListener(_onAnimationStatusUpdate);
    Future<void>.delayed(
      Duration(
        milliseconds: (_completeDuration.inMilliseconds * 0.25).toInt() -
            _bounceDuration.inMilliseconds,
      ),
    ).then(_updateAnimation);
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_onAnimationStatusUpdate)
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation([_]) {
    if (!mounted) return;
    if (!widget.shouldBounce) return _controller.reset();
    if (_controller.isAnimating) return;

    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void _onAnimationStatusUpdate(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _updateAnimation();
    } else if (status == AnimationStatus.dismissed) {
      final b3 = Duration(
        milliseconds: _completeDuration.inMilliseconds -
            2 * _bounceDuration.inMilliseconds,
      );
      print('I should wait $b3');

      Future<void>.delayed(b3).then(_updateAnimation);
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _indicatorSize + 2 * _indicatorBounceOffset,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Positioned(
                top: _controller.value
                    .let(Curves.bounceInOut.transform)
                    .let(_transformIndicator),
                child: child!,
              ),
              child: Container(
                height: _indicatorSize,
                width: _indicatorSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                ),
                child: widget.icon,
              ),
            ),
          ],
        ),
      );
}

class _Border extends StatelessWidget {
  const _Border({
    Key? key,
    required this.child,
    required this.isFirst,
    required this.backgroundColor,
    required this.isLast,
  }) : super(key: key);

  final Widget child;
  final bool isFirst;
  final Color backgroundColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) => Container(
        width: _timelineWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: backgroundColor, width: 2),
          borderRadius: (isFirst || isLast)
              ? BorderRadius.vertical(
                  top: isFirst ? _timelineRadius : Radius.zero,
                  bottom: isLast ? _timelineRadius : Radius.zero,
                )
              : null,
        ),
        padding: (isFirst || isLast)
            ? EdgeInsets.only(top: isFirst ? 16 : 4, bottom: isLast ? 16 : 4)
            : const EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.zero,
        child: child,
      );
}

extension on CpTimelineStatus {
  Color get backgroundColor {
    switch (this) {
      case CpTimelineStatus.success:
        return CpColors.successBackgroundColor;
      case CpTimelineStatus.inProgress:
        return CpColors.infoBackgroundColor;
      case CpTimelineStatus.failure:
        return CpColors.errorBackgroundColor;
    }
  }

  Widget? get icon {
    switch (this) {
      case CpTimelineStatus.success:
        return const Icon(
          Icons.check,
          color: Colors.white,
          size: 22,
        );
      case CpTimelineStatus.failure:
        return const Icon(
          Icons.close,
          color: Colors.white,
          size: 22,
        );

      case CpTimelineStatus.inProgress:
        return null;
    }
  }
}

double _transformConnector(double value) =>
    sin(2 * pi * value) / 2 * _connectorHeight;

double _transformIndicator(double value) =>
    _indicatorBounceOffset + value * _indicatorBounceOffset;

enum _BounceDirection { none, up, down }

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

const _subtitleStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const _timelineRadius = Radius.circular(32);
const _timelineWidth = 65.0;
const _connectorHeight = 57.0;
const _connectorWidth = 9.0;
const _indicatorSize = 30.0;
const _indicatorBounceOffset = _indicatorSize * 0.1;
const _completeDuration = Duration(seconds: 1);
const _bounceDuration = Duration(milliseconds: 200);
