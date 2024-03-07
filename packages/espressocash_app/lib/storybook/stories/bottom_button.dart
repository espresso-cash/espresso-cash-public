import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/app_bar.dart';
import '../../ui/bottom_button.dart';

final cpBottomButton = Story(
  name: 'CpBottomButton',
  builder: (context) => Scaffold(
    appBar: const CpAppBar(title: Text('Bottom button')),
    body: Column(
      children: [
        const Expanded(child: Center(child: Text('Espresso Cash'))),
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
