import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/dto.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/decimal_separator.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/theme.dart';
import '../../../utils/flow.dart';
import '../../balances/data/repository.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../service/create_swap_bloc.dart';
import '../widgets/divider.dart';
import 'confirm_swap.dart';
import 'token_select_screen.dart';

enum SwapType { input, output }

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key, this.initialToken});

  final Token? initialToken;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(title: Text(context.l10n.swapTitle.toUpperCase())),
          body: SafeArea(child: _CreateSwapContent(initialToken: initialToken)),
        ),
      );
}

class _CreateSwapContent extends StatefulWidget {
  const _CreateSwapContent({
    this.initialToken,
  });

  final Token? initialToken;

  @override
  State<_CreateSwapContent> createState() => _CreateSwapContentState();
}

class _CreateSwapContentState extends State<_CreateSwapContent> {
  final _amountController = TextEditingController(text: '0');
  late final CreateSwapBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = sl<CreateSwapBloc>();

    _amountController.addListener(_updateValue);
  }

  void _onSubmit() {
    const event = CreateSwapEvent.submitted();
    _bloc.add(event);
  }

  void _onAmountChanged(Decimal value) {
    final event = CreateSwapEvent.amountUpdated(value);
    _bloc.add(event);
  }

  void _updateValue() {
    final amount = _amountController.text.toDecimalOrZero(context.locale);
    _onAmountChanged(amount);
  }

  @override
  void dispose() {
    _amountController
      ..removeListener(_updateValue)
      ..dispose();
    _bloc.close();

    super.dispose();
  }

  void _onReviewSwap() {
    // ConfirmSwapScreen.push( //TODO
    //   context,
    //   inputToken: _inputToken,
    //   outputToken: _outputToken,
    // );
  }

  void _onSwap() {
    const event = CreateSwapEvent.swapped();
    _bloc.add(event);
  }

  Future<void> _onException() async {
    await showWarningDialog(
      context,
      title: context.l10n.swapErrorTitle,
      // message: e.description(context),
      message: 'TODO',
    );

    _bloc.add(const CreateSwapEvent.routeInvalidated());
  }

  Future<void> _onTokenChangeSelected(
    SwapType type, {
    required Token inputToken,
  }) async {
    final userTokens = await sl<TokenBalancesRepository>().readUserTokens();

    if (!mounted) return;

    final token = await SwapTokenSelectScreen.push(
      context,
      type: type,
      inputToken: inputToken,
      userTokens: userTokens.toIList(),
    );

    if (!mounted) return;

    if (token != null) {
      final event = CreateSwapEvent.inputTokenUpdated(token);
      _bloc.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<CreateSwapBloc, CreateSwapState>(
      bloc: _bloc,
      listenWhen: (prev, cur) => prev.flowState != cur.flowState,
      listener: (context, state) => switch (state.flowState) {
        FlowFailure(:final error) => _onException(), //TODO
        FlowSuccess(:final result) => () {
            //TODO
          },
        _ => null,
      },
      builder: (context, state) {
        final formattedOutput = state.outputAmount.format(
          context.locale,
          roundInteger: true,
          skipSymbol: false,
        );

        return Column(
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _amountController,
              builder: (context, value, __) => _TokenItem(
                type: SwapType.input,
                isLoading: false,
                token: state.input,
                amount: value.text,
                onAmountChanged: print,
                onTokenChangeSelected: () => _onTokenChangeSelected(
                  SwapType.input,
                  inputToken: state.input,
                ),
              ),
            ),
            _SwapButton(onSwap: _onSwap),
            _TokenItem(
              isLoading: state.flowState.isProcessing,
              type: SwapType.output,
              token: state.output,
              amount: formattedOutput,
              onAmountChanged: print,
              onTokenChangeSelected: () => _onTokenChangeSelected(
                SwapType.output,
                inputToken: state.output,
              ),
            ),
            Expanded(
              child: AmountKeypad(
                controller: _amountController,
                maxDecimals: state.requestAmount.token.decimals,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CpButton(
                text: context.l10n.swapReviewTitle,
                minWidth: width,
                onPressed: _onSubmit,
                size: CpButtonSize.big,
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

extension on String {
  String formatted(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final decimalSeparator = getDecimalSeparator(locale);

    if (contains(decimalSeparator)) {
      return this;
    } else if (toDecimalOrZero(locale) == Decimal.zero) {
      return '0';
    }

    return this;
  }
}

class _SwapButton extends StatelessWidget {
  const _SwapButton({required this.onSwap});

  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Expanded(child: EcDivider()),
            GestureDetector(
              onTap: onSwap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Assets.icons.swap.svg(height: 30, color: Colors.white),
              ),
            ),
            const Expanded(child: EcDivider()),
          ],
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({
    required this.token,
    required this.amount,
    required this.onTokenChangeSelected,
    required this.onAmountChanged,
    required this.type,
    required this.isLoading,
  });

  final bool isLoading;
  final SwapType type;
  final Token token;
  final String amount;
  final VoidCallback onTokenChangeSelected;
  final ValueSetter<Decimal> onAmountChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                switch (type) {
                  SwapType.input => context.l10n.swapInputLabel,
                  SwapType.output => context.l10n.swapOutputLabel,
                },
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (isLoading && type == SwapType.output)
                  const Expanded(child: _SwapContainerSkeleton())
                else
                  Expanded(
                    child: _SwapContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          amount.formatted(context),
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: onTokenChangeSelected,
                    child: _SwapContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TokenIcon(token: token, size: 30),
                          Text(
                            token.symbol,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                          const _Arrow(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class _SwapContainer extends StatelessWidget {
  const _SwapContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: CpColors.darkBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: child,
      );
}

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 3,
        child: Assets.icons.arrow.svg(
          height: 15,
          color: Colors.white,
        ),
      );
}

class _SwapContainerSkeleton extends StatelessWidget {
  const _SwapContainerSkeleton();

  @override
  Widget build(BuildContext context) => Container(
        height: 60,
        decoration: const BoxDecoration(
          color: CpColors.darkBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
            child: LinearProgressIndicator(
              color: CpColors.darkBackgroundColor,
              backgroundColor: Colors.grey[800],
            ),
          ),
        ),
      );
}
