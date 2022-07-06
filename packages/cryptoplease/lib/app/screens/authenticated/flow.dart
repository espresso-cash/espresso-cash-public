import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/app/screens/authenticated/send_flow/fungible_token/send_flow.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/pending_request_bloc/pending_request_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/conversion_rates_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/module.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/features/airdrop/module.dart';
import 'package:cryptoplease/features/backup_phrase/module.dart';
import 'package:cryptoplease/features/nft/bl/nft_collection/bloc.dart';
import 'package:cryptoplease/features/nft/module.dart';
import 'package:cryptoplease/features/payment_request/module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

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
                AirdropModule(
                  onAirdropCompleted: () => context
                      .read<BalancesBloc>()
                      .add(BalancesEvent.requested(address: account.address)),
                  account: account.publicKey,
                ),
                const BackupPhraseModule(),
                const PaymentRequestModule(),
                const NftModule(),
                _outgoingTransfersBlocProvider(account),
              ],
              child: Nested(
                children: [
                  _PendingRequestListener(routerKey: _homeRouterKey),
                  _balanceListener,
                ],
                child: AutoRouter(key: _homeRouterKey),
              ),
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

/// {@template _PendingRequestListener}
/// Listens for the Solana Pay request from the deep link and launches the
/// corresponding flow.
/// {@endtemplate}
class _PendingRequestListener extends SingleChildStatefulWidget {
  /// {@macro _PendingRequestListener}
  const _PendingRequestListener({
    Key? key,
    Widget? child,
    required this.routerKey,
  }) : super(key: key, child: child);

  final GlobalKey<AutoRouterState> routerKey;

  @override
  State<_PendingRequestListener> createState() =>
      _PendingRequestListenerState();
}

class _PendingRequestListenerState
    extends SingleChildState<_PendingRequestListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForPendingRequest(context.read<PendingRequestBloc>().state.request);
    });
  }

  void _checkForPendingRequest(SolanaPayRequest? request) {
    if (request == null) return;

    final token = request.token(TokenList());
    if (token == null) return;

    context.navigateToDirectTransferFt(
      onTransferCreated: (id) => context.navigateToOutgoingTransfer(
        id,
        routerKey: widget.routerKey,
      ),
      initialAddress: request.recipient.toBase58(),
      token: token,
      amount: request.amount,
      memo: request.memo,
      reference: request.reference,
    );
    context
        .read<PendingRequestBloc>()
        .add(const PendingRequestEvent.consumed());
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<PendingRequestBloc, PendingRequestState>(
        listener: (context, state) => _checkForPendingRequest(state.request),
        listenWhen: (s1, s2) => s1.request != s2.request,
        child: child,
      );
}
