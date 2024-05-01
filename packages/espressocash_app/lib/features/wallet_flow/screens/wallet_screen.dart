import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/shake.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../payment_request/screens/payment_request_screen.dart';
import '../../payment_request/widgets/extensions.dart';
import '../widgets/launch_qr_scanner_flow.dart';
import '../widgets/wallet_tab_view.dart';
import 'pay_screen.dart';

const _cryptoCurrency = Currency.usdc;
final _minimumAmount = Amount.fromDecimal(
  value: Decimal.parse('0.50'),
  currency: Currency.usd,
) as FiatAmount;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _State();
}

class _State extends State<WalletScreen> {
  final _shakeKey = GlobalKey<ShakeState>();

  FiatAmount _fiatAmount = const FiatAmount(
    value: 0,
    fiatCurrency: Currency.usd,
  );

  CryptoAmount get _cryptoAmount =>
      _fiatAmount
          .toTokenAmount(_cryptoCurrency.token)
          ?.round(Currency.usd.decimals) ??
      const CryptoAmount(value: 0, cryptoCurrency: _cryptoCurrency);

  String _errorMessage = '';

  Future<void> _handleScanned() async {
    await context.launchQrScannerFlow(
      cryptoCurrency: _cryptoCurrency,
      defaultFiatAmount: _fiatAmount,
      onFiatAmountChanged: (value) {
        if (!mounted) return;

        setState(() => _fiatAmount = value);
      },
    );

    _reset();
  }

  void _handleFiatAmountChanged(Decimal value) {
    if (value == _fiatAmount.decimal) return;

    setState(() {
      _fiatAmount = _fiatAmount.copyWithDecimal(value);
      _errorMessage = '';
    });
  }

  Future<void> _handleRequest() async {
    if (_fiatAmount < _minimumAmount) {
      _handleSmallAmount(WalletOperation.request);

      return;
    }

    final id = await context.createPayRequest(tokenAmount: _cryptoAmount);
    if (!mounted) return;

    _reset();

    PaymentRequestScreen.push(context, id: id);
  }

  void _handlePay() {
    if (_fiatAmount < _minimumAmount) {
      _handleSmallAmount(WalletOperation.pay);

      return;
    }

    PayScreen.push(context, amount: _cryptoAmount);

    _reset();
  }

  void _handleSmallAmount(WalletOperation operation) {
    _shakeKey.currentState?.shake();

    final minimumAmount = _minimumAmount.format(context.locale);
    setState(() {
      switch (operation) {
        case WalletOperation.request:
          _errorMessage = context.l10n.minimumAmountToRequest(minimumAmount);
        case WalletOperation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(minimumAmount);
      }
    });
  }

  void _reset() {
    if (!mounted) return;
    setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: WalletMainScreen(
          shakeKey: _shakeKey,
          onScan: _handleScanned,
          onAmountChanged: _handleFiatAmountChanged,
          onRequest: _handleRequest,
          onPay: _handlePay,
          amount: _fiatAmount,
          token: _cryptoCurrency.token,
          error: _errorMessage,
        ),
      );
}
