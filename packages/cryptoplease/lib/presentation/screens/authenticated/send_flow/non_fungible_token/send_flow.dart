import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

extension SendNftFlowExt on BuildContext {
  /// Navigates to the flow for sending a non-fungible token.
  ///
  /// It starts with the picking recipient type: direct transfer / link
  /// transfer.
  void navigateToSendNft(NonFungibleToken token) => navigateTo(
        PickRecipientTypeRoute(
          onDirectSelected: () => _navigateToDirectTransferNft(
            onTransferCreated: navigateToOutgoingTransfer,
            token: token,
          ),
          onLinkSelected: () => _navigateToLinkTransferNft(
            token: token,
            onTransferCreated: navigateToOutgoingTransfer,
          ),
          onQrCodeSelected: () async {
            final request =
                await router.push<QrScannerRequest>(const QrScannerRoute());
            request?.map(
              solanaPay: ignore,
              address: (r) => _navigateToDirectTransferNft(
                onTransferCreated: navigateToOutgoingTransfer,
                token: token,
                initialAddress: r.address,
              ),
            );
          },
        ),
      );

  /// Navigate to the flow for sending a non-fungible token with a link.
  ///
  /// After the outgoing transfer is created, [onTransferCreated] is called.
  void _navigateToLinkTransferNft({
    required ValueSetter<OutgoingTransferId> onTransferCreated,
    required NonFungibleToken token,
  }) =>
      navigateTo(
        NftLinkTransferFlowRoute(
          onComplete: onTransferCreated,
          nft: token,
          children: const [NftConfirmRoute()],
        ),
      );

  /// Navigate to the flow for sending a non-fungible token by address.
  ///
  /// After the outgoing transfer is created, [onTransferCreated] is called.
  ///
  /// If non-null [initialAddress] is passed, address input screen will be
  /// skipped.
  void _navigateToDirectTransferNft({
    required ValueSetter<OutgoingTransferId> onTransferCreated,
    required NonFungibleToken token,
    String? initialAddress,
  }) =>
      navigateTo(
        NftDirectTransferFlowRoute(
          onComplete: onTransferCreated,
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
