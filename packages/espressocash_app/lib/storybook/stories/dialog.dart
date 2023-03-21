import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/dialogs.dart';

final cpDialog = Story(
  name: 'CpDialog',
  builder: (context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: const Text('Show Error Dialog'),
          onPressed: () => showErrorDialog(
            context,
            'Error',
            Exception('Something went wrong'),
          ),
        ),
        ElevatedButton(
          child: const Text('Show Confirmation Dialog'),
          onPressed: () => showConfirmationDialog(
            context,
            title: 'Confirmation',
            message: 'Are you sure you want to do this?',
            onConfirm: () {},
          ),
        ),
        ElevatedButton(
          child: const Text('Show Warning Dialog'),
          onPressed: () => showWarningDialog(
            context,
            title: 'Warning',
            message: 'Are you sure you want to do this?',
          ),
        ),
      ],
    ),
  ),
);
