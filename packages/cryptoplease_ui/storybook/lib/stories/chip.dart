import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpChip = Story(
  name: 'CpChip',
  builder: (context) => CpChip(
    padding: context.knobs.options(
      label: 'Padding',
      initial: CpChipPadding.normal,
      options: CpChipPadding.values.toOptions(),
    ),
    child: const Text('Crypto Please'),
  ),
);
