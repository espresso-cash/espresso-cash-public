import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/token_create_link_content.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import 'create_link_content_test.mocks.dart';

@GenerateMocks([ConversionRatesRepository])
void main() {
  final repository = MockConversionRatesRepository();

  tearDown(() {
    reset(repository);
  });

  testGoldensWidget(
    'Create link with small amount',
    _Wrapper(
      repository: repository,
      child: TokenCreateLinkContent(
        amount: Amount.sol(value: 10000000),
        fee: Amount.sol(value: 10000),
      ),
    ),
    setUp: () {
      when(
        repository.readRate(Currency.sol, to: Currency.usd),
      ).thenAnswer(
        (_) => Decimal.fromInt(100),
      );
    },
  );

  testGoldensWidget(
    'Create link with large amount',
    _Wrapper(
      repository: repository,
      child: TokenCreateLinkContent(
        amount: Amount.sol(value: 11271827981211),
        fee: Amount.sol(value: 10000),
      ),
    ),
    setUp: () {
      when(
        repository.readRate(Currency.sol, to: Currency.usd),
      ).thenAnswer(
        (_) => Decimal.fromInt(100000),
      );
    },
  );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    Key? key,
    required this.repository,
    required this.child,
  }) : super(key: key);

  final ConversionRatesRepository repository;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ConversionRatesRepository>(
        create: (_) => repository,
        child: Builder(
          builder: (context) => CpTheme.dark(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(32),
                child: child,
              ),
            ),
          ),
        ),
      );
}
