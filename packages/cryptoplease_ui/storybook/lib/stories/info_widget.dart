import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpInfoWidget = Story(
  name: 'CpInfoWidget',
  builder: (context) => const CpInfoWidget(
    icon: Icon(Icons.settings),
    message: 'Info message!',
  ),
);
