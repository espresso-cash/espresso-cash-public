import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/nft/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SendNftFlowScreen extends StatefulWidget {
  const SendNftFlowScreen({
    Key? key,
    required this.nft,
  }) : super(key: key);

  final NonFungibleToken nft;

  @override
  State<SendNftFlowScreen> createState() => _State();
}

class _State extends State<SendNftFlowScreen> implements SendFlowRouter {
  late final NftCreateOutgoingTransferBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NftCreateOutgoingTransferBloc(
      repository: context.read<OutgoingTransferRepository>(),
      balances: context.read<BalancesBloc>().state.balances,
      nft: widget.nft,
    );

    _reset();
  }

  void _reset() => _bloc.add(const NftCreateOutgoingTransferEvent.cleared());

  @override
  void onDirectSelected() {
    _reset();

    context.router.navigate(
      EnterAddressRoute(
        initialAddress: _bloc.state.recipientAddress,
      ),
    );
  }

  @override
  Future<void> onQrCodeSelected() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    _reset();

    request?.maybeMap(
      address: (r) {
        onAddressSubmitted(r.address);
      },
      orElse: () {},
    );
  }

  @override
  void onSplitKeySelected() {
    _reset();

    const event = NftCreateOutgoingTransferEvent.typeUpdated(
      OutgoingTransferType.splitKey,
    );
    _bloc.add(event);

    context.router.navigate(const ConfirmNonFungibleTokenRoute());
  }

  @override
  void onAddressSubmitted(String address) {
    _bloc.add(NftCreateOutgoingTransferEvent.recipientUpdated(address));

    context.router.navigate(const ConfirmNonFungibleTokenRoute());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider.value(value: _bloc),
          Provider<SendFlowRouter>.value(value: this),
        ],
        child: BlocListener<NftCreateOutgoingTransferBloc,
            NftCreateOutgoingTransferState>(
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          listener: (context, state) => state.flow.maybeMap(
            success: (s) {
              context.router.popUntilRoot();
              context.router.navigate(OutgoingTransferFlowRoute(id: s.result));
              context
                  .read<OutgoingTransfersBloc>()
                  .add(OutgoingTransfersEvent.submitted(s.result));
            },
            orElse: ignore,
          ),
          child: const AutoRouter(),
        ),
      );
}
