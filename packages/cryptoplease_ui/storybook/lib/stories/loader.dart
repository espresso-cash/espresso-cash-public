import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpLoader = Story(
  name: 'CpLoader',
  builder: (context) => CpLoader(
    isLoading: context.knobs.boolean(label: 'Loading', initial: true),
    child: const Center(child: Text('Crypto Please')),
  ),
);
