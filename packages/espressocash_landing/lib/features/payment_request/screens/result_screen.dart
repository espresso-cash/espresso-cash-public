import 'package:decimal/decimal.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/desktop_page.dart';
import '../../../ui/footer.dart';
import '../../../utils/extensions.dart';
import '../../request_verifier/service/request_verifier_bloc.dart';
import '../widgets/invoice.dart';

enum PaymentStatus {
  pending,
  success,
  failed,
}

typedef PaymentOrder = ({
  PaymentStatus status,
  CryptoAmount? fee,
  SolanaPayRequest request,
});

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.request,
    this.fee,
  });

  final SolanaPayRequest request;
  final CryptoAmount? fee;

  @override
  Widget build(BuildContext context) {
    final bloc = sl<RequestVerifierBloc>();

    return BlocBuilder<RequestVerifierBloc, PaymentRequestVerifierState>(
      bloc: bloc,
      builder: (context, state) {
        final order = (
          status: switch (state) {
            Waiting() || Retrying() || Verifying() => PaymentStatus.pending,
            Success() => PaymentStatus.success,
            Failure() => PaymentStatus.failed,
          },
          fee: fee,
          request: request,
        );

        return isMobile ? _Mobile(order) : _Desktop(order);
      },
    );
  }
}

class _Desktop extends StatelessWidget {
  const _Desktop(this.order);

  final PaymentOrder order;

  @override
  Widget build(BuildContext context) {
    final request = order.request;

    final status = switch (order.status) {
      PaymentStatus.pending => 'Pending',
      PaymentStatus.success => 'Success',
      PaymentStatus.failed => 'Failed',
    };

    final requestAmount = order.request.requestAmount;
    final fee = order.fee;

    return LandingDesktopPage(
      title: context.l10n.thankYouLbl,
      subtitle: context.l10n.paymentSent,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Assets.images.receipt.image(height: 87, width: 87),
          ),
          const Divider(color: EcLandingColors.borderColor),
          const Spacer(),
          _Item(
            title: context.l10n.statusLbl,
            value: status,
          ),
          _Item(
            title: context.l10n.requestAmountLbl,
            value: requestAmount.format(context.locale, maxDecimals: 2),
          ),
          if (fee != null)
            _Item(
              title: context.l10n.feeLbl,
              value: fee.format(context.locale, maxDecimals: 2),
            ),
          if (fee != null)
            _Item(
              title: context.l10n.totalLbl,
              value:
                  (requestAmount + fee).format(context.locale, maxDecimals: 2),
            ),
          if (request.solanaReferenceAddress case final reference?) ...[
            const Spacer(),
            InvoiceWidget(address: reference),
          ],
        ],
      ),
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile(this.order);

  final PaymentOrder order;

  @override
  Widget build(BuildContext context) {
    final request = order.request;

    final status = switch (order.status) {
      PaymentStatus.pending => 'Pending',
      PaymentStatus.success => 'Success',
      PaymentStatus.failed => 'Failed',
    };

    final requestAmount = order.request.requestAmount;
    final fee = order.fee;

    return _MobileLayout(
      header: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.thankYouLbl,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            context.l10n.paymentSent,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Assets.images.receipt.image(height: 87, width: 87),
          ),
          const Divider(color: EcLandingColors.borderColor),
        ],
      ),
      content: Column(
        children: [
          _Item(
            title: context.l10n.statusLbl,
            value: status,
          ),
          _Item(
            title: context.l10n.requestAmountLbl,
            value: requestAmount.format(context.locale, maxDecimals: 2),
          ),
          if (fee != null)
            _Item(
              title: context.l10n.feeLbl,
              value: fee.format(context.locale, maxDecimals: 2),
            ),
          if (fee != null)
            _Item(
              title: context.l10n.totalLbl,
              value:
                  (requestAmount + fee).format(context.locale, maxDecimals: 2),
            ),
          if (request.solanaReferenceAddress case final reference?) ...[
            const Spacer(),
            InvoiceWidget(address: reference),
          ],
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.content,
    required this.header,
  });

  final Widget header;
  final Widget content;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.45,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Assets.images.logoDark.image(height: 35),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: header,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: content),
                            const Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              child: Footer(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

extension on SolanaPayRequest {
  CryptoAmount get requestAmount => Amount.fromDecimal(
        value: amount ?? Decimal.zero,
        currency: Currency.usdc,
      ) as CryptoAmount;

  String? get solanaReferenceAddress => reference?.first.toBase58();
}
