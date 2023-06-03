import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/accounts/bl/accounts_bloc.dart';
import '../../../core/balances/bl/balances_bloc.dart';
import '../../../core/conversion_rates/bl/conversion_rates_bloc.dart';
import '../../../core/conversion_rates/module.dart';
import '../../../core/user_preferences.dart';
import '../../../di.dart';
import '../../../features/activities/module.dart';
import '../../../features/backup_phrase/module.dart';
import '../../../features/favorite_tokens/module.dart';
import '../../../features/incoming_split_key_payments/module.dart';
import '../../../features/investments/module.dart';
import '../../../features/mobile_wallet/module.dart';
import '../../../features/onboarding/module.dart';
import '../../../features/outgoing_direct_payments/module.dart';
import '../../../features/outgoing_split_key_payments/module.dart';
import '../../../features/payment_request/module.dart';
import '../../../features/popular_tokens/module.dart';
import '../../../features/swap/module.dart';

@immutable
class HomeRouterKey {
  const HomeRouterKey(this.value);

  final GlobalKey<AutoRouterState> value;
}

@RoutePage()
class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({super.key});

  @override
  State<AuthenticatedFlowScreen> createState() =>
      _AuthenticatedFlowScreenState();
}

class _AuthenticatedFlowScreenState extends State<AuthenticatedFlowScreen> {
  final _homeRouterKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext _) => MultiProvider(
        providers: [
          Provider<UserPreferences>(create: (_) => UserPreferences()),
          const ConversionRatesModule(),
        ],
        child: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            final account = state.account;
            if (account == null) return Container();

            final mnemonic = loadMnemonic(sl<FlutterSecureStorage>());

            return MultiProvider(
              providers: [
                Provider<MyAccount>.value(value: account),
                BackupPhraseModule(
                  mnemonic: mnemonic,
                ),
                const PaymentRequestModule(),
                _balanceListener,
                Provider<HomeRouterKey>(
                  create: (_) => HomeRouterKey(_homeRouterKey),
                ),
                const ODPModule(),
                const OSKPModule(),
                const ISKPModule(),
                const InvestmentModule(),
                const ActivitiesModule(),
                const FavoriteTokensModule(),
                const SwapModule(),
                const PopularTokensModule(),
                const MobileWalletModule(),
                OnboardingModule(mnemonic: mnemonic),
              ],
              child: AutoRouter(key: _homeRouterKey),
            );
          },
        ),
      );
}

/// Requests conversion rates update whenever the list of user tokens changes.
final _balanceListener = BlocListener<BalancesBloc, BalancesState>(
  listener: (context, state) {
    final currency = context.read<UserPreferences>().fiatCurrency;
    final event = ConversionRatesEvent.refreshRequested(
      currency: currency,
      tokens: state.userTokens,
    );
    context.read<ConversionRatesBloc>().add(event);
  },
  listenWhen: (previous, current) => !setEquals(
    previous.userTokens,
    current.userTokens,
  ),
);
