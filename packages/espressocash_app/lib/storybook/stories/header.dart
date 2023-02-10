import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/header.dart';

final cpHeader = Story(
  name: 'CpHeader',
  builder: (context) => const CpHeader(
    title: 'Popular Crypto',
    subtitle:
        'A fast and easy way to buy and sell\ncrypto anywhere in the world.',
  ),
);
