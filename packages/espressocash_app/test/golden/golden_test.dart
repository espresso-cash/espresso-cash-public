import 'package:decimal/decimal.dart';
import 'package:espressocash_app/app/screens/authenticated/wallet_flow/wallet_flow_screen.dart';
import 'package:espressocash_app/core/accounts/bl/account.dart';
import 'package:espressocash_app/core/accounts/bl/ec_wallet.dart';
import 'package:espressocash_app/core/amount.dart';
import 'package:espressocash_app/core/balances/bl/balances_bloc.dart';
import 'package:espressocash_app/core/conversion_rates/bl/conversion_rates_bloc.dart';
import 'package:espressocash_app/core/conversion_rates/bl/repository.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/core/user_preferences.dart';
import 'package:espressocash_app/features/app_lock/src/bl/app_lock_bloc.dart';
import 'package:espressocash_app/features/onboarding/src/widgets/no_email_and_password_screen.dart';
import 'package:espressocash_app/features/sign_in/src/widgets/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import 'golden_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([
  ConversionRatesRepository,
  ConversionRatesBloc,
  BalancesBloc,
  AppLockBloc,
])
void main() {
  testGoldensWidget(
    'Get started screen',
    const GetStartedScreen(isSaga: false),
  );

  testGoldensWidget(
    'No email and password screen',
    const NoEmailAndPasswordScreen(),
  );

  group('HomeScreen', () {
    final conversionRatesRepository = MockConversionRatesRepository();
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
            Provider(create: (_) => UserPreferences()),
            Provider<MyAccount>(
              create: (_) => MyAccount(
                wallet: wallet,
                firstName: 'Test',
                accessMode: const AccessMode.created(),
              ),
            ),
          ],
          child: child,
        );

    setUp(() async {
      wallet = LocalWallet(await Ed25519HDKeyPair.random());

      whenListen(
        balancesBloc,
        initialState: BalancesState(
          balances: {
            Token.usdc: Amount(currency: Currency.usdc, value: 1230000)
          },
        ),
      );
      whenListen(
        conversionRatesBloc,
        initialState: const ConversionRatesState(),
      );
      when(conversionRatesRepository.readRate(any, to: anyNamed('to')))
          .thenReturn(Decimal.one);
      whenListen(
        appLockBloc,
        initialState: const AppLockStateNone(),
      );
    });

    tearDown(() {
      reset(conversionRatesRepository);
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
