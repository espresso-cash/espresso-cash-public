import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/confirm_screen/components/send_token_to_solana_address_content.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import 'send_to_solana_address_content_test.mocks.dart';

@GenerateMocks([ConversionRatesRepository])
void main() {
  final repository = MockConversionRatesRepository();

  tearDown(() {
    reset(repository);
  });
  testGoldensWidget(
    'Send to address with small amount',
    _Wrapper(
      repository: repository,
      child: SendTokenToSolanaAddressContent(
        amount: Amount.sol(value: 10000),
        fee: Amount.sol(value: 100),
        address: 'GKvqsuNcnwWqPzzuhLmGi4rzzh55FhJtGizkhHaEJqiV',
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

  testGoldensWidget(
    'Send to address with large amount',
    _Wrapper(
      repository: repository,
      child: SendTokenToSolanaAddressContent(
        amount: Amount.sol(value: 11271827981211),
        fee: Amount.sol(value: 100),
        address: 'GKvqsuNcnwWqPzzuhLmGi4rzzh55FhJtGizkhHaEJqiV',
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
          builder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32),
              child: child,
            ),
          ),
        ),
      );
}
