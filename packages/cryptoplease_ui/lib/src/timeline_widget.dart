import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
  });

  final List<CpTimelineItem> items;
  final CpTimelineStatus status;

  static const _timelineRadius = Radius.circular(32);
  static const _timelineWidth = 65.0;
  static const _connectorHeight = 57.0;
  static const _connectorWidth = 7.0;
  static const _indicatorSize = 30.0;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _DefaultEmptyWidget();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final tile = items[index];

        final bool isFirst = index == 0;
        final bool isLast = index == items.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildIndicator(isFirst, isLast),
                if (!isLast) _buildConnector(index),
              ],
            ),
            Expanded(child: _buildTileInfo(tile)),
          ],
        );
      },
    );
  }

  Widget _buildTileInfo(CpTimelineItem tile) {
    final subtitle = tile.subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tile.title, style: _titleStyle),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                if (subtitle != null) Text(subtitle, style: _subtitleStyle)
              ],
            ),
          ),
          Text(tile.trailing ?? '', style: _titleStyle)
        ],
      ),
    );
  }

  Widget _buildConnector(int index) {
    Color color = CpColors.darkBackground;

    if (status == CpTimelineStatus.inProgress && index == items.length - 2) {
      color = Colors.white;
    }

    return Container(
      width: _timelineWidth,
      height: _connectorHeight,
      decoration: BoxDecoration(color: status.backgroundColor),
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

  Widget _buildIndicator(bool isFirst, bool isLast) {
    Color color = CpColors.darkBackground;

    if (isLast && status == CpTimelineStatus.inProgress) {
      color = Colors.white;
    }

    return Container(
      width: _timelineWidth,
      decoration: BoxDecoration(
        color: status.backgroundColor,
        border: Border.all(color: status.backgroundColor, width: 2),
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
          child: isLast ? _getIndicatorIcon() : null,
        ),
      ),
    );
  }

  Widget? _getIndicatorIcon() {
    switch (status) {
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

class _DefaultEmptyWidget extends StatelessWidget {
  const _DefaultEmptyWidget();

  @override
  Widget build(BuildContext context) => const CpEmptyMessageWidget(
        message: 'Timeline Empty.',
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
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

const _subtitleStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
