import 'package:cryptoplease/bl/add_funds/add_funds_bloc.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/data/api/fiirebase_functions.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/screens/authenticated/add_funds_flow/component/crypto_amount_view.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({
    Key? key,
    required this.wallet,
  }) : super(key: key);

  final Wallet wallet;

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider<AddFundsBloc>(
        create: (context) => AddFundsBloc(signRequest: signFundsRequest),
        child: BlocConsumer<AddFundsBloc, AddFundsState>(
          listener: (context, state) => state.maybeWhen(
            failure: (_) => showWarningDialog(
              context,
              title: context.l10n.buySolFailedTitle,
              message: context.l10n.buySolFailedMessage,
            ),
            success: launch,
            orElse: ignore,
          ),
          builder: (context, state) {
            final isLoading = state.isProcessing();

            final textField = CpTextField(
              disabled: isLoading,
              margin: const EdgeInsets.only(top: 16),
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

            final cryptoAmount = ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, _) => Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CryptoAmountView(
                  token: Token.sol,
                  amount: FiatAmount(
                    value: Currency.usd.decimalToInt(_parseValue(value.text)),
                    currency: Currency.usd,
                  ),
                ),
              ),
            );

            final submitButton = Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (_, value, __) => _SubmitButton(
                    value: value.text,
                    isLoading: isLoading,
                    address: widget.wallet.address,
                  ),
                ),
              ),
            );

            return Scaffold(
              appBar: CpAppBar(title: Text(context.l10n.buySol)),
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
                          cryptoAmount,
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          context.l10n.buySolanaTokenMoonPay,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
    required this.value,
    required this.isLoading,
    required this.address,
  }) : super(key: key);

  final String value;
  final bool isLoading;
  final String address;

  @override
  Widget build(BuildContext context) {
    final isValid = _isValidValue(value);

    return CpButton(
      text: context.l10n.buy,
      width: double.infinity,
      onPressed: isValid && !isLoading
          ? () => context.read<AddFundsBloc>().add(
                AddFundsEvent.urlRequested(
                  walletAddress: address,
                  value: _parseValue(value),
                ),
              )
          : null,
    );
  }
}

Decimal _parseValue(String? value) {
  if (value == null) return Decimal.zero;

  return Decimal.tryParse(value.replaceAll(',', '.')) ?? Decimal.zero;
}

bool _isValidValue(String? value) => _parseValue(value) != Decimal.zero;
