import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../../../core/extensions.dart';
import '../../../di.dart';
import '../../../ui/arrow.dart';
import '../../../ui/landing_desktop.dart';
import '../../../ui/landing_mobile.dart';
import '../models/request_model.dart';
import '../service/confirmation_bloc.dart';
import '../service/order_service.dart';
import '../widgets/dropdown.dart';
import '../widgets/invoice.dart';
import 'result_screen.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({
    super.key,
    required this.request,
  });

  final SolanaPayRequest request;

  @override
  State<OtherWalletScreen> createState() => _OtherWalletScreenState();
}

class _OtherWalletScreenState extends State<OtherWalletScreen> {
  late final _bloc = sl<IncomingPaymentBloc>();

  @override
  void initState() {
    super.initState();

    final request = widget.request;

    _bloc.add(
      IncomingPaymentEvent.init(
        IncomingPaymentRequest(
          receiverAddress: request.recipient.toBase58(),
          requestAmount: Amount.fromDecimal(
            value: request.amount ?? Decimal.zero,
            currency: Currency.usdc,
          ) as CryptoAmount,
          solanaReferenceAddress: request.reference?.first.toBase58(),
          receiverName: request.label,
        ),
      ),
    );
  }

  void _onChainChanged(Blockchain chain) =>
      _bloc.add(IncomingPaymentEvent.chainChanged(chain));

  void _onSubmit() => _bloc.add(const IncomingPaymentEvent.confirmed());

  Future<void> _onSuccess({
    required String txId,
    required IncomingPaymentRequest request,
    required UserWalletInfo sender,
    required CryptoAmount fee,
  }) async {
    final id = await sl<IncomingDlnPaymentService>().create(
      request: request,
      sender: sender,
      txId: txId,
      fee: fee,
    );

    if (!mounted) return;

    Navigator.of(context).pop();

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ResultScreen(id: id),
      ),
    );
  }

  Future<void> _onException(PaymentException e) async {
    await showWarningDialog(
      context,
      title: context.l10n.swapErrorTitle,
      message: e.description(context),
    );

    _bloc.add(const IncomingPaymentEvent.invalidated());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<IncomingPaymentBloc, IncomingPaymentState>(
        bloc: _bloc,
        listenWhen: (prev, cur) => prev.flowState != cur.flowState,
        listener: (context, state) => switch (state.flowState) {
          FlowFailure(:final error) => _onException(error),
          FlowSuccess(:final result) => () {
              final request = state.request;
              final sender = state.sender;

              if (request == null || sender == null) {
                return;
              }

              _onSuccess(
                request: request,
                sender: sender,
                fee: result.$1.fee,
                txId: result.$2,
              );
            }(),
          _ => null,
        },
        builder: (context, state) => CpLoader(
          isLoading: state.flowState.isProcessing,
          child: isMobile
              ? _Mobile(
                  onSubmit: _onSubmit,
                  onChainChanged: _onChainChanged,
                  state: state,
                )
              : _Desktop(
                  onChainChanged: _onChainChanged,
                  onSubmit: _onSubmit,
                  state: state,
                ),
        ),
      );
}

class _Desktop extends StatelessWidget {
  const _Desktop({
    required this.onChainChanged,
    required this.onSubmit,
    required this.state,
  });

  final IncomingPaymentState state;

  final ValueChanged<Blockchain> onChainChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final request = state.request;
    final chain = state.sender?.blockchain;

    final inputAmount =
        request?.requestAmount.format(context.locale, maxDecimals: 2) ?? '0';

    final receiver =
        request?.receiverName != null ? 'to ${request?.receiverName}' : '';

    final title = 'Pay $inputAmount $receiver';

    return LandingDesktopPage(
      title: title,
      content: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                context.l10n.landingNetworkLbl,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 24),
              BlockchainDropDown(
                current: chain ?? Blockchain.ethereum,
                onBlockchainChanged: onChainChanged,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: borderColor),
          const Spacer(),
          _Item(
            label: context.l10n.landingRequestAmountLbl,
            value: state.inputAmount.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            label: context.l10n.landingFeeLbl,
            value: state.fee.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            label: context.l10n.landingTotalLbl,
            value: state.totalAmount.format(context.locale, maxDecimals: 2),
          ),
          const SizedBox(height: 32),
          CpButton(
            text: 'Pay with Metamask',
            size: CpButtonSize.big,
            width: 500,
            trailing: const LandingArrow(),
            onPressed: state.quote != null ? onSubmit : null,
          ),
          if (request?.solanaReferenceAddress case final reference?) ...[
            const Spacer(),
            const SizedBox(height: 24),
            InvoiceWidget(address: reference),
          ],
        ],
      ),
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile({
    required this.onSubmit,
    required this.onChainChanged,
    required this.state,
  });

  final IncomingPaymentState state;

  final VoidCallback onSubmit;
  final ValueChanged<Blockchain> onChainChanged;

  @override
  Widget build(BuildContext context) {
    final request = state.request;
    final chain = state.sender?.blockchain;

    final inputAmount =
        request?.requestAmount.format(context.locale, maxDecimals: 2) ?? '0';

    return LandingMobilePage(
      header: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            request?.receiverName == null
                ? context.l10n.landingRequestTitle
                : context.l10n
                    .landingUserRequestingTitle(request?.receiverName ?? ''),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.23,
            ),
          ),
          Text(
            inputAmount,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          const Spacer(),
          Text(
            context.l10n.landingNetworkLbl,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 24),
          BlockchainDropDown(
            current: chain ?? Blockchain.ethereum,
            onBlockchainChanged: onChainChanged,
          ),
          const SizedBox(height: 16),
          const Divider(color: borderColor),
          const SizedBox(height: 24),
          _Item(
            label: context.l10n.landingRequestAmountLbl,
            value: state.inputAmount.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            label: context.l10n.landingFeeLbl,
            value: state.fee.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            label: context.l10n.landingTotalLbl,
            value: state.totalAmount.format(context.locale, maxDecimals: 2),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CpButton(
              text: 'Pay with Metamask',
              size: CpButtonSize.big,
              width: 500,
              trailing: const LandingArrow(),
              onPressed: state.quote != null ? onSubmit : null,
            ),
          ),
          if (request?.solanaReferenceAddress case final reference?) ...[
            const Spacer(),
            InvoiceWidget(address: reference),
          ],
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

extension on PaymentException {
  String description(BuildContext context) => this.map(
        other: always(context.l10n.landingGenericError),
        quoteNotFound: always(context.l10n.outgoingDlnNoQuoteFound),
        unsupportedChain: always(context.l10n.landingUnsupportedChainError),
      );
}
