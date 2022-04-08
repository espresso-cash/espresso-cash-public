part of 'send_flow.dart';

extension SendNftFlowExt on BuildContext {
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
