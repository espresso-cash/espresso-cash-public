import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
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
          body: _CreateSwapContent(initialToken: initialToken),
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
  late final TextEditingController _amountController;

  Token _inputToken = Token.sol;
  Token _outputToken = Token.usdc;

  @override
  void initState() {
    super.initState();
    _inputToken = widget.initialToken ?? Token.sol;
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onReviewSwap() {
    ConfirmSwapScreen.push(
      context,
      inputToken: _inputToken,
      outputToken: _outputToken,
    );
  }

  void _onSwap() {
    final Token temp = _inputToken;
    setState(() {
      _inputToken = _outputToken;
      _outputToken = temp;
    });
  }

  Future<void> _onTokenChangeSelected(SwapType type) async {
    final token = await SwapTokenSelectScreen.push(
      context,
      type: type,
      inputToken: _inputToken,
    );

    if (!mounted) return;

    if (token != null) {
      setState(() {
        switch (type) {
          case SwapType.input:
            if (token == _outputToken) {
              final temp = _inputToken;
              _inputToken = _outputToken;
              _outputToken = temp;
            } else {
              _inputToken = token;
            }
          case SwapType.output:
            _outputToken = token;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Column(
        children: [
          _TokenItem(
            type: SwapType.input,
            token: _inputToken,
            amount: Amount.fromToken(value: 0, token: _inputToken),
            onAmountChanged: print,
            onTokenChangeSelected: () => _onTokenChangeSelected(SwapType.input),
          ),
          _SwapButton(onSwap: _onSwap),
          _TokenItem(
            type: SwapType.output,
            token: _outputToken,
            amount: Amount.fromToken(value: 0, token: _outputToken),
            onAmountChanged: print,
            onTokenChangeSelected: () =>
                _onTokenChangeSelected(SwapType.output),
          ),
          Expanded(
            child: AmountKeypad(
              controller: _amountController,
              maxDecimals: 2,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: CpButton(
              text: context.l10n.swapReviewTitle,
              minWidth: width,
              onPressed: _onReviewSwap,
              size: CpButtonSize.big,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
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
  });

  final SwapType type;
  final Token token;
  final Amount amount;
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
                const Expanded(
                  child: _SwapContainer(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '0',
                        style: TextStyle(
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
