import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

typedef _AnimationTransformer = double Function(double);

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

enum CpTimelineStatus { inProgress, success, failure, neutral }

class CpTimeline extends StatefulWidget {
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
  State<CpTimeline> createState() => _CpTimelineState();
}

class _CpTimelineState extends State<CpTimeline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const animated = true;
    // widget.items.length > 1 && widget.active != widget.items.length - 1;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final isFirst = index == 0;
        final isLast = index == widget.items.length - 1;

        _AnimationTransformer? indicatorTransformer;
        _AnimationTransformer? connectorTransformer;

        if (animated && index == widget.active) {
          indicatorTransformer = _lowerIndicatorTransform;
        } else if (animated && index == widget.active - 1) {
          connectorTransformer = _connectorTransform;
          indicatorTransformer = _upperIndicatorTransform;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _IndicatorBackground(
                  backgroundColor: widget.status.backgroundColor,
                  isFirst: isFirst,
                  isLast: isLast,
                  child: _Animation(
                    center: true,
                    controller: _controller,
                    transformer: indicatorTransformer,
                    child: Container(
                      height: _indicatorSize,
                      width: _indicatorSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index > widget.active
                            ? Colors.white
                            : CpColors.darkBackground,
                      ),
                      child: index >= widget.active ? widget.status.icon : null,
                    ),
                  ),
                ),
                if (!isLast)
                  _ConnectorBackground(
                    backgroundColor: widget.status.backgroundColor,
                    child: _Animation(
                      center: false,
                      controller: _controller,
                      transformer: connectorTransformer,
                      child: Container(
                        height: _connectorHeight,
                        width: _connectorWidth,
                        color: index >= widget.active
                            ? Colors.white
                            : CpColors.darkBackground,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(child: _TileInfo(tile: widget.items[index])),
          ],
        );
      },
    );
  }
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

class _IndicatorBackground extends StatelessWidget {
  const _IndicatorBackground({
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
            : EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: _indicatorSize + _indicatorBounceOffset,
          child: child,
        ),
      );
}

class _ConnectorBackground extends StatelessWidget {
  const _ConnectorBackground({
    Key? key,
    required this.backgroundColor,
    required this.child,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: _timelineWidth,
        height: _connectorHeight,
        decoration: BoxDecoration(color: backgroundColor),
        child: child,
      );
}

class _Animation extends StatefulWidget {
  const _Animation({
    Key? key,
    required this.transformer,
    required this.controller,
    required this.center,
    required this.child,
  }) : super(key: key);

  final AnimationController controller;
  final _AnimationTransformer? transformer;
  final bool center;
  final Widget child;

  @override
  State<_Animation> createState() => _AnimationState();
}

class _AnimationState extends State<_Animation> {
  @override
  Widget build(BuildContext context) {
    final transformer = widget.transformer;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (transformer != null)
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) => Positioned(
              bottom: widget.center ? 0 : null,
              top: widget.controller.value.let(_sinoidal).let(transformer),
              // ignore: avoid-non-null-assertion, child is mandatory for parent
              child: child!,
            ),
            child: widget.child,
          )
        else
          widget.child
      ],
    );
  }
}

double _sinoidal(double value) => sin(2 * pi * value) / 2;

double _connectorTransform(double value) => value * _connectorHeight;

double _lowerIndicatorTransform(double value) =>
    max(0, value) * _indicatorBounceOffset;

double _upperIndicatorTransform(double value) =>
    min(0, value) * _indicatorBounceOffset;

extension on CpTimelineStatus {
  Color get backgroundColor {
    switch (this) {
      case CpTimelineStatus.success:
        return CpColors.successBackgroundColor;
      case CpTimelineStatus.inProgress:
        return CpColors.infoBackgroundColor;
      case CpTimelineStatus.failure:
        return CpColors.errorBackgroundColor;
      case CpTimelineStatus.neutral:
        return CpColors.neutralBackgroundColor;
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
      case CpTimelineStatus.neutral:
        return null;
    }
  }
}

const _titleStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
const _subtitleStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
const _timelineRadius = Radius.circular(32);
const _timelineWidth = 65.0;
const _connectorHeight = 57.0;
const _connectorWidth = 9.0;
const _indicatorSize = 30.0;
const _indicatorBounceOffset = _indicatorSize * 0.3;
