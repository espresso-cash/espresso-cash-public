import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/shake.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../outgoing_direct_payments/data/blockchain.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/screens/odp_input_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../outgoing_split_key_payments/screens/oskp_confirmation_screen.dart';
import '../../outgoing_split_key_payments/screens/oskp_screen.dart';
import '../../outgoing_split_key_payments/widgets/extensions.dart';
import '../../payment_request/screens/link_request_flow_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import 'pay_flow_screen.dart';
import 'wallet_main_screen.dart';

const _cryptoCurrency = Currency.usdc;
final _minimumAmount = Decimal.parse('0.2');

@RoutePage()
class WalletFlowScreen extends StatefulWidget {
  const WalletFlowScreen({super.key});

  static const route = WalletFlowRoute.new;

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
      _fiatAmount
          .toTokenAmount(_cryptoCurrency.token)
          ?.round(Currency.usd.decimals) ??
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

    context
        .navigateTo(LinkRequestFlowScreen.route(initialAmount: _cryptoAmount));
    setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
  }

  void _onPay() {
    final amount = _fiatAmount.decimal;

    if (amount < _minimumAmount) {
      return _handleSmallAmount(WalletOperation.pay);
    }

    final cryptoAmount = _cryptoAmount;

    context.router.push(
      PayFlowScreen.route(
        onLink: () {
          context.router.push(
            OSKPConfirmationScreen.route(
              tokenAmount: cryptoAmount,
              // TODO(KB): do not hardcode
              fee: Amount.fromDecimal(
                value: Decimal.parse('0.1'),
                currency: Currency.usdc,
              ),
              onSubmit: () async {
                final id = await context.createOSKP(amount: cryptoAmount);
                if (!mounted) return;

                await context.router.pop();
                if (!mounted) return;

                await context.router.replace(OSKPScreen.route(id: id));
                if (!mounted) return;

                setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
              },
            ),
          );
        },
        onManual: () {
          context.router.push(
            ODPInputScreen.route(
              onSubmit: (Blockchain network, String address) async {
                if (network != Blockchain.solana) return;

                final formatted = _cryptoAmount
                    .format(DeviceLocale.localeOf(context), skipSymbol: true);

                final recipient = Ed25519HDPublicKey.fromBase58(address);

                final confirmedFiatAmount = await context.router.push<Decimal>(
                  ODPConfirmationScreen.route(
                    initialAmount: formatted,
                    recipient: recipient,
                    label: null,
                    token: _cryptoCurrency.token,
                    isEnabled: false,
                  ),
                );

                if (confirmedFiatAmount == null) return;
                if (!mounted) return;

                final confirmedCryptoAmount = _cryptoAmount.decimal;

                if (!mounted) return;
                final id = await context.createODP(
                  amountInUsdc: confirmedCryptoAmount,
                  receiver: recipient,
                  reference: null,
                );

                if (!mounted) return;
                await context.router.pop();

                if (!mounted) return;
                await context.router.replace(ODPDetailsScreen.route(id: id));

                if (!mounted) return;

                setState(() => _fiatAmount = _fiatAmount.copyWith(value: 0));
              },
            ),
          );
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
        case WalletOperation.pay:
          _errorMessage = context.l10n.minimumAmountToSend(r'$0.20');
      }
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
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
      );
}
