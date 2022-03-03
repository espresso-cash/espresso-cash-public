import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/enter_amount/component/token_fiat_switcher_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/send_flow_router.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({Key? key}) : super(key: key);

  @override
  _EnterAmountScreenState createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  late final Locale locale;
  final _switcherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _insufficientTokenDialog({
    required Amount balance,
    required Amount currentAmount,
  }) =>
      showWarningDialog(
        context,
        title: context.l10n.insufficientFundsTitle,
        message: context.l10n.insufficientFundsMessage(
          currentAmount.format(
            DeviceLocale.localeOf(context),
          ),
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

  void _onSubmitted() {
    context.read<CreateOutgoingTransferBloc>().validate().fold(
          (e) => e.map(
            insufficientFunds: (e) => _insufficientTokenDialog(
              balance: e.balance,
              currentAmount: e.currentAmount,
            ),
            insufficientFee: (e) => _insufficientFeeDialog(e.requiredFee),
          ),
          (_) => context.read<SendFlowRouter>().onAmountSubmitted(),
        );
  }

  void _updateToken(Token token) {
    final event = CreateOutgoingTransferEvent.tokenUpdated(token);
    context.read<CreateOutgoingTransferBloc>().add(event);
  }

  void _updateTokenAmount(Decimal amount) => context
      .read<CreateOutgoingTransferBloc>()
      .add(CreateOutgoingTransferEvent.tokenAmountUpdated(amount));

  void _updateFiatAmount(Decimal amount) => context
      .read<CreateOutgoingTransferBloc>()
      .add(CreateOutgoingTransferEvent.fiatAmountUpdated(amount));

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateOutgoingTransferBloc, CreateOutgoingTransferState>(
        builder: (context, state) => CpTheme.dark(
          child: Scaffold(
            appBar: CpAppBar(
              nextButton: CpButton(
                onPressed: state.tokenAmount.value != 0 ? _onSubmitted : null,
                text: context.l10n.next,
              ),
            ),
            body: TokenFiatSwitcherInputWidget(
              key: _switcherKey,
              tokenAmount: state.tokenAmount,
              fiatAmount: state.fiatAmount,
              token: state.token,
              onTokenAmountChanged: _updateTokenAmount,
              onFiatAmountChanged: _updateFiatAmount,
              onTokenChanged: _updateToken,
              currency: Currency.usd,
            ),
          ),
        ),
      );
}
