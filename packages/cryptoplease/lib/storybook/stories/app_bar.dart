import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/app_bar.dart';

final cpAppBar = Story(
  name: 'CpAppBar',
  builder: (context) => Scaffold(
    appBar: CpAppBar(title: const Text('App bar')),
    body: const Center(
      child: Text('Espresso Cash'),
    ),
  ),
);
