import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../gen/assets.gen.dart';
import 'timeline.dart';

class CpAnimatedTimeline extends StatefulWidget {
  const CpAnimatedTimeline({
    super.key,
    required this.items,
    required this.loading,
  }) : assert(items.length > 0, 'Items must not be empty');

  final List<CpTimelineItem> items;
  final bool loading;

  @override
  State<CpAnimatedTimeline> createState() => _CpAnimatedTimelineState();
}

class _CpAnimatedTimelineState extends State<CpAnimatedTimeline> {
  SMIInput<bool>? _loadingInput;

  void _onInit(Artboard artboard) {
    final ctrl = StateMachineController.fromArtboard(artboard, 'StateMachine');
    if (ctrl == null) return;
    artboard.addController(ctrl..isActive = true);
    final input = ctrl.findInput<bool>('loading');
    setState(() => _loadingInput = input);
    _updateLoading();
  }

  @override
  void didUpdateWidget(covariant CpAnimatedTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLoading();
  }

  void _updateLoading() => _loadingInput?.value = widget.loading;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: 268,
            child: Assets.rive.transferProgress.rive(
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
              onInit: _onInit,
            ),
          ),
          Expanded(child: _TileInfo(tile: widget.items.elementAt(0))),
        ],
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

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

const _subtitleStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
