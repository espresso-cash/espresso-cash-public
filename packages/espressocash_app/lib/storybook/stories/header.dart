import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/header.dart';

final cpHeader = Story(
  name: 'CpHeader',
  builder: (context) => CpHeader(
    title: context.knobs.text(label: 'Title', initial: 'Popular Crypto'),
    subtitle: context.knobs.text(
      label: 'Subtitle',
      initial:
          'A fast and easy way to buy and sell\ncrypto anywhere in the world.',
    ),
  ),
);
