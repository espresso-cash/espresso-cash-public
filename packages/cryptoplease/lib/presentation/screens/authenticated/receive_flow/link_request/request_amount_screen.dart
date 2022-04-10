import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/payment_requests/create_payment_request/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_fiat_input_widget.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class RequestAmountSetter {
  void onAmountSubmitted();
}

class RequestAmountScreen extends StatefulWidget {
  const RequestAmountScreen({Key? key}) : super(key: key);

  @override
  State<RequestAmountScreen> createState() => _RequestAmountScreenState();
}

class _RequestAmountScreenState extends State<RequestAmountScreen> {
  void _onSubmitted() =>
      context.read<RequestAmountSetter>().onAmountSubmitted();

  void _updateTokenAmount(Decimal value) => context
      .read<CreatePaymentRequestBloc>()
      .add(CreatePaymentRequestEvent.tokenAmountUpdated(value));

  void _updateFiatAmount(Decimal value) => context
      .read<CreatePaymentRequestBloc>()
      .add(CreatePaymentRequestEvent.fiatAmountUpdated(value));

  void _updateToken(Token value) => context
      .read<CreatePaymentRequestBloc>()
      .add(CreatePaymentRequestEvent.tokenUpdated(value));

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreatePaymentRequestBloc>().state;

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          nextButton: CpButton(
            onPressed: state.tokenAmount.value != 0 ? _onSubmitted : null,
            text: context.l10n.next,
          ),
        ),
        body: TokenFiatInputWidget(
          tokenAmount: state.tokenAmount,
          fiatAmount: state.fiatAmount,
          onTokenAmountChanged: _updateTokenAmount,
          onFiatAmountChanged: _updateFiatAmount,
          onTokenChanged: _updateToken,
          currency: Currency.usd,
          availableTokens: state.availableTokens,
        ),
      ),
    );
  }
}
