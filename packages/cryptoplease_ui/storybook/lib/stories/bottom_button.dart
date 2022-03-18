import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpBottomButton = Story(
  name: 'CpBottomButton',
  builder: (context) => Scaffold(
    appBar: CpAppBar(title: const Text('Bottom button')),
    body: Column(
      children: [
        const Expanded(child: Center(child: Text('Crypto Please'))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CpBottomButton(
            text: 'Press me',
            onPressed: context.knobs.boolean(label: 'Enabled', initial: true)
                ? () {}
                : null,
          ),
        ),
      ],
    ),
  ),
);
