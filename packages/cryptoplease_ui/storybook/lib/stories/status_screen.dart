import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpStatusScreen = Story(
  name: 'CpStatusScreen',
  builder: (context) => Padding(
    padding: const EdgeInsets.all(24),
    child: StatusScreen(
      title: context.knobs.text(
        label: 'Title',
        initial: 'TRANSFER STATUS',
      ),
      statusTitle: context.knobs.options(
        label: 'Status Title',
        initial: const Text('Success!'),
        options: const [
          Option(label: 'With Status title', value: Text('Success!')),
          Option(label: 'Empty', value: null),
        ],
      ),
      statusContent: Text(
        context.knobs.text(
          label: 'Status Content',
          initial: 'Your transfer has been sent.',
        ),
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
          Option(
            label: 'With Page content',
            value: _content,
          ),
          const Option(label: 'Empty', value: null),
        ],
      ),
      onBackButtonPressed: context.knobs.options(
        label: 'Back Button',
        initial: () {},
        options: [
          Option(
            label: 'With Back Button',
            value: () {},
          ),
          const Option(label: 'Null', value: null),
        ],
      ),
      backgroundImage: context.knobs.options(
        label: 'Background Image',
        initial: null,
        options: [
          const Option(
            label: 'With Background Image',
            value: Placeholder(color: CpColors.successBackgroundColor),
          ),
          const Option(label: 'Null', value: null),
        ],
      ),
    ),
  ),
);

final _content = CpContentPadding(
  child: CpButton(
    text: 'OK',
    onPressed: () {},
  ),
);
