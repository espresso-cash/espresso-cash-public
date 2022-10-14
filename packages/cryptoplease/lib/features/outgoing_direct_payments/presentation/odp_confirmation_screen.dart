import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/odp_header.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class ODPConfirmationScreen extends StatefulWidget {
  const ODPConfirmationScreen({
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
  State<ODPConfirmationScreen> createState() => _ScreenState();
}

class _ScreenState extends State<ODPConfirmationScreen> {
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
        appBar: _AddressAppBar(
          onClose: () => context.router.pop(),
          address: widget.recipient,
          label: widget.label,
          token: widget.token,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              ODPHeader(
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

class _AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AddressAppBar({
    Key? key,
    required this.onClose,
    required this.label,
    required this.address,
    required this.token,
  }) : super(key: key);

  final VoidCallback onClose;
  final String? label;
  final String address;
  final Token token;

  @override
  Size get preferredSize => const Size.fromHeight(3 * kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final formattedAddress = '${substring(address, 0, 4)}'
        '\u2026'
        '${substring(address, address.length - 4)}';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ),
          _AppBarRow(
            text: context.l10n.to,
            chipContent: Text.rich(
              TextSpan(
                text: label ?? '',
                children: [
                  if (label != null)
                    const WidgetSpan(child: SizedBox(width: 24)),
                  TextSpan(
                    text: formattedAddress,
                    style: _textStyle.copyWith(
                      color: CpColors.disabledColor,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              style: _textStyle,
            ),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
          _AppBarRow(
            text: context.l10n.sendAs,
            chipContent: Text(token.symbol, style: _textStyle),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
        ],
      ),
    );
  }
}

class _AppBarRow extends StatelessWidget {
  const _AppBarRow({
    Key? key,
    required this.text,
    required this.chipContent,
  }) : super(key: key);

  final String text;
  final Widget chipContent;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return Container(
      height: kToolbarHeight,
      padding: padding,
      child: Row(
        children: [
          Text(text, style: _textStyle),
          const SizedBox(width: 12),
          Flexible(
            child: FittedBox(
              child: CpChip(
                padding: CpChipPadding.small,
                child: chipContent,
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
