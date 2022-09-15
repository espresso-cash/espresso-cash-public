import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class CpTimelineData {
  CpTimelineData({
    required this.title,
    this.subtitle,
    this.trailing,
    this.icon,
    this.iconColor,
    this.connectorColor,
  });

  final String title;
  final String? subtitle;
  final String? trailing;
  final Widget? icon;
  final Color? iconColor;
  final Color? connectorColor;
}

class CpTimelineWidget extends StatelessWidget {
  const CpTimelineWidget({
    super.key,
    required this.data,
    required this.backgroundColor,
  });

  final List<CpTimelineData> data;
  final Color backgroundColor;

  static const _radius = Radius.circular(32);

  @override
  Widget build(BuildContext context) => Timeline.tileBuilder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        theme: TimelineThemeData(
          nodePosition: 0,
          indicatorTheme: const IndicatorThemeData(size: 30),
        ),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, index) {
            final tile = data[index];

            return ListTile(
              title: Text(
                tile.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: tile.subtitle != null
                  ? Text(
                      tile.subtitle ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )
                  : null,
              trailing: Text(
                tile.trailing ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          },
          connectorBuilder: (_, index, type) {
            final tile = data[index];

            final bool isStart = type == ConnectorType.start;

            return Container(
              color: backgroundColor,
              width: 65,
              child: DecoratedLineConnector(
                thickness: 7,
                indent: 0,
                decoration: BoxDecoration(
                  color: tile.connectorColor ?? CpColors.darkBackground,
                  borderRadius: BorderRadius.vertical(
                    top: isStart ? Radius.zero : _radius,
                    bottom: !isStart ? Radius.zero : _radius,
                  ),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            final tile = data[index];

            final bool isFirst = index == 0;
            final bool isLast = index == data.length - 1;

            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: (isFirst || isLast)
                    ? BorderRadius.vertical(
                        top: isFirst ? _radius : Radius.zero,
                        bottom: isLast ? _radius : Radius.zero,
                      )
                    : null,
              ),
              width: 65,
              padding: (isFirst || isLast)
                  ? EdgeInsets.only(
                      top: isFirst ? 20 : 4,
                      bottom: isLast ? 20 : 4,
                    )
                  : const EdgeInsets.symmetric(vertical: 4),
              child: DotIndicator(
                color: tile.iconColor ?? CpColors.darkBackground,
                child: tile.icon,
              ),
            );
          },
          itemExtentBuilder: (_, __) => 90,
          itemCount: data.length,
        ),
      );
}
