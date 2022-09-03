import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/flow.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/send_flow.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RequestPayFlowScreen extends StatefulWidget {
  const RequestPayFlowScreen({Key? key}) : super(key: key);

  @override
  State<RequestPayFlowScreen> createState() => _State();
}

class _State extends State<RequestPayFlowScreen> implements RequestPayRouter {
  late final RequestPayBloc _requestPayBloc;

  @override
  void initState() {
    super.initState();
    _requestPayBloc = RequestPayBloc(
      balances: context.read<BalancesBloc>().state.balances,
    );
  }

  @override
  void dispose() {
    _requestPayBloc.close();
    super.dispose();
  }

  @override
  void onAmountUpdate(String value) {
    final locale = DeviceLocale.localeOf(context);
    final amount = value.toDecimalOrZero(locale);
    _requestPayBloc.add(RequestPayEvent.amountUpdated(amount));
  }

  @override
  void onRequest() {
    final amount = _requestPayBloc.state.amount;

    if (amount.value == 0) {
      return _showZeroAmountDialog(_Operation.request);
    }

    context.navigateToReceiveByLink(amount: amount);
  }

  @override
  void onPay() {
    final amount = _requestPayBloc.state.amount;

    if (amount.value == 0) {
      return _showZeroAmountDialog(_Operation.pay);
    }

    _requestPayBloc.validate().fold(
          (e) => e.map(
            insufficientFunds: (e) => _showInsufficientTokenDialog(
              balance: e.balance,
              currentAmount: e.currentAmount,
            ),
            insufficientFee: (e) => _showInsufficientFeeDialog(e.requiredFee),
          ),
          (_) => context.navigateToLinkConfirmation(amount: amount),
        );
  }

  void _showZeroAmountDialog(_Operation operation) => showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(operation.buildText(context)),
      );

  void _showInsufficientTokenDialog({
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

  void _showInsufficientFeeDialog(Amount fee) => showWarningDialog(
        context,
        title: context.l10n.insufficientFundsForFeeTitle,
        message: context.l10n.insufficientFundsForFeeMessage(
          fee.currency.symbol,
          fee.format(DeviceLocale.localeOf(context)),
        ),
      );

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: MultiProvider(
            providers: [
              BlocProvider<RequestPayBloc>.value(value: _requestPayBloc),
              Provider<RequestPayRouter>.value(value: this),
            ],
            child: const AutoRouter(),
          ),
        ),
      );
}

abstract class RequestPayRouter {
  void onAmountUpdate(String value);
  void onRequest();
  void onPay();
}

enum _Operation { request, pay }

extension on _Operation {
  String buildText(BuildContext context) {
    switch (this) {
      case _Operation.pay:
        return context.l10n.operationSend;
      case _Operation.request:
        return context.l10n.operationRequest;
    }
  }
}
