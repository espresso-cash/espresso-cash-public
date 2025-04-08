import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/background_gradient.dart';

final cpBackgroundGradient = Story(
  name: 'CpBackgroundGradient',
  builder:
      (context) => const CpBackgroundGradient(
        child: Center(
          child: Text('Espresso Cash', style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
);
