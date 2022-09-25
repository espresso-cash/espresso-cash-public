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

  static const _radius = Radius.circular(32);
  static const _timelineWidth = 65.0;
  static const _tileHeight = 60.0;
  static const _connectorHeight = 50.0;
  static const _indicatorSize = 30.0;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _DefaultEmptyWidget();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      addRepaintBoundaries: false,
      clipBehavior: Clip.antiAlias,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final tile = items[index];

        final bool isFirst = index == 0;
        final bool isLast = index == items.length - 1;

        return Container(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildIndicator(isFirst, isLast),
                  Expanded(child: _buildTileInfo(tile)),
                ],
              ),
              if (!isLast) _buildConnector(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTileInfo(CpTimelineItem tile) {
    final subtitle = tile.subtitle;

    return ListTile(
      dense: true,
      title: Text(tile.title, style: _titleStyle),
      subtitle: subtitle != null ? Text(subtitle, style: _subtitleStyle) : null,
      trailing: Text(tile.trailing ?? '', style: _titleStyle),
    );
  }

  Widget _buildConnector() => Container(
        width: _timelineWidth,
        height: _connectorHeight,
        decoration: BoxDecoration(
          color: status.backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(color: status.backgroundColor, width: 4),
          ),
        ),
        child: Center(
          child: Container(
            width: 7,
            decoration: const BoxDecoration(
              color: CpColors.darkBackground,
              borderRadius: BorderRadius.vertical(
                top: _radius,
                bottom: _radius,
              ),
            ),
          ),
        ),
      );

  Widget _buildIndicator(bool isFirst, bool isLast) => Container(
        height: _tileHeight,
        width: _timelineWidth,
        decoration: BoxDecoration(
          color: status.backgroundColor,
          border: Border.all(color: status.backgroundColor, width: 2),
          borderRadius: (isFirst || isLast)
              ? BorderRadius.vertical(
                  top: isFirst ? _radius : Radius.zero,
                  bottom: isLast ? _radius : Radius.zero,
                )
              : null,
        ),
        padding: (isFirst || isLast)
            ? EdgeInsets.only(top: isFirst ? 10 : 0, bottom: isLast ? 10 : 0)
            : EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Center(
          child: Container(
            width: _indicatorSize,
            height: _indicatorSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CpColors.darkBackground,
            ),
            child: isLast ? _getIndicatorIcon() : null,
          ),
        ),
      );

  Widget? _getIndicatorIcon() {
    switch (status) {
      case CpTimelineStatus.success:
        return const Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        );
      case CpTimelineStatus.failure:
        return const Icon(
          Icons.close,
          color: Colors.white,
          size: 18,
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
