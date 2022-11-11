import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../di.dart';
import '../../../../features/outgoing_direct_payments/module.dart';
import '../../../../features/outgoing_split_key_payments/module.dart';
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
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    if (request == null) return;
    if (!mounted) return;

    final address = request.map(
      solanaPay: (r) => r.request.recipient,
      address: (r) => r.addressData.address,
    );
    final name = request.map(
      solanaPay: (r) => r.request.label,
      address: (r) => r.addressData.name,
    );
    final requestAmount = request.mapOrNull(
      solanaPay: (r) {
        final tokenList = sl<TokenList>();

        return r.request.cryptoAmount(tokenList);
      },
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
        recipient: address,
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
        receiver: address,
        reference: request.when<Ed25519HDPublicKey?>(
          solanaPay: (r) => r.reference?.firstOrNull,
          address: always(null),
        ),
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
      return _handleSmallAmount(_Operation.request);
    }

    context.navigateTo(LinkRequestFlowRoute(initialAmount: _amount));
    setState(() => _amount = _amount.copyWith(value: 0));
  }

  void _onPay() {
    if (_amount.decimal < Decimal.parse('0.1')) {
      return _handleSmallAmount(_Operation.pay);
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

  void _handleSmallAmount(_Operation operation) {
    _shakeKey.currentState?.shake();
    setState(() {
      switch (operation) {
        case _Operation.request:
          _errorMessage = context.l10n.minimumAmountToRequest(r'$0.10');
          break;
        case _Operation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(r'$0.10');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: WalletMainScreen(
          shakeKey: _shakeKey,
          onScan: _onQrScanner,
          onAmountChanged: _onAmountUpdate,
          onRequest: _onRequest,
          onPay: _onPay,
          amount: _amount,
          error: _errorMessage,
        ),
      );
}

enum _Operation { request, pay }
