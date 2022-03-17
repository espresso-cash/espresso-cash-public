import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpTextField = Story(
  name: 'CpTextField',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(16),
    child: CpTextField(
      border: context.knobs.options(
        label: 'Border',
        initial: CpTextFieldBorder.rounded,
        options: CpTextFieldBorder.values.toOptions(),
      ),
    ),
  ),
);
