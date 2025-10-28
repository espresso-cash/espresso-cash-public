import 'package:storybook_flutter/storybook_flutter.dart';

import '../../gen/assets.gen.dart';
import '../../ui/icon_button.dart';
import '../utils.dart';

final cpIconButton = Story(
  name: 'CpIconButton',
  builder: (context) => CpIconButton(
    icon: Assets.icons.settingsButtonIcon.svg(),
    size: context.knobs.options(
      label: 'Size',
      initial: CpIconButtonSize.normal,
      options: CpIconButtonSize.values.toOptions(),
    ),
    variant: context.knobs.options(
      label: 'Variant',
      initial: CpIconButtonVariant.grey,
      options: CpIconButtonVariant.values.toOptions(),
    ),
    onPressed: () {},
  ),
);
