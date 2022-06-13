import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/number_formatter.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_header_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/slippage_dialog.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/swap_token_flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapTokenOrderScreen extends StatefulWidget {
  const SwapTokenOrderScreen({Key? key}) : super(key: key);

  @override
  SwapTokenOrderScreenState createState() => SwapTokenOrderScreenState();
}

class SwapTokenOrderScreenState extends State<SwapTokenOrderScreen> {
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      final locale = DeviceLocale.localeOf(context);
      final value = _inputController.text.toDecimalOrZero(locale);
      context
          .read<SwapSelectorBloc>()
          .add(SwapSelectorEvent.amountUpdated(value));
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpLoader(
        isLoading: context.select<SwapSelectorBloc, bool>(
          (b) => b.state.maybeMap(uninitialized: T, orElse: F),
        ),
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.swapTokens),
            leading: const _SettingsButton(),
            nextButton: const _SubmitButton(),
          ),
          body: Column(
            children: [
              _Header(controller: _inputController),
              Flexible(child: _Keypad(controller: _inputController)),
            ],
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    return SwapHeaderWidget(
      inputController: controller,
      output: context.select<SwapSelectorBloc, String>(
        (bloc) =>
            bloc.state.outputAmount?.format(locale, skipSymbol: true) ?? '–',
      ),
      onSelectInput: () => context.read<SwapTokenRouter>().onSelectInputToken(),
      onSelectOutput: () =>
          context.read<SwapTokenRouter>().onSelectOutputToken(),
      onMaxRequested: () {
        final amount = context.read<SwapSelectorBloc>().calculateMaxAmount();
        if (amount == null) return;
        controller.text = amount.format(locale, skipSymbol: true);
      },
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.more_horiz, color: Colors.white),
        onPressed: () {
          final slippage = context.read<SwapSelectorBloc>().state.slippage;
          if (slippage == null) return;

          showDialog<void>(
            context: context,
            useRootNavigator: false,
            builder: (context) => SlippageDialog(
              currentSlippage: slippage,
              onSlippageChanged: (s) => context
                  .read<SwapSelectorBloc>()
                  .add(SwapSelectorEvent.slippageUpdated(s)),
            ),
          );
        },
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpButton(
        text: context.l10n.swap.toUpperCase(),
        size: CpButtonSize.micro,
        onPressed:
            context.select<SwapSelectorBloc, bool>((b) => b.state.canSwap)
                ? () => context
                    .read<SwapSelectorBloc>()
                    .add(const SwapSelectorEvent.submitted())
                : null,
      );
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => EnterAmountKeypad(
          size: constraints.maxHeight,
          controller: controller,
          maxDecimals: context.select<SwapSelectorBloc, int>(
            (b) => b.state.input?.decimals ?? 2,
          ),
        ),
      );
}
