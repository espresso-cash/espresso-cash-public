import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpAppBar = Story(
  name: 'CpAppBar',
  builder: (context) => Scaffold(
    appBar: CpAppBar(
      title: const Text('App bar'),
      hasBorder: context.knobs.boolean(label: 'Has border'),
    ),
    body: const Center(
      child: Text('Crypto Please'),
    ),
  ),
);
