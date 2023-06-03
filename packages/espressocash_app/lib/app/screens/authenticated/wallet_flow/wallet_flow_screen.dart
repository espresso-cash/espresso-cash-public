import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/amount.dart';
import '../../../../core/conversion_rates/amount_ext.dart';
import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/currency.dart';
import '../../../../features/outgoing_split_key_payments/widgets/extensions.dart';
import '../../../../features/qr_scanner/widgets/build_context_ext.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/shake.dart';
import '../../../../ui/theme.dart';
import 'wallet_main_screen.dart';

const _cryptoCurrency = Currency.usdc;
final _minimumAmount = Decimal.parse('0.2');

@RoutePage()
class WalletFlowScreen extends StatefulWidget {
  const WalletFlowScreen({super.key});

  @override
  State<WalletFlowScreen> createState() => _State();
}

class _State extends State<WalletFlowScreen> {
  final _shakeKey = GlobalKey<ShakeState>();

  FiatAmount _fiatAmount = const FiatAmount(
    value: 0,
    fiatCurrency: Currency.usd,
  );

  CryptoAmount get _cryptoAmount =>
      _fiatAmount.toTokenAmount(
        _cryptoCurrency.token,
        ratesRepository: context.read<ConversionRatesRepository>(),
      ) ??
      const CryptoAmount(value: 0, cryptoCurrency: _cryptoCurrency);

  String _errorMessage = '';

  Future<void> _onQrScanner() async {
    await context.launchQrScannerFlow(
      cryptoCurrency: _cryptoCurrency,
      defaultFiatAmount: _fiatAmount,
      onFiatAmountChanged: (value) {
        if (!mounted) return;

        setState(() => _fiatAmount = value);
      },
    );

    if (!mounted) return;
    setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
  }

  void _onFiatAmountUpdate(Decimal value) {
    if (value == _fiatAmount.decimal) return;

    setState(() {
      _fiatAmount = _fiatAmount.copyWithDecimal(value);
      _errorMessage = '';
    });
  }

  void _onRequest() {
    if (_fiatAmount.decimal < _minimumAmount) {
      return _handleSmallAmount(WalletOperation.request);
    }

    context.navigateTo(LinkRequestFlowRoute(initialAmount: _cryptoAmount));
    setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
  }

  void _onPay() {
    final amount = _fiatAmount.decimal;

    if (amount < _minimumAmount) {
      return _handleSmallAmount(WalletOperation.pay);
    }

    final cryptoAmount = _cryptoAmount;

    context.router.push(
      OSKPConfirmationRoute(
        tokenAmount: cryptoAmount,
        // TODO(KB): do not hardcode
        fee: Amount.fromDecimal(
          value: Decimal.parse('0.1'),
          currency: Currency.usdc,
        ),
        onSubmit: () async {
          final id = await context.createOSKP(amount: cryptoAmount);
          if (!mounted) return;

          await context.router.replace(OSKPRoute(id: id));
          if (!mounted) return;

          setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
        },
      ),
    );
  }

  void _handleSmallAmount(WalletOperation operation) {
    _shakeKey.currentState?.shake();
    setState(() {
      switch (operation) {
        case WalletOperation.request:
          _errorMessage = context.l10n.minimumAmountToRequest(r'$0.20');
          break;
        case WalletOperation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(r'$0.20');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: DefaultTabController(
          length: 2,
          child: WalletMainScreen(
            shakeKey: _shakeKey,
            onScan: _onQrScanner,
            onAmountChanged: _onFiatAmountUpdate,
            onRequest: _onRequest,
            onPay: _onPay,
            amount: _fiatAmount,
            token: _cryptoCurrency.token,
            error: _errorMessage,
          ),
        ),
      );
}
