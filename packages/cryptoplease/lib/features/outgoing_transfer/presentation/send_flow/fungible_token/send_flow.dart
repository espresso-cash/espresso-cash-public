import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/flow.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_request.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

extension SendFtFlowExt on BuildContext {
  void navigateToLinkConfirmation({
    required CryptoAmount amount,
  }) =>
      navigateTo(
        FtLinkTransferFlowRoute(
          onComplete: _navigateToOutgoingTransfer,
          amount: amount,
          apiVersion: SplitKeyApiVersion.v2,
          children: const [FtConfirmRoute()],
        ),
      );

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
            onTransferCreated: _navigateToOutgoingTransfer,
            token: token,
          ),
          onLinkSelected: () => _navigateToLinkTransferFt(
            token: token,
            onTransferCreated: _navigateToOutgoingTransfer,
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
                onTransferCreated: _navigateToOutgoingTransfer,
                initialAddress: r.address,
                token: token,
              ),
            );
          },
        ),
      );

  void _navigateToOutgoingTransfer(String id) {
    read<HomeRouterKey>().value.currentState?.controller?.popUntilRoot();
    navigateToOutgoingTransfer(id);
  }

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
          apiVersion: SplitKeyApiVersion.v1,
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
          apiVersion: SplitKeyApiVersion.v1,
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
