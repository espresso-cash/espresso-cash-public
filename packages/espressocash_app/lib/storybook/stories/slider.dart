import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/slider.dart';
import '../../ui/snackbar.dart';

final cpSlider = Story(
  name: 'CpSlider',
  builder:
      (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CpSlider(
            text: context.knobs.text(label: 'Text', initial: 'Slide me'),
            onSlideCompleted:
                context.knobs.boolean(label: 'Enabled', initial: true)
                    ? () => showCpSnackbar(context, message: 'Slide completed!')
                    : null,
          ),
        ),
      ),
);
