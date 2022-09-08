import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpInfoWidget = Story(
  name: 'CpInfoWidget',
  builder: (context) => CpContentPadding(
    child: CpInfoWidget(
      icon: const Icon(Icons.info),
      message: Text(
        context.knobs.text(label: 'Message', initial: 'Info message!'),
      ),
    ),
  ),
);
