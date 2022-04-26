import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/nft/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/enter_address_screen.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NftDirectTransferFlowScreen extends StatefulWidget {
  const NftDirectTransferFlowScreen({
    Key? key,
    required this.onComplete,
    this.initialAddress,
    required this.nft,
  }) : super(key: key);

  final NonFungibleToken nft;
  final String? initialAddress;
  final ValueSetter<OutgoingTransferId> onComplete;

  @override
  State<NftDirectTransferFlowScreen> createState() =>
      _NftDirectTransferFlowScreenState();
}

class _NftDirectTransferFlowScreenState
    extends State<NftDirectTransferFlowScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NftCreateOutgoingTransferBloc(
          repository: context.read<OutgoingTransferRepository>(),
          balances: context.read<BalancesBloc>().state.balances,
          nft: widget.nft,
          transferType: OutgoingTransferType.direct,
        ),
        child: BlocListener<NftCreateOutgoingTransferBloc,
            NftCreateOutgoingTransferState>(
          listener: (context, state) => state.flow.maybeMap(
            success: (s) => widget.onComplete(s.result),
            orElse: ignore,
          ),
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          child: _Content(
            initialAddress: widget.initialAddress,
          ),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({
    Key? key,
    required this.initialAddress,
  }) : super(key: key);

  final String? initialAddress;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> implements RecipientSetter {
  @override
  void initState() {
    super.initState();

    final recipient = widget.initialAddress;
    if (recipient != null) {
      context
          .read<NftCreateOutgoingTransferBloc>()
          .add(NftCreateOutgoingTransferEvent.recipientUpdated(recipient));
    }
  }

  @override
  void onRecipientSet(String recipient) {
    final event = NftCreateOutgoingTransferEvent.recipientUpdated(recipient);
    context.read<NftCreateOutgoingTransferBloc>().add(event);
    context.navigateTo(const NftConfirmRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<RecipientSetter>.value(value: this),
        ],
        child: const AutoRouter(),
      );
}
