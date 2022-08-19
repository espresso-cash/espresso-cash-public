import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/conversion_rates_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/module.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/data/transaction/tx_creator_selector.dart';
import 'package:cryptoplease/features/add_funds/module.dart';
import 'package:cryptoplease/features/airdrop/module.dart';
import 'package:cryptoplease/features/backup_phrase/module.dart';
import 'package:cryptoplease/features/nft/bl/nft_collection/bloc.dart';
import 'package:cryptoplease/features/nft/module.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/module.dart';
import 'package:cryptoplease/features/pending_request/presentation/pending_request_listener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

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
                const NftModule(),
                _outgoingTransfersBlocProvider(account),
                PendingRequestListener(routerKey: _homeRouterKey),
                _balanceListener,
                Provider<HomeRouterKey>(
                  create: (_) => HomeRouterKey(_homeRouterKey),
                ),
              ],
              child: AutoRouter(key: _homeRouterKey),
            );
          },
        ),
      );
}

BlocProvider<OutgoingTransfersBloc> _outgoingTransfersBlocProvider(
  MyAccount account,
) =>
    BlocProvider(
      create: (context) => OutgoingTransfersBloc(
        repository: context.read<OutgoingTransferRepository>(),
        solanaClient: context.read<SolanaClient>(),
        account: account,
        txCreatorSelector: context.read<TxCreatorSelector>(),
        balancesBloc: context.read<BalancesBloc>(),
        nftCollectionBloc: context.read<NftCollectionBloc>(),
      ),
    );

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
