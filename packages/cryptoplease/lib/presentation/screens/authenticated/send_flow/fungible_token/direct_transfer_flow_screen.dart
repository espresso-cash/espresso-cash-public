import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/enter_address_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/enter_amount_screen.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class FtDirectTransferFlowScreen extends StatefulWidget {
  const FtDirectTransferFlowScreen({
    Key? key,
    required this.onComplete,
    this.initialAddress,
    this.token,
    this.amount,
    this.reference,
    this.memo,
  }) : super(key: key);

  final Token? token;
  final String? initialAddress;
  final Decimal? amount;
  final ValueSetter<OutgoingTransferId> onComplete;
  final Iterable<Ed25519HDPublicKey>? reference;
  final String? memo;

  @override
  State<FtDirectTransferFlowScreen> createState() =>
      _FtDirectTransferFlowScreenState();
}

class _FtDirectTransferFlowScreenState
    extends State<FtDirectTransferFlowScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => FtCreateOutgoingTransferBloc(
          repository: context.read<OutgoingTransferRepository>(),
          balances: context.read<BalancesBloc>().state.balances,
          conversionRatesRepository: context.read<ConversionRatesRepository>(),
          userCurrency: context.read<UserPreferences>().fiatCurrency,
          transferType: OutgoingTransferType.direct,
          initialToken: widget.token,
          memo: widget.memo,
          reference: widget.reference,
        ),
        child: BlocListener<FtCreateOutgoingTransferBloc,
            FtCreateOutgoingTransferState>(
          listener: (context, state) => state.flow.maybeMap(
            success: (s) => widget.onComplete(s.result),
            orElse: ignore,
          ),
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          child: _Content(
            initialAddress: widget.initialAddress,
            amount: widget.amount,
          ),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({
    Key? key,
    required this.initialAddress,
    required this.amount,
  }) : super(key: key);

  final String? initialAddress;
  final Decimal? amount;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    implements RecipientSetter, AmountSetter {
  @override
  void initState() {
    super.initState();

    final recipient = widget.initialAddress;
    if (recipient != null) {
      context
          .read<FtCreateOutgoingTransferBloc>()
          .add(FtCreateOutgoingTransferEvent.recipientUpdated(recipient));
    }

    final amount = widget.amount;
    if (amount != null) {
      context
          .read<FtCreateOutgoingTransferBloc>()
          .add(FtCreateOutgoingTransferEvent.tokenAmountUpdated(amount));
    }
  }

  @override
  void onRecipientSet(String recipient) {
    final event = FtCreateOutgoingTransferEvent.recipientUpdated(recipient);
    context.read<FtCreateOutgoingTransferBloc>().add(event);
    context.navigateTo(const EnterAmountRoute());
  }

  @override
  void onAmountSet() {
    context.router.navigate(const FtConfirmRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<RecipientSetter>.value(value: this),
          Provider<AmountSetter>.value(value: this),
        ],
        child: const AutoRouter(),
      );
}
