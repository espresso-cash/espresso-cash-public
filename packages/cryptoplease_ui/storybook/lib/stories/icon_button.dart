import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpIconButton = Story(
  name: 'CpIconButton',
  builder: (context) => CpIconButton(
    icon: Icons.settings,
    onPressed: () {},
  ),
);
