import 'package:cryptoplease/ui/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpAppBar = Story(
  name: 'CpAppBar',
  builder: (context) => Scaffold(
    appBar: CpAppBar(title: const Text('App bar')),
    body: const Center(
      child: Text('EspressoCash'),
    ),
  ),
);
