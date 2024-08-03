import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../blockchain/models/blockchain.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../../tokens/token.dart';
import '../widgets/extensions.dart';
import '../widgets/token_input.dart';

class SendTokenScreen extends StatefulWidget {
  const SendTokenScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => SendTokenScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<SendTokenScreen> createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends State<SendTokenScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();

  late Decimal _rate;

  @override
  void initState() {
    super.initState();

    _rate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: widget.token),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  Future<void> _handleOnQrScan() async {
    final code = await context.launchQrForAddress();

    if (code == null) return;
    if (!mounted) return;

    setState(() {
      _recipientController.text = code;
    });
  }

  Future<void> _handlePressed() async {
    final recipient = Ed25519HDPublicKey.fromBase58(_recipientController.text);

    final confirmedAmount = await ODPConfirmationScreen.push(
      context,
      token: widget.token,
      initialAmount: _quantityController.text,
      isEnabled: false,
      recipient: recipient,
    );

    if (confirmedAmount == null) return;
    if (!mounted) return;

    final cryptoAmount = Amount.fromDecimal(
      value: confirmedAmount,
      currency: Currency.crypto(token: widget.token),
    ) as CryptoAmount;

    final id = await context.createTokenSend(
      amount: cryptoAmount,
      receiver: recipient,
    );

    if (!mounted) return;
    unawaited(ODPDetailsScreen.open(context, id: id));
  }

  bool _validateQuantity() {
    if (_quantityController.text.isEmpty) return false;

    final amount = _quantityController.text
        .toDecimalOrZero(DeviceLocale.localeOf(context));

    return amount.toDouble() <= 0;
  }

  bool get _isValid =>
      Blockchain.solana.validateAddress(_recipientController.text) &&
      _validateQuantity();

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<CryptoFiatAmount>(
        create: () => (
          sl<TokenFiatBalanceService>().readInvestmentBalance(widget.token),
          (
            Amount.zero(currency: Currency.usdc) as CryptoAmount,
            Amount.zero(currency: Currency.usd) as FiatAmount
          )
        ),
        builder: (context, value) {
          final crypto = value.$1;

          return Provider<Token>.value(
            value: widget.token,
            child: CpTheme.dark(
              child: Scaffold(
                appBar: CpAppBar(
                  title: Text(
                    'Send ${widget.token.symbol}',
                  ),
                ),
                backgroundColor: CpColors.dashboardBackgroundColor,
                body: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TokenQuantityInput(
                          quantityController: _quantityController,
                          crypto: crypto,
                          symbol: widget.token.symbol,
                          rate: _rate,
                        ),
                        const SizedBox(height: 32),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Recipient',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _WalletTextField(
                          controller: _recipientController,
                          onQrScan: _handleOnQrScan,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 100.0,
                            left: 25,
                            right: 25,
                          ),
                          child: ListenableBuilder(
                            listenable: Listenable.merge(
                              [_quantityController, _recipientController],
                            ),
                            builder: (context, child) => CpButton(
                              width: MediaQuery.sizeOf(context).width,
                              alignment: CpButtonAlignment.center,
                              size: CpButtonSize.big,
                              onPressed: _isValid ? _handlePressed : null,
                              text: context.l10n.next,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class _WalletTextField extends StatelessWidget {
  const _WalletTextField({
    required this.controller,
    required this.onQrScan,
  });

  final TextEditingController controller;
  final VoidCallback onQrScan;

  @override
  Widget build(BuildContext context) => CpTextField(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        height: 72,
        controller: controller,
        inputType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        backgroundColor: CpColors.darkBackgroundColor,
        placeholder: 'Enter a wallet address',
        placeholderColor: CpColors.secondaryTextColor,
        textColor: Colors.white,
        fontSize: 16,
        multiLine: true,
        suffix: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: CpIconButton(
            onPressed: onQrScan,
            icon: Assets.icons.qrScanner.svg(color: Colors.white),
            variant: CpIconButtonVariant.inverted,
          ),
        ),
      );
}
