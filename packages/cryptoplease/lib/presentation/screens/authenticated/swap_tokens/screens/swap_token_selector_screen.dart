import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/number_formatter.dart';
import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/amount_display.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/slippage_dropdown.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/token_dropdown.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/swap_token_router.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapTokenSelectorScreen extends StatefulWidget {
  const SwapTokenSelectorScreen({Key? key}) : super(key: key);

  @override
  _SwapTokenSelectorScreenState createState() =>
      _SwapTokenSelectorScreenState();
}

class _SwapTokenSelectorScreenState extends State<SwapTokenSelectorScreen> {
  final _inputKey = GlobalKey();
  final _outputKey = GlobalKey();
  final _controller = TextEditingController();
  late final SwapSelectorBloc swapTokenBloc;

  @override
  void initState() {
    super.initState();
    swapTokenBloc = context.read<SwapSelectorBloc>();
    _controller.addListener(_onAmountUpdate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _insufficientTokenDialog({
    required Amount balance,
    required Amount currentAmount,
  }) =>
      showWarningDialog(
        context,
        title: context.l10n.insufficientFundsTitle,
        message: context.l10n.insufficientFundsMessage(
          currentAmount.format(DeviceLocale.localeOf(context)),
          balance.format(DeviceLocale.localeOf(context)),
        ),
      );

  void _insufficientFeeDialog(Amount fee) {
    showWarningDialog(
      context,
      title: context.l10n.insufficientFundsForFeeTitle,
      message: context.l10n.insufficientFundsForFeeMessage(
        fee.format(DeviceLocale.localeOf(context)),
      ),
    );
  }

  void _onAmountUpdate() {
    if (swapTokenBloc.state.selectedInput == null) return;

    final value = _controller.text.toDecimalOrZero(
      DeviceLocale.localeOf(context),
    );
    swapTokenBloc.add(
      SwapSelectorEvent.amountUpdated(value),
    );
  }

  void _onConfirm() {
    swapTokenBloc.validate().fold(
          (error) => error.map(
            insufficientFunds: (e) => _insufficientTokenDialog(
              balance: e.balance,
              currentAmount: e.currentAmount,
            ),
            insufficientFee: (e) => _insufficientFeeDialog(e.requiredFee),
          ),
          (_) => context.read<SwapTokenRouter>().onConfirm(),
        );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapSelectorBloc, SwapSelectorState>(
        bloc: swapTokenBloc,
        builder: (context, state) => CpTheme.dark(
          child: CpLoader(
            isLoading: state.isLoading,
            child: Scaffold(
              appBar: CpAppBar(
                leading: BackButton(
                  onPressed: () => context.read<SwapTokenRouter>().closeFlow(),
                ),
                nextButton: SlippageDropdown(
                  currentSlippage: state.slippage,
                  onSlippageChanged: (slippage) => swapTokenBloc.add(
                    SwapSelectorEvent.slippageUpdated(slippage),
                  ),
                ),
              ),
              body: SafeArea(
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: TokenDropdown(
                                key: _inputKey,
                                availableTokens: state.inputTokens,
                                selectedToken: state.selectedInput,
                                onChanged: (token) => swapTokenBloc.add(
                                  SwapSelectorEvent.inputSelected(token),
                                ),
                              ),
                            ),
                            Text(context.l10n.to.toLowerCase()),
                            Flexible(
                              child: TokenDropdown(
                                key: _outputKey,
                                availableTokens: state.outputTokens,
                                selectedToken: state.selectedOutput,
                                onChanged: (token) => swapTokenBloc.add(
                                  SwapSelectorEvent.outputSelected(token),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: AmountDisplay(
                            value: _controller.text,
                            currency: state.amount.currency,
                            onTokenChanged: null,
                            availableTokens: IList(),
                          ),
                        ),
                      ],
                    ),
                    EnterAmountKeypad(
                      controller: _controller,
                      maxDecimals: state.selectedInput?.decimals ?? 0,
                    ),
                    CpContentPadding(
                      child: CpButton(
                        text: context.l10n.swapTokens,
                        onPressed: state.canSwap ? _onConfirm : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
