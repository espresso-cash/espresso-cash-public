import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_fiat_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestAmountScreen extends StatefulWidget {
  const RequestAmountScreen({Key? key}) : super(key: key);

  @override
  State<RequestAmountScreen> createState() => _RequestAmountScreenState();
}

class _RequestAmountScreenState extends State<RequestAmountScreen> {
  CryptoAmount _tokenAmount = const CryptoAmount(
    currency: Currency.sol,
    value: 0,
  );
  FiatAmount _fiatAmount = const FiatAmount(value: 0, currency: Currency.usd);
  final _availableTokens = [Token.sol].lock;

  void _onSubmitted() =>
      context.read<LinkRequestFlowRouter>().onAmountSubmitted();

  void _updateTokenAmount(Decimal value) => setState(() {
        _tokenAmount = _tokenAmount.copyWith(
          value: _tokenAmount.currency.decimalToInt(value),
        );
      });

  void _updateFiatAmount(Decimal value) => setState(() {
        _fiatAmount = _fiatAmount.copyWith(
          value: _fiatAmount.currency.decimalToInt(value),
        );
      });

  void _updateToken(Token _) {}

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            nextButton: CpButton(
              onPressed: _tokenAmount.value != 0 ? _onSubmitted : null,
              text: context.l10n.next,
            ),
          ),
          body: TokenFiatInputWidget(
            tokenAmount: _tokenAmount,
            fiatAmount: _fiatAmount,
            onTokenAmountChanged: _updateTokenAmount,
            onFiatAmountChanged: _updateFiatAmount,
            onTokenChanged: _updateToken,
            currency: Currency.usd,
            availableTokens: _availableTokens,
          ),
        ),
      );
}
