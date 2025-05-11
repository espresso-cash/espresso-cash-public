import 'package:flutter/material.dart';

import 'colors.dart';
import 'info_icon.dart';

enum CpInfoListVariant { light, yellow }

class CpInfoListItem {
  const CpInfoListItem({
    this.variant = CpInfoListVariant.yellow,
    this.title,
    this.subtitle,
    this.trailing,
    this.icon = _defaultIcon,
  });

  final CpInfoListVariant variant;
  final String? title;
  final String? subtitle;
  final String? trailing;
  final Widget icon;
}

class CpInfoList extends StatefulWidget {
  const CpInfoList({super.key, required this.items})
    : assert(items.length > 0, 'Items must not be empty');

  final List<CpInfoListItem> items;

  @override
  State<CpInfoList> createState() => _State();
}

class _State extends State<CpInfoList> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: widget.items.length,
    itemBuilder: (context, index) {
      final isFirst = index == 0;
      final isLast = index == widget.items.length - 1;

      final indicatorColor = widget.items[index].variant.backgroundColor;

      final connectorColor =
          isLast ? indicatorColor : widget.items[index + 1].variant.backgroundColor;

      return Row(
        key: ValueKey(index),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _Indicator(
                isFirst: isFirst,
                isLast: isLast,
                backgroundColor: indicatorColor,
                icon: widget.items[index].icon,
              ),
              if (!isLast) _Connector(color: connectorColor),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isFirst ? 6 : 0),
              child: _TileInfo(tile: widget.items[index]),
            ),
          ),
        ],
      );
    },
  );
}

class _TileInfo extends StatelessWidget {
  const _TileInfo({required this.tile});

  final CpInfoListItem tile;

  @override
  Widget build(BuildContext context) {
    final title = tile.title;
    final subtitle = tile.subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title, style: _titleStyle),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                ],
                if (subtitle != null) Text(subtitle, style: _subtitleStyle),
              ],
            ),
          ),
          Text(tile.trailing ?? '', style: _titleStyle),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.isFirst,
    required this.isLast,
    required this.backgroundColor,
    required this.icon,
  });

  final bool isFirst;
  final bool isLast;
  final Color backgroundColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) => Container(
    width: _timelineWidth,
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: SizedBox(
      height: _indicatorSize,
      child: CircleAvatar(maxRadius: _indicatorSize, backgroundColor: backgroundColor, child: icon),
    ),
  );
}

class _Connector extends StatelessWidget {
  const _Connector({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    height: _connectorHeight,
    width: _connectorWidth,
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(_connectorRadius)),
    ),
  );
}

extension on CpInfoListVariant {
  Color get backgroundColor => switch (this) {
    CpInfoListVariant.yellow => CpColors.infoBackgroundColor,
    CpInfoListVariant.light => CpColors.lightButtonBackgroundColor,
  };
}

const _defaultIcon = CpInfoIcon(height: 16, iconColor: Colors.black);

const _titleStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
const _subtitleStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
const _timelineWidth = 65.0;
const _connectorHeight = 57.0;
const _connectorWidth = 7.0;
const _connectorRadius = 51.0;
const _indicatorSize = 30.0;
