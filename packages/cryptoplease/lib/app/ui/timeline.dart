import 'package:cryptoplease/app/ui/colors.dart';
import 'package:flutter/material.dart';

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
                  _Indicator(
                    color:
                        index > active ? Colors.white : CpColors.darkBackground,
                    backgroundColor: status.backgroundColor,
                    isFirst: isFirst,
                    isLast: isLast,
                    icon: index == active ? status.icon : null,
                  ),
                  if (!isLast)
                    _Connector(
                      color: index >= active
                          ? Colors.white
                          : CpColors.darkBackground,
                      backgroundColor: status.backgroundColor,
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

class _Connector extends StatelessWidget {
  const _Connector({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => Container(
        width: _timelineWidth,
        height: _connectorHeight,
        decoration: BoxDecoration(color: backgroundColor),
        child: Center(
          child: Container(
            width: _connectorWidth,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: _timelineRadius,
                bottom: _timelineRadius,
              ),
            ),
          ),
        ),
      );
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.color,
    required this.backgroundColor,
    required this.isFirst,
    required this.isLast,
    this.icon,
  });

  final Color color;
  final Color backgroundColor;
  final bool isFirst;
  final bool isLast;
  final Widget? icon;

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
            ? EdgeInsets.only(
                top: isFirst ? 16 : 4,
                bottom: isLast ? 16 : 4,
              )
            : const EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.zero,
        child: Center(
          child: Container(
            width: _indicatorSize,
            height: _indicatorSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: icon,
          ),
        ),
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
const _connectorWidth = 7.0;
const _indicatorSize = 30.0;
