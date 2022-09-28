import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_quote.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({
    Key? key,
    required this.wallet,
    required this.token,
  }) : super(key: key);

  final Wallet wallet;
  final Token token;

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  late final AddFundsBloc _bloc;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = AddFundsBloc(repository: context.read<AddFundsRepository>())
      ..add(const AddFundsEvent.initialized());
    _controller.addListener(() {
      final locale = DeviceLocale.localeOf(context);
      final value = _controller.text.toDecimalOrZero(locale);
      _bloc.add(AddFundsEvent.amountUpdated(decimal: value));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<AddFundsBloc>.value(
        value: _bloc,
        child: BlocConsumer<AddFundsBloc, AddFundsState>(
          listener: (context, state) => state.maybeWhen(
            failure: () => showWarningDialog(
              context,
              title: context.l10n.buyUsdcFailedTitle,
              message: context.l10n.buyUsdcFailedMessage,
            ),
            success: (url) => launchUrl(Uri.parse(url))
                .then((_) => Navigator.of(context).pop()),
            orElse: ignore,
          ),
          builder: (context, state) {
            final isLoading = state.isLoading();
            final isValidAmount = state.isValidAmount();

            final enabled = !isLoading && isValidAmount;

            final textField = CpTextField(
              margin: const EdgeInsets.only(top: 16),
              disabled: state.maybeMap(orElse: F, loading: T),
              placeholder: context.l10n.amount,
              inputType: TextInputType.number,
              controller: _controller,
              prefix: r'$',
              suffix: isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: CircularProgressIndicator(),
                    )
                  : null,
            );

            final bodyWidget = state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              initialized: (state) => isValidAmount
                  ? _QuoteWidget(quote: state.quote)
                  : _MinimumAmountMessage(minimumAmount: state.minAmount),
            );

            final submitButton = Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (_, value, __) => _SubmitButton(
                    value: value.text,
                    enabled: enabled,
                    address: widget.wallet.address,
                    token: widget.token,
                  ),
                ),
              ),
            );

            return Scaffold(
              appBar: CpAppBar(title: Text(context.l10n.buyUsdc)),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textField,
                          const SizedBox(height: 16),
                          bodyWidget,
                          const SizedBox(height: 32),
                          const _Description(),
                        ],
                      ),
                    ),
                    submitButton,
                  ],
                ),
              ),
            );
          },
        ),
      );
}

class _Description extends StatelessWidget {
  const _Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        context.l10n.buyUsdcTokenMoonPay,
        style: Theme.of(context).textTheme.bodyText1,
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
    required this.value,
    required this.enabled,
    required this.address,
    required this.token,
  }) : super(key: key);

  final String value;
  final bool enabled;
  final String address;
  final Token token;

  @override
  Widget build(BuildContext context) => CpButton(
        text: context.l10n.buy,
        width: double.infinity,
        onPressed: enabled
            ? () {
                final event = AddFundsEvent.urlRequested(
                  walletAddress: address,
                );
                context.read<AddFundsBloc>().add(event);
              }
            : null,
      );
}

class _MinimumAmountMessage extends StatelessWidget {
  const _MinimumAmountMessage({
    Key? key,
    required this.minimumAmount,
  }) : super(key: key);

  final FiatAmount minimumAmount;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = minimumAmount.format(locale);

    return Text.rich(
      TextSpan(
        text: context.l10n.buyUsdcMinimumMessage,
        children: [
          TextSpan(
            text: formattedAmount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        style: const TextStyle(
          fontSize: 14,
          color: CpColors.darkPrimaryColor,
        ),
      ),
    );
  }
}

class _QuoteWidget extends StatelessWidget {
  const _QuoteWidget({
    Key? key,
    required this.quote,
  }) : super(key: key);

  final AddFundsQuote? quote;

  @override
  Widget build(BuildContext context) {
    final quote = this.quote;

    if (quote == null) return const SizedBox.shrink();

    final locale = DeviceLocale.localeOf(context);
    final amount = quote.buyAmount.format(locale);
    final total = quote.totalAmount.format(locale);
    final fees = quote.feeAmount?.format(locale);
    final price = quote.quotePrice?.format(locale);
    const style = TextStyle(fontSize: 12, color: CpColors.secondaryTextColor);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                text: context.l10n.buyUsdcAmountMessage,
                children: [
                  TextSpan(
                    text: amount,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 8),
          if (price != null)
            Text(
              context.l10n.buyUsdcQuotePrice(price),
              style: style,
            ),
          if (fees != null)
            Text(
              context.l10n.buyUsdcFee(fees),
              style: style,
            ),
        ],
      ),
    );
  }
}
