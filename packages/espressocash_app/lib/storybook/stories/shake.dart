import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/button.dart';
import '../../ui/shake.dart';

final cpShake = Story(
  name: 'CpShake',
  builder: (context) {
    final shakeKey = GlobalKey<ShakeState>();

    return Center(
      child: Shake(
        key: shakeKey,
        child: CpButton(
          text: 'Press to Shake',
          size: CpButtonSize.big,
          onPressed: () {
            shakeKey.currentState?.shake();
          },
        ),
      ),
    );
  },
);
