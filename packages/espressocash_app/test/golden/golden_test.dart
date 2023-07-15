import 'package:decimal/decimal.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/processing_state.dart';
import 'package:espressocash_app/features/accounts/models/account.dart';
import 'package:espressocash_app/features/accounts/models/ec_wallet.dart';
import 'package:espressocash_app/features/app_lock/services/app_lock_bloc.dart';
import 'package:espressocash_app/features/balances/services/balances_bloc.dart';
import 'package:espressocash_app/features/conversion_rates/data/repository.dart';
import 'package:espressocash_app/features/conversion_rates/services/conversion_rates_bloc.dart';
import 'package:espressocash_app/features/onboarding/screens/no_email_and_password_screen.dart';
import 'package:espressocash_app/features/sign_in/screens/get_started_screen.dart';
import 'package:espressocash_app/features/wallet_flow/screens/wallet_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import 'golden_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([
  ConversionRatesBloc,
  BalancesBloc,
  AppLockBloc,
])
void main() {
  testGoldensWidget(
    'Get started screen',
    GetStartedScreen(isSaga: false, onSignInPressed: () {}),
    skip: true, // Need to resolve issues with screenutil
  );

  testGoldensWidget(
    'No email and password screen',
    NoEmailAndPasswordScreen(onDone: () {}),
  );

  group('HomeScreen', () {
    final conversionRatesRepository = FakeRepository();
    final conversionRatesBloc = MockConversionRatesBloc();
    final balancesBloc = MockBalancesBloc();
    final appLockBloc = MockAppLockBloc();

    late ECWallet wallet;

    Widget withProviders(Widget child) => MultiProvider(
          providers: [
            ChangeNotifierProvider<ConversionRatesRepository>.value(
              value: conversionRatesRepository,
            ),
            Provider<ConversionRatesBloc>.value(value: conversionRatesBloc),
            Provider<BalancesBloc>.value(value: balancesBloc),
            Provider<AppLockBloc>.value(value: appLockBloc),
            Provider<MyAccount>(
              create: (_) => MyAccount(
                wallet: wallet,
                accessMode: const AccessMode.created(),
              ),
            ),
          ],
          child: child,
        );

    setUp(() async {
      wallet = LocalWallet(await Ed25519HDKeyPair.random());

      whenListen(balancesBloc, initialState: const BalancesState.none());
      whenListen(
        conversionRatesBloc,
        initialState: const ProcessingStateNone(),
      );
      whenListen(
        appLockBloc,
        initialState: const AppLockStateNone(),
      );
    });

    tearDown(() {
      reset(conversionRatesBloc);
      reset(balancesBloc);
      reset(appLockBloc);
    });

    testGoldensWidget(
      'WalletFlowScreen',
      withProviders(const Scaffold(body: WalletFlowScreen())),
    );
  });
}

class FakeRepository extends Fake implements ConversionRatesRepository {
  @override
  Decimal readRate(CryptoCurrency crypto, {required FiatCurrency to}) =>
      Decimal.one;
}
