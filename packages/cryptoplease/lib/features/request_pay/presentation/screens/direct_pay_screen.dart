import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/qr_scanner_appbar.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/request_pay_header.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectPayScreen extends StatefulWidget {
  const DirectPayScreen({
    Key? key,
    required this.initialAmount,
    required this.recipient,
    required this.onAmountUpdate,
    required this.onPay,
    required this.onClearRecipient,
  }) : super(key: key);

  final String initialAmount;
  final String recipient;
  final ValueSetter<String> onAmountUpdate;
  final VoidCallback onPay;
  final VoidCallback onClearRecipient;

  @override
  State<DirectPayScreen> createState() => _ScreenState();
}

class _ScreenState extends State<DirectPayScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController(text: widget.initialAmount);
    _amountController.addListener(_updateValue);
    super.initState();
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    super.dispose();
  }

  void _updateValue() {
    final value = _amountController.text;
    widget.onAmountUpdate(value);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<RequestPayBloc, RequestPayState>(
      builder: (context, state) => CpTheme.dark(
        child: Scaffold(
          appBar: AddressAppBar(
            onClose: widget.onClearRecipient,
            address: widget.recipient,
            token: state.amount.currency.token,
          ),
          body: SafeArea(
            child: Column(
              children: [
                RequestPayHeader(
                  inputController: _amountController,
                  token: state.amount.currency.token,
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: CpButton(
                    text: context.l10n.pay,
                    minWidth: width,
                    onPressed: widget.onPay,
                    size: CpButtonSize.big,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
