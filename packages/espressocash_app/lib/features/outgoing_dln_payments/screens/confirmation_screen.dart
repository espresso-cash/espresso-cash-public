import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/amount.dart';
import '../../../core/blockchain.dart';
import '../../../core/callback.dart';
import '../../../core/flow.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/slider.dart';
import '../../accounts/models/account.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';
import '../services/confirm_payment_bloc.dart';

class OutgoingDlnConfirmationScreen extends StatefulWidget {
  const OutgoingDlnConfirmationScreen({
    super.key,
    required this.onConfirm,
    required this.amount,
    required this.receiverAddress,
    required this.blockchain,
  });

  final Callback1<PaymentQuote> onConfirm;
  final CryptoAmount amount;
  final String receiverAddress;
  final Blockchain blockchain;

  @override
  State<OutgoingDlnConfirmationScreen> createState() =>
      _OutgoingDlnConfirmationScreenState();
}

class _OutgoingDlnConfirmationScreenState
    extends State<OutgoingDlnConfirmationScreen> {
  late final ConfirmPaymentBloc _bloc;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _bloc = sl<ConfirmPaymentBloc>(
      param1: DlnPayment(
        inputAmount: widget.amount,
        receiverAddress: widget.receiverAddress,
        receiverBlockchain: widget.blockchain,
      ),
      param2: context.read<MyAccount>().wallet.publicKey,
    );

    _bloc.add(const Invalidated());
  }

  void _resetTimer(DateTime? expiresAt) {
    _timer?.cancel();
    if (expiresAt == null) return;
    _timer = Timer(expiresAt.difference(DateTime.now()), _onQuoteExpired);
  }

  void _onSubmit() {
    const event = ConfirmPaymentEvent.confirmed();
    _bloc.add(event);
  }

  void _onQuoteExpired() {
    const event = ConfirmPaymentEvent.invalidated();
    _bloc.add(event);
  }

  void _onException(CreateOrderException e) => showWarningDialog(
        context,
        title: context.l10n.swapErrorTitle,
        message: e.description(context),
      );

  @override
  void dispose() {
    _bloc.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ConfirmPaymentBloc, ConfirmPaymentState>(
        bloc: _bloc,
        listenWhen: (prev, cur) => prev.expiresAt != cur.expiresAt,
        listener: (context, state) => _resetTimer(state.expiresAt),
        child: BlocConsumer<ConfirmPaymentBloc, ConfirmPaymentState>(
          bloc: _bloc,
          listenWhen: (prev, cur) => prev.flowState != cur.flowState,
          listener: (context, state) => switch (state.flowState) {
            FlowFailure(:final error) => _onException(error),
            FlowSuccess(:final result) => widget.onConfirm(result),
            _ => null,
          },
          builder: (context, state) {
            final receiverAmount = state.receiverAmount.format(
              DeviceLocale.localeOf(context),
              maxDecimals: 2,
              roundInteger: false,
            );

            final totalDeductedAmount = (state.inputAmount + state.fee).format(
              DeviceLocale.localeOf(context),
              maxDecimals: 2,
              roundInteger: false,
            );

            final feeAmount = state.fee.format(
              DeviceLocale.localeOf(context),
              maxDecimals: 2,
              roundInteger: false,
            );

            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const _DisclaimerText(),
                          const SizedBox(height: 32),
                          _Item(
                            title: context.l10n.walletNetwork,
                            value: widget.blockchain.name,
                            backgroundColor: Colors.black,
                          ),
                          _Item(
                            title: context.l10n.walletAddress,
                            value: widget.receiverAddress,
                            backgroundColor: Colors.black,
                          ),
                          if (state.flowState.isProcessing ||
                              state.quote == null) ...[
                            const SizedBox(height: 16),
                            const _Loading(),
                          ] else ...[
                            _Item(
                              title: context.l10n.totalAmount,
                              value: '$totalDeductedAmount ($feeAmount Fee)',
                              backgroundColor: Colors.black,
                            ),
                            _Item(
                              title: context.l10n.transferReceiver,
                              value: receiverAmount,
                              backgroundColor: Colors.black,
                            ),
                          ],
                          const Spacer(),
                          CpContentPadding(
                            child: CpSlider(
                              text: context.l10n.confirm,
                              onSlideCompleted: (state.quote == null ||
                                      state.flowState.isProcessing)
                                  ? null
                                  : _onSubmit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class _DisclaimerText extends StatelessWidget {
  const _DisclaimerText();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: context.l10n.outgoingDlnDisclaimer1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: context.l10n.outgoingDlnDisclaimer2,
                style: const TextStyle(
                  color: Color(0xFFFFDA66),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: context.l10n.outgoingDlnDisclaimer3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.23,
                ),
              ),
            ),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: const StadiumBorder(),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                title: Text(
                  value,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
}

extension on CreateOrderException {
  String description(BuildContext context) => this.map(
        quoteNotFound: always(context.l10n.noQuoteFound),
        insufficientBalance: (e) => context.l10n.insufficientFundsMessage(
          e.amount.format(
            DeviceLocale.localeOf(context),
            maxDecimals: 2,
            roundInteger: false,
          ),
          e.balance.format(
            DeviceLocale.localeOf(context),
            maxDecimals: 2,
            roundInteger: false,
          ),
        ),
        other: always(context.l10n.swapFailUnknown),
      );
}
