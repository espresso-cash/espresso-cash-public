import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpStatus = Story(
  name: 'CpStatusWidget',
  builder: (context) => Container(
    height: 100,
    padding: const EdgeInsets.all(16),
    child: const CpStatusWidget(
      backgroundColor: Colors.green,
      child: Text('Success!'),
    ),
  ),
);
