import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/address_appbar.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/request_pay_header.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class DirectPayScreen extends StatefulWidget {
  const DirectPayScreen({
    Key? key,
    required this.initialAmount,
    required this.recipient,
    required this.label,
    required this.token,
    this.isEnabled = true,
  }) : super(key: key);

  final String initialAmount;
  final String recipient;
  final String? label;
  final Token token;
  final bool isEnabled;

  @override
  State<DirectPayScreen> createState() => _ScreenState();
}

class _ScreenState extends State<DirectPayScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount);
  }

  void _onSubmit() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    if (amount == Decimal.zero) {
      showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(context.l10n.operationSend),
      );
    } else {
      context.router.pop(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CpTheme.dark(
      child: Scaffold(
        appBar: AddressAppBar(
          onClose: () => context.router.pop(),
          address: widget.recipient,
          label: widget.label,
          token: widget.token,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              RequestPayHeader(
                inputController: _amountController,
                token: widget.token,
                collapsed: true,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: CpInfoWidget(
                  icon: const InfoIcon(),
                  message: Text(context.l10n.usdcExplanation),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                flex: 3,
                child: LayoutBuilder(
                  builder: (context, constraints) => EnterAmountKeypad(
                    height: constraints.maxHeight,
                    width: width,
                    controller: _amountController,
                    maxDecimals: 2,
                    isEnabled: widget.isEnabled,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CpButton(
                  text: context.l10n.pay,
                  minWidth: width,
                  onPressed: _onSubmit,
                  size: CpButtonSize.big,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
