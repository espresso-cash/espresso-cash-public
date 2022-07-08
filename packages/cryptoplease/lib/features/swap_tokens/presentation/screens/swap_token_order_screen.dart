import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/swap_tokens/bl/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/slippage_dialog.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/swap_error_dialog.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/swap_header_widget.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/swap_token_flow.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

class SwapTokenOrderScreen extends StatelessWidget {
  const SwapTokenOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => SwapSelectorBloc(
          jupiterAggregatorClient: context.read<JupiterAggregatorClient>(),
          tokenList: context.read<TokenList>(),
          balances: context.read<BalancesBloc>().state.balances,
          analyticsManager: context.read<AnalyticsManager>(),
        )..add(const SwapSelectorEvent.init()),
        child: const _Content(),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
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
  Widget build(BuildContext context) =>
      BlocListener<SwapSelectorBloc, SwapSelectorState>(
        listenWhen: (previous, current) =>
            previous.routeProcessingState != current.routeProcessingState,
        listener: (context, state) {
          state.whenOrNull(
            success: (route) => context.read<SwapTokenRouter>().onSubmit(route),
          );
          state.routeProcessingState?.whenOrNull(
            error: (error) => showSwapErrorDialog(
              context,
              context.l10n.errorLoadingTokens,
              error,
            ),
          );
        },
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.swapTokens),
            leading: BlocBuilder<SwapSelectorBloc, SwapSelectorState>(
              builder: (context, state) => state.maybeMap(
                uninitialized: (_) => const _Loading(),
                orElse: () => const _SettingsButton(),
              ),
            ),
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
      onSelectInput: () async {
        final bloc = context.read<SwapSelectorBloc>();
        final tokens = bloc.state.inputTokens;
        final token =
            await context.read<SwapTokenRouter>().onSelectInputToken(tokens);
        if (token != null) {
          bloc.add(SwapSelectorEvent.inputUpdated(token));
        }
      },
      onSelectOutput: () async {
        final bloc = context.read<SwapSelectorBloc>();
        final tokens = bloc.state.outputTokens;
        final token =
            await context.read<SwapTokenRouter>().onSelectOutputToken(tokens);
        if (token != null) {
          bloc.add(SwapSelectorEvent.outputUpdated(token));
        }
      },
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

          void onSlippageChanged(Decimal value) => context
              .read<SwapSelectorBloc>()
              .add(SwapSelectorEvent.slippageUpdated(value));

          showDialog<void>(
            context: context,
            useRootNavigator: false,
            builder: (context) => SlippageDialog(
              currentSlippage: slippage,
              onSlippageChanged: onSlippageChanged,
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

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 16.0,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
}
