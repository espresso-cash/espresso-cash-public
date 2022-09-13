import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpStatus = Story(
  name: 'CpStatusWidget',
  builder: (context) => Container(
    height: 150,
    padding: const EdgeInsets.all(16),
    child: CpStatusWidget(
      title: context.knobs.options(
        label: 'Title',
        initial: null,
        options: const [
          Option(label: 'With title', value: Text('Success!')),
          Option(label: 'Empty', value: null),
        ],
      ),
      content: Text(
        context.knobs
            .text(label: 'Content', initial: 'Your transfer has been sent.'),
      ),
      statusType: context.knobs.options(
        label: 'Type',
        initial: CpStatusType.success,
        options: CpStatusType.values.toOptions(),
      ),
    ),
  ),
);
