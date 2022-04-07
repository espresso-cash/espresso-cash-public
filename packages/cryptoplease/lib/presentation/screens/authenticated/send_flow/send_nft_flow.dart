import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

extension SendNftFlowExt on BuildContext {
  void navigateToSendNft(NonFungibleToken token) => navigateTo(
        PickRecipientTypeRoute(
          onDirectSelected: () => _launchDirectTransfer(
            onComplete: _onComplete,
            token: token,
          ),
          onLinkSelected: () => _launchLinkTransfer(
            token: token,
            onComplete: _onComplete,
          ),
          onQrCodeSelected: () async {
            final request =
                await router.push<QrScannerRequest>(const QrScannerRoute());
            request?.map(
              solanaPay: ignore,
              address: (r) => _launchDirectTransfer(
                onComplete: _onComplete,
                token: token,
                initialAddress: r.address,
              ),
            );
          },
        ),
      );

  void _onComplete(OutgoingTransferId id) {
    router
      ..popUntilRoot()
      ..navigate(OutgoingTransferFlowRoute(id: id));
    read<OutgoingTransfersBloc>().add(OutgoingTransfersEvent.submitted(id));
  }

  void _launchLinkTransfer({
    required ValueSetter<OutgoingTransferId> onComplete,
    required NonFungibleToken token,
  }) =>
      navigateTo(
        NftLinkTransferFlowRoute(
          onComplete: onComplete,
          nft: token,
          children: const [NftConfirmRoute()],
        ),
      );

  void _launchDirectTransfer({
    required ValueSetter<OutgoingTransferId> onComplete,
    required NonFungibleToken token,
    String? initialAddress,
  }) =>
      navigateTo(
        NftDirectTransferFlowRoute(
          onComplete: onComplete,
          nft: token,
          initialAddress: initialAddress,
          children: [
            if (initialAddress == null)
              EnterAddressRoute(initialAddress: null)
            else
              const NftConfirmRoute(),
          ],
        ),
      );
}
