import 'package:cryptoplease/storybook/utils.dart';
import 'package:cryptoplease/ui/chip.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpChip = Story(
  name: 'CpChip',
  builder: (context) => CpChip(
    padding: context.knobs.options(
      label: 'Padding',
      initial: CpChipPadding.normal,
      options: CpChipPadding.values.toOptions(),
    ),
    child: const Text('Espresso Cash'),
  ),
);
