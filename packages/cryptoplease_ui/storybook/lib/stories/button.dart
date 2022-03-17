import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpButton = Story(
  name: 'CpButton',
  builder: (context) => CpButton(
    text: context.knobs.text(label: 'Text', initial: 'Press me'),
    onPressed:
        context.knobs.boolean(label: 'Enabled', initial: true) ? () {} : null,
    width: context.knobs.boolean(label: 'Full width', initial: false)
        ? double.infinity
        : null,
    variant: context.knobs.options(
      label: 'Variant',
      initial: CpButtonVariant.dark,
      options: CpButtonVariant.values.toOptions(),
    ),
    size: context.knobs.options(
      label: 'Size',
      initial: CpButtonSize.normal,
      options: CpButtonSize.values.toOptions(),
    ),
  ),
);
