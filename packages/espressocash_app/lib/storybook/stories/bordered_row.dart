import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/bordered_row.dart';

final cpBorderedRow = Story(
  name: 'CpBorderedRow',
  builder: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CpBorderedRow(
          title: Text('Title'),
          content: Text('Regular Content'),
        ),
        CpBorderedRow(
          title: Text('Title'),
          content: BorderedRowChip(
            child: Text('Chip Content'),
          ),
        ),
      ],
    ),
  ),
);
