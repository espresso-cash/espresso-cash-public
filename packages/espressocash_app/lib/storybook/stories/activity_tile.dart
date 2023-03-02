import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/activity_tile.dart';

final cpActivityTile = Story(
  name: 'ActivityTile',
  builder: (context) => CpActivityTile(
    icon: const Icon(Icons.arrow_circle_down_outlined),
    title: 'Activity Title',
    status: CpActivityTileStatus.canceled,
    timestamp: 'Today at 8:14 AM',
    outgoingAmount: '10 SOL',
    onTap: () {},
  ),
);
