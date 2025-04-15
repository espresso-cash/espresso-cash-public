import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/button.dart';
import '../../ui/content_padding.dart';
import '../../ui/status_screen.dart';
import '../../ui/status_widget.dart';
import '../utils.dart';

final cpStatusScreen = Story(
  name: 'CpStatusScreen',
  builder:
      (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: StatusScreen(
          title: context.knobs.text(label: 'Title', initial: 'TRANSFER STATUS'),
          statusTitle: context.knobs.options(
            label: 'Status Title',
            initial: const Text('Success!'),
            options: const [
              Option(label: 'With Status title', value: Text('Success!')),
              Option(label: 'Empty', value: null),
            ],
          ),
          statusContent: Text(
            context.knobs.text(label: 'Status Content', initial: 'Your transfer has been sent.'),
          ),
          statusType: context.knobs.options(
            label: 'Type',
            initial: CpStatusType.success,
            options: CpStatusType.values.toOptions(),
          ),
          content: context.knobs.options(
            label: 'Page Content',
            initial: _content,
            options: [
              Option(label: 'With Page content', value: _content),
              const Option(label: 'Empty', value: null),
            ],
          ),
          onBackButtonPressed: context.knobs.options(
            label: 'Back Button',
            initial: () {},
            options: [
              Option(label: 'With Back Button', value: () {}),
              const Option(label: 'Null', value: null),
            ],
          ),
        ),
      ),
);

final _content = CpContentPadding(child: CpButton(text: 'OK', onPressed: () {}));
