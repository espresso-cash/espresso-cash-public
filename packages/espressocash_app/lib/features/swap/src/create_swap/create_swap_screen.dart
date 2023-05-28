import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
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
import '../../../../ui/dialogs.dart';
import '../../../../ui/number_formatter.dart';
import '../../../../ui/slider.dart';
import '../../models/swap_seed.dart';
import '../swap_operation.dart';
import '../swap_route.dart';
import 'available_balance.dart';
import 'components/display_header.dart';
import 'components/equivalent_header.dart';
import 'components/slippage_info.dart';
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
  Timer? _timer;

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
    _timer?.cancel();
    if (expiresAt == null) return;
    _timer = Timer(expiresAt.difference(DateTime.now()), _onRouteExpired);
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
    _bloc.add(event);
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

  void _onSwapException(CreateSwapException e) => showWarningDialog(
        context,
        title: context.l10n.swapErrorTitle,
        message: e.description(context),
      );

  @override
  void dispose() {
    _amountController
      ..removeListener(_updateValue)
      ..dispose();
    _bloc.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String label;
    switch (widget.operation) {
      case SwapOperation.buy:
        label = context.l10n.pressAndHoldToBuy(widget.outputToken.symbol);
        break;
      case SwapOperation.sell:
        label = context.l10n.pressAndHoldToSell(widget.inputToken.symbol);
        break;
    }

    return BlocListener<CreateSwapBloc, CreateSwapState>(
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
                feeAmount: state.fee,
              ),
              const SizedBox(height: 6),
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
              CpContentPadding(
                child: CpSlider(
                  text: label,
                  onSlideCompleted: (state.bestRoute == null ||
                          state.flowState.isProcessing())
                      ? null
                      : _onSubmit,
                ),
              ),
            ],
          ),
        ),
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

extension on CreateSwapException {
  String description(BuildContext context) => this.map(
        routeNotFound: always(context.l10n.swapFailRouteNotFound),
        insufficientBalance: (e) => context.l10n.insufficientFundsMessage(
          e.amount.format(DeviceLocale.localeOf(context)),
          e.balance.format(DeviceLocale.localeOf(context)),
        ),
        insufficientFee: (e) => context.l10n.insufficientFundsForFeeMessage(
          e.fee.currency.symbol,
          e.fee.format(DeviceLocale.localeOf(context)),
        ),
        other: always(context.l10n.swapFailUnknown),
      );
}
