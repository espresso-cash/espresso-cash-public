import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_crypto_header.dart';
import 'package:cryptoplease/storybook/stories/app/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final appPopularCryptoHeader = Story(
  name: 'App/Investments/PopularCryptoHeader',
  builder: (context) => const AppWrapper(
    child: Scaffold(body: Center(child: PopularCryptoHeader())),
  ),
);
