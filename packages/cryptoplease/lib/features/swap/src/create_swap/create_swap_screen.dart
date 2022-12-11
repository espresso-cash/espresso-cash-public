import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/amount.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/amount_keypad/amount_keypad.dart';
import '../../../../ui/button.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/number_formatter.dart';
import '../route.dart';
import 'available_balance.dart';
import 'bloc.dart';
import 'components/display_header.dart';
import 'components/equivalent_header.dart';
import 'components/route_duration_wrapper.dart';
import 'components/slippage_info.dart';
import 'components/swap_fee.dart';
import 'components/token_dropdown.dart';

class CreateSwapScreen extends StatefulWidget {
  const CreateSwapScreen({super.key});

  @override
  State<CreateSwapScreen> createState() => _CreateSwapScreenState();
}

class _CreateSwapScreenState extends State<CreateSwapScreen> {
  final _amountController = TextEditingController();

  void _onSubmit() {
    const event = CreateSwapEvent.submitted();
    context.read<CreateSwapBloc>().add(event);
  }

  void _onSlippageChanged(Slippage value) {
    final event = CreateSwapEvent.slippageUpdated(value);
    context.read<CreateSwapBloc>().add(event);
  }

  void _onEditingModeToggled() {
    const event = CreateSwapEvent.editingModeToggled();
    context.read<CreateSwapBloc>().add(event);
  }

  void _onAmountChanged(Decimal value) {
    final event = CreateSwapEvent.amountUpdated(value);
    context.read<CreateSwapBloc>().add(event);
  }

  void _onRouteExpired() {
    const event = CreateSwapEvent.routeInvalidated();
    context.read<CreateSwapBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateValue);
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    _onAmountChanged(amount);
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateSwapBloc>().state;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _amountController,
            builder: (context, value, __) => DisplayHeader(
              displayAmount: value.text,
            ),
          ),
          EquivalentHeader(
            inputAmount: state.inputAmount,
            outputAmount: state.outputAmount,
            isLoadingRoute: state.flowState.isProcessing(),
          ),
          SwapFee(amount: state.fee),
          TokenDropDown(
            current: state.requestAmount.token,
            onTokenChanged: (_) => _onEditingModeToggled(),
            availableTokens: [
              state.inputAmount.token,
              state.outputAmount.token,
            ],
          ),
          AvailableBalance(
            maxAmountAvailable:
                context.watch<CreateSwapBloc>().calculateMaxAmount(),
          ),
          SlippageInfo(
            slippage: state.slippage,
            onSlippageChanged: _onSlippageChanged,
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => AmountKeypad(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                controller: _amountController,
                maxDecimals: state.requestAmount.token.decimals,
              ),
            ),
          ),
          RouteDurationWrapper(
            start: state.fetchedAt,
            onTimeout: _onRouteExpired,
            builder: (context, remaining) => _Button(
              countdown: remaining,
              onSubmit: _onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.countdown,
    required this.onSubmit,
  }) : super(key: key);

  final Duration? countdown;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.pressAndHoldToSubmit;
    final label = countdown
        .maybeMap((d) => '$title (${d.inSeconds}s)')
        .ifNull(() => title);

    return CpContentPadding(
      child: CpButton(
        text: label,
        mechanics: CpButtonMechanics.pressAndHold,
        width: double.infinity,
        size: CpButtonSize.big,
        onPressed: countdown != null ? onSubmit : null,
      ),
    );
  }
}
