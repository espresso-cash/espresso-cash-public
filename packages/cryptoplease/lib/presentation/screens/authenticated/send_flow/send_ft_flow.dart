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

extension SendFtFlowExt on BuildContext {
  void navigateToSendFungibleToken(Token? token) => navigateTo(
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
            request?.map<void>(
              solanaPay: (r) {
                final request = r.request;
                final token = request.splToken == null
                    ? Token.sol
                    : TokenList().findTokenByMint(request.splToken!.toBase58());

                if (token == null) {
                  showErrorDialog(this, 'Token not found', Exception());

                  return;
                }

                _launchDirectTransfer(
                  onComplete: (_) => Navigator.of(this).pop(),
                  token: token,
                  initialAddress: request.recipient.toBase58(),
                  amount: request.amount,
                );
              },
              address: (r) => _launchDirectTransfer(
                onComplete: _onComplete,
                initialAddress: r.address,
                token: token,
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
    Token? token,
  }) =>
      navigateTo(
        LinkTransferFlowRoute(
          onComplete: onComplete,
          token: token,
          children: const [EnterAmountRoute()],
        ),
      );

  void _launchDirectTransfer({
    required ValueSetter<OutgoingTransferId> onComplete,
    String? initialAddress,
    Token? token,
    Decimal? amount,
  }) =>
      navigateTo(
        DirectTransferFlowRoute(
          onComplete: onComplete,
          token: token,
          initialAddress: initialAddress,
          amount: amount,
          children: [
            if (initialAddress == null)
              EnterAddressRoute(initialAddress: null)
            else if (amount == null)
              const EnterAmountRoute()
            else
              const ConfirmFungibleTokenRoute(),
          ],
        ),
      );
}
