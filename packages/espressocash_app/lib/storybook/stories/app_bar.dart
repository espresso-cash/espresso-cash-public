import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/app_bar.dart';

final cpAppBar = Story(
  name: 'CpAppBar',
  builder: (context) => Scaffold(
    appBar: CpAppBar(
      title: Text(context.knobs.text(label: 'Title', initial: 'App bar')),
      automaticallyImplyLeading: true,
      leading: context.knobs.options(
        label: 'Leading',
        initial: _leading,
        options: [
          Option(
            label: 'With Leading',
            value: _leading,
          ),
          const Option(label: 'Empty', value: null),
        ],
      ),
      nextButton: context.knobs.options(
        label: 'Next Button',
        initial: _next,
        options: [
          Option(
            label: 'With Next Button',
            value: _next,
          ),
          const Option(label: 'Empty', value: null),
        ],
      ),
    ),
    body: const Center(
      child: Text('Espresso Cash'),
    ),
  ),
);

final _leading = IconButton(
  icon: const Icon(Icons.arrow_back),
  onPressed: () {},
);

final _next = ElevatedButton(onPressed: () {}, child: const Text('Next'));
