import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

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
          onLinkSelected: () => _launchLinkTransfer(
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

  void navigateToOutgoingTransfer(
    OutgoingTransferId id, {
    GlobalKey<AutoRouterState>? routerKey,
  }) {
    (routerKey?.currentState?.controller ?? router)
      ..popUntilRoot()
      ..navigate(OutgoingTransferFlowRoute(id: id));
    read<OutgoingTransfersBloc>().add(OutgoingTransfersEvent.submitted(id));
  }

  void _launchLinkTransfer({
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
