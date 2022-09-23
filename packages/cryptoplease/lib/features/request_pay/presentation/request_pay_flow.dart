import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/flow.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/flow.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/send_flow.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestPayFlowScreen extends StatefulWidget {
  const RequestPayFlowScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestPayFlowScreen> createState() => _State();
}

class _State extends State<RequestPayFlowScreen> implements RequestRouter {
  late final RequestPayBloc _requestPayBloc;

  @override
  void initState() {
    super.initState();
    _requestPayBloc = context.read<RequestPayBloc>();
  }

  @override
  Future<void> onQrScanner() =>
      context.router.push<QrScannerRequest>(const QrScannerRoute()).then(
        (request) {
          final address = request?.map(
            solanaPay: (r) => r.request.recipient.toBase58(),
            address: (r) => r.addressData.address,
          );
          final name = request?.map(
            solanaPay: (r) => r.request.label,
            address: (r) => r.addressData.name,
          );
          if (address == null) return;

          _requestPayBloc.add(RequestPayEvent.recipientUpdated(address));

          final amount = _requestPayBloc.state.amount.format(
            DeviceLocale.localeOf(context),
            skipSymbol: true,
          );
          context.router.push(
            DirectPayRoute(
              initialAmount: amount,
              recipient: address,
              label: name,
              onClearRecipient: onClearRecipient,
              onAmountUpdate: onAmountUpdate,
              onPay: onPay,
            ),
          );
        },
      );

  @override
  void onClearRecipient() {
    _requestPayBloc.add(const RequestPayEvent.cleared());
    context.router.pop();
  }

  @override
  void onAmountUpdate(String value) {
    final locale = DeviceLocale.localeOf(context);
    final amount = value.toDecimalOrZero(locale);
    _requestPayBloc.add(RequestPayEvent.amountUpdated(amount));
  }

  @override
  void onRequest() {
    if (_requestPayBloc.state.recipient != null) return;

    final amount = _requestPayBloc.state.amount;

    if (amount.value == 0) {
      return _showZeroAmountDialog(_Operation.request);
    }

    context.navigateToReceiveByLink(amount: amount);
  }

  @override
  void onPay() {
    final amount = _requestPayBloc.state.amount;
    final recipient = _requestPayBloc.state.recipient;

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
      (_) {
        if (recipient == null) {
          context.navigateToLinkConfirmation(amount: amount);
        } else {
          _requestPayBloc.add(const RequestPayEvent.directSubmitted());
          context.router.push(
            DirectPayConfirmRoute(onSubmitted: _onPaymentSubmitted),
          );
        }
      },
    );
  }

  void _onPaymentSubmitted(OutgoingTransferId transferId) {
    context
      ..read<HomeRouterKey>().value.currentState?.controller?.popUntilRoot()
      ..navigateToOutgoingTransfer(transferId);
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
              Provider<RequestRouter>.value(value: this),
            ],
            child: const AutoRouter(),
          ),
        ),
      );
}

abstract class RequestRouter {
  void onRequest();
  void onPay();
  void onQrScanner();
  void onClearRecipient();
  void onAmountUpdate(String value);
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
