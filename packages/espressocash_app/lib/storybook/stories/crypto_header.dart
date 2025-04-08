import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/crypto_header.dart';

final cpCryptoHeader = Story(
  name: 'CpCryptoHeader',
  builder:
      (context) => CpCryptoHeader(
        title: context.knobs.text(label: 'Title', initial: 'Popular Crypto'),
        subtitle: context.knobs.text(
          label: 'Subtitle',
          initial: 'A fast and easy way to buy and sell\ncrypto anywhere in the world.',
        ),
      ),
);
