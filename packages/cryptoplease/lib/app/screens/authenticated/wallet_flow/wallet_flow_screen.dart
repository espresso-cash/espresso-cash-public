import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../di.dart';
import '../../../../features/incoming_tip_payments/module.dart';
import '../../../../features/outgoing_direct_payments/module.dart';
import '../../../../features/outgoing_split_key_payments/module.dart';
import '../../../../features/outgoing_tip_payments/module.dart';
import '../../../../features/payment_request/module.dart';
import '../../../../features/qr_scanner/module.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/shake.dart';
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
  final _shakeKey = GlobalKey<ShakeState>();

  CryptoAmount _amount = const CryptoAmount(value: 0, currency: Currency.usdc);
  String _errorMessage = '';

  Future<void> _onQrScanner() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerFlowRoute());

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerTipRequest) {
      await context.processIT(request.tipData);

      return;
    }

    final recipient = request.recipient;
    if (recipient == null) return;

    final name = request.mapOrNull(
      solanaPay: (r) => r.request.label,
      address: (r) => r.addressData.name,
    );
    final requestAmount = request.whenOrNull(
      solanaPay: (r) => r.cryptoAmount(sl<TokenList>()),
    );

    final isEnabled = requestAmount == null || requestAmount.value == 0;
    final initialAmount = requestAmount ?? _amount;
    final formatted = initialAmount.value == 0
        ? ''
        : initialAmount.format(
            DeviceLocale.localeOf(context),
            skipSymbol: true,
          );

    final amount = await context.router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: recipient,
        label: name,
        token: _amount.token,
        isEnabled: isEnabled,
      ),
    );
    if (!mounted) return;

    if (amount != null) {
      setState(() => _amount = _amount.copyWith(value: 0));

      context.createAndOpenDirectPayment(
        amountInUsdc: amount,
        receiver: recipient,
        reference: request.reference,
      );
    }
  }

  void _onAmountUpdate(Decimal value) {
    if (value == _amount.decimal) return;

    setState(() {
      _amount = _amount.copyWithDecimal(value);
      _errorMessage = '';
    });
  }

  void _onRequest() {
    if (_amount.decimal < Decimal.parse('0.1')) {
      return _handleSmallAmount(WalletOperation.request);
    }

    context.navigateTo(LinkRequestFlowRoute(initialAmount: _amount));
    setState(() => _amount = _amount.copyWith(value: 0));
  }

  void _onPay() {
    if (_amount.decimal < Decimal.parse('0.1')) {
      return _handleSmallAmount(WalletOperation.pay);
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

  void _onTip() {
    if (_amount.decimal < Decimal.parse('0.1')) {
      return _handleSmallAmount(WalletOperation.tip);
    }

    if (_amount.decimal > Decimal.parse('5.0')) {
      return _handleMaxTip(WalletOperation.tip);
    }

    context.router.push(
      OTConfirmationRoute(
        tokenAmount: _amount,
        // TODO(KB): do not hardcode
        fee: Amount.fromDecimal(
          value: Decimal.parse('0.1'),
          currency: Currency.usdc,
        ),
        onSubmit: () {
          final id = context.createOT(amount: _amount);
          context.router.replace(OutgoingTipRoute(id: id));
          setState(() => _amount = _amount.copyWith(value: 0));
        },
      ),
    );
  }

  void _handleSmallAmount(WalletOperation operation) {
    _shakeKey.currentState?.shake();
    setState(() {
      switch (operation) {
        case WalletOperation.request:
          _errorMessage = context.l10n.minimumAmountToRequest(r'$0.10');
          break;
        case WalletOperation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(r'$0.10');
          break;
        case WalletOperation.tip:
          _errorMessage = context.l10n.minimumAmountToTip(r'$0.10');
          break;
      }
    });
  }

  void _handleMaxTip(WalletOperation operation) {
    _shakeKey.currentState?.shake();
    setState(() {
      switch (operation) {
        case WalletOperation.request:
        case WalletOperation.pay:
          break;
        case WalletOperation.tip:
          _errorMessage = context.l10n.maximumAmountToTip(r'$5.00');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: DefaultTabController(
          length: 3,
          child: WalletMainScreen(
            shakeKey: _shakeKey,
            onScan: _onQrScanner,
            onAmountChanged: _onAmountUpdate,
            onRequest: _onRequest,
            onPay: _onPay,
            onTip: _onTip,
            amount: _amount,
            error: _errorMessage,
          ),
        ),
      );
}
