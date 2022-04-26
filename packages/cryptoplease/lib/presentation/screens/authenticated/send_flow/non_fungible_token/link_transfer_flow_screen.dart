import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/nft/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NftLinkTransferFlowScreen extends StatefulWidget {
  const NftLinkTransferFlowScreen({
    Key? key,
    required this.onComplete,
    required this.nft,
  }) : super(key: key);

  final NonFungibleToken nft;
  final ValueSetter<OutgoingTransferId> onComplete;

  @override
  State<NftLinkTransferFlowScreen> createState() =>
      _NftLinkTransferFlowScreenState();
}

class _NftLinkTransferFlowScreenState extends State<NftLinkTransferFlowScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NftCreateOutgoingTransferBloc(
          repository: context.read<OutgoingTransferRepository>(),
          balances: context.read<BalancesBloc>().state.balances,
          nft: widget.nft,
          transferType: OutgoingTransferType.splitKey,
        ),
        child: BlocListener<NftCreateOutgoingTransferBloc,
            NftCreateOutgoingTransferState>(
          listener: (context, state) => state.flow.maybeMap(
            success: (s) => widget.onComplete(s.result),
            orElse: ignore,
          ),
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          child: const _Content(),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) => const AutoRouter();
}
