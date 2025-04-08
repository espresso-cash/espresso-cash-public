import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/chip.dart';
import '../utils.dart';

final cpChip = Story(
  name: 'CpChip',
  builder:
      (context) => CpChip(
        padding: context.knobs.options(
          label: 'Padding',
          initial: CpChipPadding.normal,
          options: CpChipPadding.values.toOptions(),
        ),
        child: const Text('Espresso Cash'),
      ),
);
