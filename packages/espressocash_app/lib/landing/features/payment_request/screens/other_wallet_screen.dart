import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../core/landing_desktop.dart';
import '../../../core/landing_mobile.dart';
import '../../../di.dart';
import '../models/request_model.dart';
import '../service/bloc.dart';
import '../widgets/arrow.dart';
import '../widgets/dropdown.dart';
import '../widgets/invoice.dart';

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
  final _bloc = sl<IncomingPaymentBloc>();

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

  void _onChainChanged(Blockchain chain) {
    _bloc.add(IncomingPaymentEvent.chainChanged(chain));
  }

  void _onConfirmed() {
    _bloc.add(const IncomingPaymentEvent.confirmed());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _DesktopView(
        onConfirm: _onConfirmed,
        onChainChanged: _onChainChanged,
      );
}

class _DesktopView extends StatelessWidget {
  const _DesktopView({
    required this.onConfirm,
    required this.onChainChanged,
  });

  final VoidCallback onConfirm;
  final ValueChanged<Blockchain> onChainChanged;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<IncomingPaymentBloc, IncomingPaymentState>(
        builder: (context, state) {
          final request = state.request;
          final chain = state.sender?.blockchain;

          final inputAmount =
              request?.requestAmount.format(context.locale, maxDecimals: 2) ??
                  '0';

          final receiver = request?.receiverName != null
              ? 'to ${request?.receiverName}'
              : '';

          final String title = 'Pay $inputAmount $receiver';

          return CpLoader(
            isLoading: state.flowState.isProcessing,
            child: LandingDesktopPage(
              title: title,
              content: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Payment network',
                        style: TextStyle(
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
                    label: 'Amount Requested',
                    value: state.inputAmount
                        .format(context.locale, maxDecimals: 2),
                  ),
                  _Item(
                    label: 'Network Fee',
                    value: state.fee.format(context.locale, maxDecimals: 2),
                  ),
                  _Item(
                    label: 'Total',
                    value: state.totalAmount
                        .format(context.locale, maxDecimals: 2),
                  ),
                  const SizedBox(height: 32),
                  CpButton(
                    text: 'Pay with Metamask',
                    size: CpButtonSize.big,
                    width: 500,
                    trailing: const Arrow(),
                    onPressed: state.quote != null ? onConfirm : null,
                  ),
                  if (request?.solanaReferenceAddress
                      case final reference?) ...[
                    const Spacer(),
                    const SizedBox(height: 24),
                    InvoiceWidget(address: reference),
                  ],
                ],
              ),
            ),
          );
        },
      );
}

class _MobileView extends StatelessWidget {
  const _MobileView({required this.onConfirm, required this.onChainChanged});

  final VoidCallback onConfirm;
  final ValueChanged<Blockchain> onChainChanged;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<IncomingPaymentBloc, IncomingPaymentState>(
        builder: (context, state) {
          final request = state.request;
          final chain = state.sender?.blockchain;

          final inputAmount =
              request?.requestAmount.format(context.locale, maxDecimals: 2) ??
                  '0';

          return CpLoader(
            isLoading: state.flowState.isProcessing,
            child: LandingMobilePage(
              header: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    request?.receiverName == null
                        ? 'You have a request of'
                        : '${request?.receiverName} is requesting',
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
                  const Text(
                    'Payment network',
                    style: TextStyle(
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
                    label: 'Amount Requested',
                    value: state.inputAmount
                        .format(context.locale, maxDecimals: 2),
                  ),
                  _Item(
                    label: 'Network Fee',
                    value: state.fee.format(context.locale, maxDecimals: 2),
                  ),
                  _Item(
                    label: 'Total',
                    value: state.totalAmount
                        .format(context.locale, maxDecimals: 2),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CpButton(
                      text: 'Pay with Metamask',
                      size: CpButtonSize.big,
                      width: 500,
                      trailing: const Arrow(),
                      onPressed: state.quote != null ? onConfirm : null,
                    ),
                  ),
                  if (request?.solanaReferenceAddress
                      case final reference?) ...[
                    const Spacer(),
                    InvoiceWidget(address: reference),
                  ],
                ],
              ),
            ),
          );
        },
      );
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
