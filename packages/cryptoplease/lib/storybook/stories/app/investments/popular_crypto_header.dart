import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../../app/screens/authenticated/investments/components/popular_crypto_header.dart';
import '../app_wrapper.dart';

final appPopularCryptoHeader = Story(
  name: 'App/Investments/PopularCryptoHeader',
  builder: (context) => const AppWrapper(
    child: Scaffold(body: Center(child: PopularCryptoHeader())),
  ),
);
