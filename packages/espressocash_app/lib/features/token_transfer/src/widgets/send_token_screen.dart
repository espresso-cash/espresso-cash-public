import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/amount.dart';
import '../../../../core/conversion_rates/context_ext.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/user_preferences.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';

const receiver = '0x5CedA757A24bbA2507B3Ca74b590428EA02A2D5f';

class TokenSendScreen extends StatefulWidget {
  const TokenSendScreen({super.key, required this.token});

  final Token token;

  @override
  State createState() => _TokenSendScreenState();
}

class _TokenSendScreenState extends State<TokenSendScreen> {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  Amount? _estFiat;

  late final FiatCurrency fiatCurrency;

  @override
  void initState() {
    super.initState();

    fiatCurrency = context.read<UserPreferences>().fiatCurrency;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conversionRate =
        context.watchConversionRate(from: widget.token, to: fiatCurrency);

    return CpTheme.dark(
      child: Scaffold(
        backgroundColor: CpColors.darkBackground,
        appBar: AppBar(
          title: Text('Send ${widget.token.name} (${widget.token.symbol})'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Recipient Address',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  final a = double.tryParse(value) ?? 0;

                  final amount = Amount.fromDecimal(
                    value: Decimal.parse(a.toString()),
                    currency: const CryptoCurrency(token: Token.eth),
                  );

                  setState(() {
                    _estFiat = amount.convert(
                      rate: conversionRate!,
                      to: fiatCurrency,
                    );
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  suffixText: widget.token.symbol,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              if (_estFiat != null && _estFiat!.value > 0)
                Text(
                  '~${_estFiat!.format(
                    DeviceLocale.localeOf(context),
                    roundInteger: true,
                  )}',
                  style: const TextStyle(fontSize: 16),
                ),
              const Spacer(),
              CpButton(
                text: 'Next',
                onPressed: () {
                  final address = _addressController.text;
                  final amount = double.tryParse(_amountController.text) ?? 0;

                  context.navigateTo(
                    TokenConfirmRoute(
                      token: widget.token,
                      to: address,
                      amount: amount,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
