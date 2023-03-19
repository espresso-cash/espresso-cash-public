import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/amount.dart';
import '../../../../core/conversion_rates/amount_ext.dart';
import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../di.dart';
import '../../../../features/incoming_single_link_payments/widgets/extensions.dart';
import '../../../../features/outgoing_direct_payments/widgets/extensions.dart';
import '../../../../features/outgoing_split_key_payments/widgets/extensions.dart';
import '../../../../features/payment_request/models/payment_request.dart';
import '../../../../features/qr_scanner/models/qr_scanner_request.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/shake.dart';
import '../../../../ui/theme.dart';
import 'wallet_main_screen.dart';

const _cryptoCurrency = Currency.usdc;
final _minimumAmount = Decimal.parse('0.1');

class WalletFlowScreen extends StatefulWidget {
  const WalletFlowScreen({
    Key? key,
  }) : super(key: key);

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
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerTipRequest) {
      final id = await context.createISLP(request.paymentData);

      if (!mounted) return;
      await context.router.push(IncomingSingleLinkRoute(id: id));

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
    final initialAmount = requestAmount ?? _fiatAmount;
    final formatted = initialAmount.value == 0
        ? ''
        : initialAmount.format(
            DeviceLocale.localeOf(context),
            skipSymbol: true,
          );

    final fiatDecimal = await context.router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: recipient,
        label: name,
        token: _cryptoCurrency.token,
        isEnabled: isEnabled,
      ),
    );
    if (!mounted) return;

    if (fiatDecimal != null) {
      setState(() => _fiatAmount = _fiatAmount.copyWithDecimal(fiatDecimal));

      final id = await context.createODP(
        amountInUsdc: _cryptoAmount.decimal,
        receiver: recipient,
        reference: request.reference,
      );

      if (!mounted) return;
      setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
      await context.router.push(ODPDetailsRoute(id: id));
    }
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

    context.router.push(
      OSKPConfirmationRoute(
        tokenAmount: _cryptoAmount,
        // TODO(KB): do not hardcode
        fee: Amount.fromDecimal(
          value: Decimal.parse('0.1'),
          currency: Currency.usdc,
        ),
        onSubmit: () async {
          final id = await context.createOSKP(amount: _cryptoAmount);
          if (!mounted) return;

          await context.router.replace(OSKPRoute(id: id));
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
          _errorMessage = context.l10n.minimumAmountToRequest(r'$0.10');
          break;
        case WalletOperation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(r'$0.10');
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
