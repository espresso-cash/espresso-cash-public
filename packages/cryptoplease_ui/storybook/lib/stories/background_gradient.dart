import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpBackgroundGradient = Story(
  name: 'CpBackgroundGradient',
  builder: (context) => const CpBackgroundGradient(
    child: Center(
      child: Text(
        'Crypto Please',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  ),
);
