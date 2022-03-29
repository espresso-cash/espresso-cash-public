import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpActionSelector = Story(
  name: 'CpActionSelector',
  builder: (context) => CpActionSelector(
    appBarLeading: const BackButton(),
    header: 'Header',
    actions: [
      CpActionSelectorButton(
        text: 'Action 1',
        onPressed: () {},
        help: 'Press this button to select action 1',
      ),
      CpActionSelectorButton(
        text: 'Action 2',
        onPressed: () {},
      ),
      const CpActionSelectorButton(
        text: 'Blocked Action',
        onPressed: null,
      ),
    ],
  ),
);
