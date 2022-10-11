import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/conversion_rates_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/module.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/features/add_funds/module.dart';
import 'package:cryptoplease/features/airdrop/module.dart';
import 'package:cryptoplease/features/backup_phrase/module.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/module.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/presentation/pending_iskp_listener.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/module.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/link_listener.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/module.dart';
import 'package:cryptoplease/features/payment_request/module.dart';
import 'package:cryptoplease/features/token_details/module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@immutable
class HomeRouterKey {
  const HomeRouterKey(this.value);

  final GlobalKey<AutoRouterState> value;
}

class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({Key? key}) : super(key: key);

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

            return MultiProvider(
              providers: [
                Provider<MyAccount>.value(value: account),
                const AirdropModule(),
                const BackupPhraseModule(),
                const PaymentRequestModule(),
                const AddFundsModule(),
                _balanceListener,
                Provider<HomeRouterKey>(
                  create: (_) => HomeRouterKey(_homeRouterKey),
                ),
                const ODPModule(),
                const OSKPModule(),
                const ISKPModule(),
                const TokenDetailsModule(),
              ],
              child: ODPLinkListener(
                child: PendingISKPListener(
                  child: AutoRouter(key: _homeRouterKey),
                ),
              ),
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
