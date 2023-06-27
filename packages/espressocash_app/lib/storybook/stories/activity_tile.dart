import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../features/activities/widgets/activity_tile.dart';
import '../utils.dart';

final cpActivityTile = Story(
  name: 'ActivityTile',
  builder: (context) => CpActivityTile(
    icon: const Icon(Icons.arrow_circle_down_outlined),
    title: context.knobs.text(label: 'Title', initial: 'Activity Title'),
    status: context.knobs.options(
      label: 'Status',
      initial: CpActivityTileStatus.success,
      options: CpActivityTileStatus.values.toOptions(),
    ),
    timestamp: 'Today at 8:14 AM',
    outgoingAmount: '10 SOL',
    onTap: () {},
  ),
);
