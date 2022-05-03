import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

extension SendFtFlowExt on BuildContext {
  /// Navigates to the flow for sending a fungible token.
  ///
  /// It starts with the picking recipient type: direct transfer / link
  /// transfer.
  ///
  /// Passing non-null [token] will "lock" the token selector and prevent the
  /// user from changing it.
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
                final splToken = request.splToken;
                final token = splToken == null
                    ? Token.sol
                    : TokenList().findTokenByMint(splToken.toBase58());

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

  /// Navigate to the flow for sending a fungible token with a link.
  ///
  /// After the outgoing transfer is created, [onTransferCreated] is called.
  ///
  /// Passing non-null [token] will "lock" the token selector and prevent the
  /// user from changing it.
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

  /// Navigate to the flow for sending a fungible token by address.
  ///
  /// After the outgoing transfer is created, [onTransferCreated] is called.
  ///
  /// Passing non-null [token] will "lock" the token selector and prevent the
  /// user from changing it.
  ///
  /// If non-null [initialAddress] is passed, address input screen will be
  /// skipped.
  ///
  /// If non-null [amount] is passed, amount input screen will be skipped.
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
