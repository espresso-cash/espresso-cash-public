import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/transactions/widgets/transfer_progress.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../core/landing_desktop.dart';
import '../../../data/db_landing.dart';
import '../../../di.dart';
import '../service/order_service.dart';
import '../widgets/invoice.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.id});

  final String id;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final Stream<PaymentOrder?> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<IncomingDlnPaymentService>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          final order = snapshot.data;

          return order == null
              ? TransferProgress(onBack: () => context.router.pop())
              : _Desktop(order);
        },
      );
}

class _Desktop extends StatelessWidget {
  const _Desktop(this.order);

  final PaymentOrder order;

  @override
  Widget build(BuildContext context) {
    final request = order.request;

    final status = switch (order.status) {
      PaymentStatus.txSent => 'Pending',
      PaymentStatus.success => 'Success',
      PaymentStatus.txFailure || PaymentStatus.unfulfilled => 'Failed',
    };

    final requestAmount = order.request.requestAmount;
    final fee = order.fee;
    final total = requestAmount + fee;

    return LandingDesktopPage(
      title: context.l10n.landingThankYouLbl,
      subtitle: context.l10n.landingPaymentSent,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Assets.landing.receipt.image(height: 87, width: 87),
          ),
          const Divider(color: borderColor),
          const Spacer(),
          _Item(
            title: context.l10n.landingStatusLbl,
            value: status,
          ),
          _Item(
            title: context.l10n.landingRequestAmountLbl,
            value: requestAmount.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            title: context.l10n.landingFeeLbl,
            value: fee.format(context.locale, maxDecimals: 2),
          ),
          _Item(
            title: context.l10n.landingTotalLbl,
            value: total.format(context.locale, maxDecimals: 2),
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
