part of 'send_flow.dart';

extension SendFtFlowExt on BuildContext {
  void navigateToSendFt(
    Token? token, {
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
  }) =>
      navigateTo(
        PickRecipientTypeRoute(
          onDirectSelected: () => navigateToDirectTransferFt(
            onTransferCreated: navigateToOutgoingTransfer,
            token: token,
          ),
          onLinkSelected: () => _navigateToLinkTransferFt(
            token: token,
            onTransferCreated: navigateToOutgoingTransfer,
          ),
          onQrCodeSelected: () async {
            final request =
                await router.push<QrScannerRequest>(const QrScannerRoute());
            request?.map(
              solanaPay: (r) {
                final request = r.request;
                final token = request.splToken == null
                    ? Token.sol
                    : TokenList().findTokenByMint(request.splToken!.toBase58());

                if (token == null) {
                  showErrorDialog(this, 'Token not found', Exception());

                  return;
                }

                navigateToDirectTransferFt(
                  onTransferCreated: (_) => Navigator.of(this).pop(),
                  token: token,
                  initialAddress: request.recipient.toBase58(),
                  amount: request.amount,
                  memo: memo,
                  reference: reference,
                );
              },
              address: (r) => navigateToDirectTransferFt(
                onTransferCreated: navigateToOutgoingTransfer,
                initialAddress: r.address,
                token: token,
              ),
            );
          },
        ),
      );

  void _navigateToLinkTransferFt({
    required ValueSetter<OutgoingTransferId> onTransferCreated,
    Token? token,
  }) =>
      navigateTo(
        FtLinkTransferFlowRoute(
          onComplete: onTransferCreated,
          token: token,
          children: const [EnterAmountRoute()],
        ),
      );

  void navigateToDirectTransferFt({
    required ValueSetter<OutgoingTransferId> onTransferCreated,
    String? initialAddress,
    Token? token,
    Decimal? amount,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
  }) =>
      navigateTo(
        FtDirectTransferFlowRoute(
          onComplete: onTransferCreated,
          token: token,
          initialAddress: initialAddress,
          amount: amount,
          memo: memo,
          reference: reference,
          children: [
            if (initialAddress == null)
              EnterAddressRoute(initialAddress: null)
            else if (amount == null)
              const EnterAmountRoute()
            else
              const FtConfirmRoute(),
          ],
        ),
      );
}
