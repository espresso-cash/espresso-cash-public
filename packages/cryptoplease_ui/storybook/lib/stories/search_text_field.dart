import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpSearchTextField = Story(
  name: 'CpSearchTextField',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: CpSearchTextField(
      label: 'Search',
      onClear: null,
      onSearch: print,
      variant: context.knobs.options(
        label: 'Variant',
        initial: CpSearchTextVariant.dark,
        options: CpSearchTextVariant.values.toOptions(),
      ),
    ),
  ),
);
