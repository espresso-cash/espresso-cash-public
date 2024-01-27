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
import '../../blockchain/models/blockchain.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/screens/odp_input_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../outgoing_dln_payments/screens/flow_screen.dart';
import '../../outgoing_link_payments/screens/olp_confirmation_screen.dart';
import '../../outgoing_link_payments/screens/olp_screen.dart';
import '../../outgoing_link_payments/widgets/extensions.dart';
import '../../payment_request/screens/link_details_flow_screen.dart';
import '../../payment_request/widgets/extensions.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import 'pay_flow_screen.dart';
import 'wallet_main_screen.dart';

const _cryptoCurrency = Currency.usdc;
final _minimumAmount = Amount.fromDecimal(
  value: Decimal.parse('0.50'),
  currency: Currency.usd,
) as FiatAmount;

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
      return _handleSmallAmount(WalletOperation.request);
    }

    final id = await context.createPayRequest(tokenAmount: _cryptoAmount);
    if (!mounted) return;

    await context.router.navigate(LinkDetailsFlowScreen.route(id: id));
    if (!mounted) return;

    _reset();
  }

  void _handlePay() {
    if (_fiatAmount < _minimumAmount) {
      return _handleSmallAmount(WalletOperation.pay);
    }

    final cryptoAmount = _cryptoAmount;

    context.router.push(
      PayFlowScreen.route(
        onLink: () {
          context.router.push(
            OLPConfirmationScreen.route(
              tokenAmount: cryptoAmount,
              onSubmit: () async {
                final id = await context.createOLP(amount: cryptoAmount);
                if (!mounted) return;

                await context.router.pop();
                if (!mounted) return;

                await context.router.replace(OLPScreen.route(id: id));
                if (!mounted) return;

                _reset();
              },
            ),
          );
        },
        onManual: () {
          context.router.push(
            ODPInputScreen.route(
              onSubmit: (Blockchain network, String address) async {
                if (network == Blockchain.solana) {
                  final formatted = _cryptoAmount
                      .format(DeviceLocale.localeOf(context), skipSymbol: true);

                  final recipient = Ed25519HDPublicKey.fromBase58(address);

                  final confirmedFiatAmount =
                      await context.router.push<Decimal>(
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

                  _reset();
                } else {
                  await context.router.push(
                    OutgoingDlnPaymentFlowScreen.route(
                      amount: _cryptoAmount,
                      blockchain: network,
                      receiverAddress: address,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
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
