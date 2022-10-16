import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/info_widget.dart';
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
