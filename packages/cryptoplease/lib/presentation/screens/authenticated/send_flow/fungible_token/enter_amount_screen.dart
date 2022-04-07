import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_fiat_input_widget.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AmountSetter {
  void onAmountSet();
}

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({Key? key}) : super(key: key);

  @override
  _EnterAmountScreenState createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final _switcherKey = GlobalKey();

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

  void _onSubmitted() {
    context.read<FtCreateOutgoingTransferBloc>().validate().fold(
          (e) => e.map(
            insufficientFunds: (e) => _insufficientTokenDialog(
              balance: e.balance,
              currentAmount: e.currentAmount,
            ),
            insufficientFee: (e) => _insufficientFeeDialog(e.requiredFee),
          ),
          (_) => context.read<AmountSetter>().onAmountSet(),
        );
  }

  void _updateToken(Token token) {
    final event = FtCreateOutgoingTransferEvent.tokenUpdated(token);
    context.read<FtCreateOutgoingTransferBloc>().add(event);
  }

  void _updateTokenAmount(Decimal amount) => context
      .read<FtCreateOutgoingTransferBloc>()
      .add(FtCreateOutgoingTransferEvent.tokenAmountUpdated(amount));

  void _updateFiatAmount(Decimal amount) => context
      .read<FtCreateOutgoingTransferBloc>()
      .add(FtCreateOutgoingTransferEvent.fiatAmountUpdated(amount));

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FtCreateOutgoingTransferBloc, FtCreateOutgoingTransferState>(
        builder: (context, state) => CpTheme.dark(
          child: Scaffold(
            appBar: CpAppBar(
              leading: BackButton(onPressed: () => context.router.pop()),
              nextButton: CpButton(
                onPressed: state.tokenAmount.value != 0 ? _onSubmitted : null,
                text: context.l10n.next,
              ),
            ),
            body: TokenFiatInputWidget(
              key: _switcherKey,
              tokenAmount: state.tokenAmount,
              fiatAmount: state.fiatAmount,
              onTokenAmountChanged: _updateTokenAmount,
              onFiatAmountChanged: _updateFiatAmount,
              onTokenChanged: _updateToken,
              currency: Currency.usd,
              onMaxRequested: () => context
                  .read<FtCreateOutgoingTransferBloc>()
                  .add(const FtCreateOutgoingTransferEvent.maxRequested()),
              availableTokens: state.availableTokens,
            ),
          ),
        ),
      );
}
