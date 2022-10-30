import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/outgoing_direct_payments/module.dart';
import '../../../../features/outgoing_split_key_payments/module.dart';
import '../../../../features/qr_scanner/module.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/theme.dart';
import 'wallet_main_screen.dart';

class WalletFlowScreen extends StatefulWidget {
  const WalletFlowScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletFlowScreen> createState() => _State();
}

class _State extends State<WalletFlowScreen> {
  CryptoAmount _amount = const CryptoAmount(value: 0, currency: Currency.usdc);

  Future<void> _onQrScanner() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    final address = request?.map(
      solanaPay: (r) => r.request.recipient.toBase58(),
      address: (r) => r.addressData.address,
    );
    final name = request?.map(
      solanaPay: (r) => r.request.label,
      address: (r) => r.addressData.name,
    );
    if (!mounted) return;

    if (address == null) return;

    final formatted = _amount.value == 0
        ? ''
        : _amount.format(DeviceLocale.localeOf(context), skipSymbol: true);

    final amount = await context.router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: address,
        label: name,
        token: _amount.token,
      ),
    );
    if (!mounted) return;

    if (amount != null) {
      setState(() => _amount = _amount.copyWith(value: 0));

      context.createAndOpenDirectPayment(
        amountInUsdc: amount,
        receiver: Ed25519HDPublicKey.fromBase58(address),
        reference: null,
      );
    }
  }

  void _onAmountUpdate(Decimal value) {
    if (value == _amount.decimal) return;

    setState(() => _amount = _amount.copyWithDecimal(value));
  }

  void _onRequest() {
    if (_amount.value == 0) {
      return _showZeroAmountDialog(_Operation.request);
    }

    context.navigateTo(LinkRequestFlowRoute(initialAmount: _amount));
    setState(() => _amount = _amount.copyWith(value: 0));
  }

  void _onPay() {
    if (_amount.value == 0) {
      return _showZeroAmountDialog(_Operation.pay);
    }

    context.router.push(
      OSKPConfirmationRoute(
        tokenAmount: _amount,
        // TODO(KB): do not hardcode
        fee: Amount.fromDecimal(
          value: Decimal.parse('0.1'),
          currency: Currency.usdc,
        ),
        onSubmit: () {
          final id = context.createOSKP(amount: _amount);
          context.router.replace(OSKPRoute(id: id));
          setState(() => _amount = _amount.copyWith(value: 0));
        },
      ),
    );
  }

  void _showZeroAmountDialog(_Operation operation) => showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(operation.buildText(context)),
      );

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: WalletMainScreen(
          onScan: _onQrScanner,
          onAmountChanged: _onAmountUpdate,
          onRequest: _onRequest,
          onPay: _onPay,
          amount: _amount,
        ),
      );
}

enum _Operation { request, pay }

extension on _Operation {
  String buildText(BuildContext context) {
    switch (this) {
      case _Operation.pay:
        return context.l10n.operationSend;
      case _Operation.request:
        return context.l10n.operationRequest;
    }
  }
}
