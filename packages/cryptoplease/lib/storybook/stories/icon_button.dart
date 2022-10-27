import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/ui/icon_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpIconButton = Story(
  name: 'CpIconButton',
  builder: (context) => CpIconButton(
    icon: Assets.icons.settingsButtonIcon.svg(),
    onPressed: () {},
  ),
);
