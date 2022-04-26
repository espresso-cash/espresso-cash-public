import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/data/api/coingecko_client.dart';
import 'package:cryptoplease/data/conversion_rates_repository.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/token_create_link_content.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';

@GenerateMocks([CoingeckoClient])
void main() {
  testGoldensWidget(
    'Create link with small amount',
    _Wrapper(
      child: TokenCreateLinkContent(
        amount: Amount.sol(value: 10000000),
        fee: Amount.sol(value: 100),
      ),
    ),
  );

  testGoldensWidget(
    'Create link with large amount',
    _Wrapper(
      child: TokenCreateLinkContent(
        amount: Amount.sol(value: 11271827981211),
        fee: Amount.sol(value: 100),
      ),
    ),
  );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ConversionRatesRepository>(
        create: (_) => CoingeckoConversionRatesRepository(
          coingeckoClient: CoingeckoClient(),
        ),
        child: Builder(
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32),
              child: child,
            ),
          ),
        ),
      );
}
