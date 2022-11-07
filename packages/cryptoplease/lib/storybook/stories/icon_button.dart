import 'package:storybook_flutter/storybook_flutter.dart';

import '../../gen/assets.gen.dart';
import '../../ui/icon_button.dart';

final cpIconButton = Story(
  name: 'CpIconButton',
  builder: (context) => CpIconButton(
    icon: Assets.icons.settingsButtonIcon.svg(),
    onPressed: () {},
  ),
);
