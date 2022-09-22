import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

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
    this.emptyWidget,
  });

  final List<CpTimelineData> data;
  final Color backgroundColor;
  final Widget? emptyWidget;

  static const _radius = Radius.circular(32);
  static const _timelineWidth = 65.0;
  static const _tileHeight = 60.0;
  static const _connectorHeight = 50.0;
  static const _indicatorSize = 30.0;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return emptyWidget ?? const _DefaultEmptyWidget();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final tile = data[index];

        final bool isFirst = index == 0;
        final bool isLast = index == data.length - 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: _tileHeight,
                  width: _timelineWidth,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: (isFirst || isLast)
                        ? BorderRadius.vertical(
                            top: isFirst ? _radius : Radius.zero,
                            bottom: isLast ? _radius : Radius.zero,
                          )
                        : null,
                  ),
                  padding: (isFirst || isLast)
                      ? EdgeInsets.only(
                          top: isFirst ? 10 : 4,
                          bottom: isLast ? 10 : 4,
                        )
                      : const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: Container(
                      width: _indicatorSize,
                      height: _indicatorSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tile.iconColor ?? CpColors.darkBackground,
                      ),
                      child: tile.icon,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    dense: true,
                    title: Text(
                      tile.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!isLast)
              Container(
                color: backgroundColor,
                padding: EdgeInsets.zero,
                width: _timelineWidth,
                height: _connectorHeight,
                child: Center(
                  child: Container(
                    width: 7,
                    decoration: BoxDecoration(
                      color: tile.connectorColor ?? CpColors.darkBackground,
                      borderRadius: const BorderRadius.vertical(
                        top: _radius,
                        bottom: _radius,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _DefaultEmptyWidget extends StatelessWidget {
  const _DefaultEmptyWidget();

  @override
  Widget build(BuildContext context) => const CpEmptyMessageWidget(
        message: 'Timeline Empty.',
      );
}
