import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/back_button.dart';
import '../../ui/colors.dart';
import '../utils.dart';

final cpBackButton = Story(
  name: 'BackButton',
  builder: (context) => Theme(
    data: Theme.of(context).copyWith(
      brightness: context.knobs.options(
        label: 'Brightness',
        options: Brightness.values.toOptions(),
        initial: Brightness.dark,
      ),
    ),
    child: Builder(
      builder: (context) => Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? CpColors.shadowPrimaryColor
            : Colors.white,
        body: const Center(child: CpBackButton()),
      ),
    ),
  ),
);
