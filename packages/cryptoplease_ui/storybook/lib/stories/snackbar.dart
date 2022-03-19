import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpSnackbar = Story(
  name: 'CpSnackbar',
  builder: (context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: const Text('Show custom snackbar'),
          onPressed: () => showCpSnackbar(
            context,
            message: 'Hello world',
            icon: const Icon(Icons.check, color: Colors.white),
          ),
        ),
        ElevatedButton(
          child: const Text('Show error snackbar'),
          onPressed: () => showCpErrorSnackbar(
            context,
            message: 'Something went wrong',
          ),
        ),
      ],
    ),
  ),
);
