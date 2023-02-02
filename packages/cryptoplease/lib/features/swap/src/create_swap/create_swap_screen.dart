import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/amount.dart';
import '../../../../core/balances/bl/balances_bloc.dart';
import '../../../../core/callback.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/amount_keypad/amount_keypad.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/number_formatter.dart';
import '../../../../ui/slider.dart';
import '../../models/swap_seed.dart';
import '../swap_operation.dart';
import '../swap_route.dart';
import 'available_balance.dart';
import 'components/display_header.dart';
import 'components/equivalent_header.dart';
import 'components/slippage_info.dart';
import 'components/swap_exception_dialog.dart';
import 'components/swap_fee.dart';
import 'components/token_dropdown.dart';
import 'create_swap_bloc.dart';

class CreateSwapScreen extends StatefulWidget {
  const CreateSwapScreen({
    super.key,
    required this.onRouteReady,
    required this.inputToken,
    required this.outputToken,
    required this.operation,
  });

  final Callback1<SwapRoute> onRouteReady;
  final Token inputToken;
  final Token outputToken;
  final SwapOperation operation;

  @override
  State<CreateSwapScreen> createState() => _CreateSwapScreenState();
}

class _CreateSwapScreenState extends State<CreateSwapScreen> {
  final _amountController = TextEditingController();
  late final CreateSwapBloc _bloc;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _bloc = sl<CreateSwapBloc>(
      param1: SwapSetup(
        input: widget.inputToken,
        output: widget.outputToken,
        initialEditingMode: widget.operation.toInitialEditingMode(),
        userAccount: context.read<MyAccount>().wallet.publicKey,
      ),
      param2: context.read<BalancesBloc>().state.balances,
    );
    _amountController.addListener(_updateValue);
  }

  void _resetTimer(DateTime? expiresAt) {
    timer?.cancel();
    if (expiresAt == null) return;
    timer = Timer(expiresAt.difference(DateTime.now()), _onRouteExpired);
  }

  void _onSubmit() {
    const event = CreateSwapEvent.submitted();
    _bloc.add(event);
  }

  void _onSlippageChanged(Slippage value) {
    final event = CreateSwapEvent.slippageUpdated(value);
    _bloc.add(event);
  }

  void _onEditingModeToggled() {
    const event = CreateSwapEvent.editingModeToggled();
    _bloc.add(event);
  }

  void _onAmountChanged(Decimal value) {
    final event = CreateSwapEvent.amountUpdated(value);
    _bloc.add(event);
  }

  void _onRouteExpired() {
    const event = CreateSwapEvent.routeInvalidated();
    // _bloc.add(event);
  }

  void _onMaxAmountRequested(Token displayToken) {
    final amount = _bloc.calculateMaxAmount();
    if (displayToken != amount.token) _onEditingModeToggled();
    final locale = DeviceLocale.localeOf(context);
    _amountController.text = amount.format(locale, skipSymbol: true);
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    _onAmountChanged(amount);
  }

  void _onSwapException(CreateSwapException e) => showSwapExceptionDialog(
        context,
        context.l10n.swapErrorTitle,
        e,
      );

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    _bloc.close();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<CreateSwapBloc, CreateSwapState>(
        bloc: _bloc,
        listenWhen: (prev, cur) => prev.expiresAt != cur.expiresAt,
        listener: (context, state) => _resetTimer(state.expiresAt),
        child: BlocConsumer<CreateSwapBloc, CreateSwapState>(
          bloc: _bloc,
          listenWhen: (prev, cur) => prev.flowState != cur.flowState,
          listener: (context, state) => state.flowState.whenOrNull(
            failure: _onSwapException,
            success: widget.onRouteReady,
          ),
          builder: (context, state) => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _amountController,
                  builder: (context, value, __) => DisplayHeader(
                    displayAmount: value.text,
                  ),
                ),
                TokenDropDown(
                  current: state.requestAmount.token,
                  onTokenChanged: (_) => _onEditingModeToggled(),
                  availableTokens: [
                    state.inputAmount.token,
                    state.outputAmount.token,
                  ],
                ),
                EquivalentHeader(
                  inputAmount: state.inputAmount,
                  outputAmount: state.outputAmount,
                  isLoadingRoute: state.flowState.isProcessing(),
                ),
                SwapFee(amount: state.fee),
                const SizedBox(height: 16),
                AvailableBalance(
                  maxAmountAvailable: _bloc.calculateMaxAmount(),
                  onMaxAmountRequested: widget.operation == SwapOperation.buy
                      ? null
                      : () => _onMaxAmountRequested(state.requestToken),
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
                _Button(
                  onSubmit: state.inputAmount.value == 0 ? null : _onSubmit,
                  operation: widget.operation,
                  inputToken: widget.inputToken,
                  outputToken: widget.outputToken,
                ),
              ],
            ),
          ),
        ),
      );
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onSubmit,
    required this.inputToken,
    required this.outputToken,
    required this.operation,
  }) : super(key: key);

  final VoidCallback? onSubmit;
  final Token inputToken;
  final Token outputToken;
  final SwapOperation operation;

  @override
  Widget build(BuildContext context) {
    final String label;
    switch (operation) {
      case SwapOperation.buy:
        label = context.l10n.pressAndHoldToBuy(outputToken.symbol);
        break;
      case SwapOperation.sell:
        label = context.l10n.pressAndHoldToSell(inputToken.symbol);
        break;
    }

    return CpContentPadding(
      child: CpSlider(
        text: label,
        onSlideCompleted: onSubmit,
      ),
    );
  }
}

extension on SwapOperation {
  SwapEditingMode toInitialEditingMode() {
    switch (this) {
      case SwapOperation.buy:
        return const SwapEditingMode.output();
      case SwapOperation.sell:
        return const SwapEditingMode.input();
    }
  }
}
