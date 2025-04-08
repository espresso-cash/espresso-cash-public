import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/text_button.dart';
import '../utils.dart';

final cpTextButton = Story(
  name: 'CpTextButton',
  builder:
      (context) => CpTextButton(
        text: context.knobs.text(label: 'Text', initial: 'Press me'),
        onPressed: context.knobs.boolean(label: 'Enabled', initial: true) ? () {} : null,
        variant: context.knobs.options(
          label: 'Variant',
          initial: CpTextButtonVariant.dark,
          options: CpTextButtonVariant.values.toOptions(),
        ),
      ),
);
