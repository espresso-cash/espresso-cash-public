import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/activity_tile.dart';
import '../../ui/button.dart';

final cpActivityTile = Story(
  name: 'ActivityTile',
  builder: (context) => ActivityTile(
    icon: const Icon(Icons.arrow_circle_down_outlined),
    title: 'Activity Title',
    subtitle: 'Today at 8:14 AM',
    amount: '-10 SOL',
    onTap: () {},
    actions: const [
      CpButton(size: CpButtonSize.micro, text: 'View'),
    ],
  ),
);
