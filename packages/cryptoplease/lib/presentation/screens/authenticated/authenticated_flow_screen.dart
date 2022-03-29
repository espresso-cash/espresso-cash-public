import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/airdrop/airdrop_bloc.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/conversion_rates_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/nft/nft_collection/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/puzzle_reminder/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({Key? key}) : super(key: key);

  @override
  _AuthenticatedFlowScreenState createState() =>
      _AuthenticatedFlowScreenState();
}

class _AuthenticatedFlowScreenState extends State<AuthenticatedFlowScreen> {
  final _homeRouterKey = GlobalKey<AutoRouterState>();

  @override
  void initState() {
    super.initState();

    context
        .read<PuzzleReminderBloc>()
        .add(const PuzzleReminderEvent.checkRequested());
  }

  void _showPuzzleReminderDialog() {
    final router = _homeRouterKey.currentState?.controller;
    router?.push(const PuzzleReminderRoute());
  }

  @override
  Widget build(BuildContext _) => MultiProvider(
        providers: [
          Provider<UserPreferences>(create: (_) => UserPreferences()),
          _conversionRatesBlocProvider(),
        ],
        child: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            final account = state.account;
            if (account == null) return Container();

            return MultiProvider(
              providers: [
                Provider<MyAccount>.value(value: account),
                _airdropBlocProvider(account),
                _nftCollectionBlocProvider(account),
                _outgoingTransfersBlocProvider(account),
              ],
              child: Nested(
                children: [
                  BlocListener<PuzzleReminderBloc, PuzzleReminderState>(
                    listener: (context, state) {
                      if (state is PuzzleReminderStateRemindNow) {
                        _showPuzzleReminderDialog();
                      }
                    },
                  ),
                  _balanceListener,
                ],
                child: AutoRouter(key: _homeRouterKey),
              ),
            );
          },
        ),
      );
}

BlocProvider<ConversionRatesBloc> _conversionRatesBlocProvider() =>
    BlocProvider(
      create: (context) => ConversionRatesBloc(
        repository: context.read<ConversionRatesRepository>(),
      ),
    );

BlocProvider<AirdropBloc> _airdropBlocProvider(MyAccount account) =>
    BlocProvider(
      create: (context) => AirdropBloc(
        solanaClient: context.read<SolanaClient>(),
        balancesBloc: context.read<BalancesBloc>(),
        account: account,
      ),
    );

BlocProvider<OutgoingTransfersBloc> _outgoingTransfersBlocProvider(
  MyAccount account,
) =>
    BlocProvider(
      create: (context) => OutgoingTransfersBloc(
        repository: context.read<OutgoingTransferRepository>(),
        solanaClient: context.read<SolanaClient>(),
        account: account,
        balancesBloc: context.read<BalancesBloc>(),
        nftCollectionBloc: context.read<NftCollectionBloc>(),
      ),
    );

BlocProvider<NftCollectionBloc> _nftCollectionBlocProvider(MyAccount account) =>
    BlocProvider(
      create: (context) => NftCollectionBloc(
        solanaClient: context.read<SolanaClient>(),
        account: account,
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
