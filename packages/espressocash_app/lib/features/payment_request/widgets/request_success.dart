import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/clipboard.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/timeline.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../tokens/token_list.dart';
import '../models/payment_request.dart';

class RequestSuccess extends StatelessWidget {
  const RequestSuccess({
    super.key,
    required this.request,
  });

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) {
    final tokenList = sl<TokenList>();

    final amount = request.payRequest.cryptoAmount(tokenList);

    final requestCreated = CpTimelineItem(
      title: context.l10n.requestPaymentCreated,
      trailing: amount?.let((a) => a.format(context.locale)),
      subtitle: request.created.let((t) => context.formatDate(t)),
    );
    final moneyReceived = CpTimelineItem(
      title: context.l10n.requestPaymentReceived,
      subtitle: request.resolvedAt?.let((t) => context.formatDate(t)),
    );

    return StatusScreen(
      onBackButtonPressed: () => Navigator.pop(context),
      title: context.l10n.requestPaymentTitle.toUpperCase(),
      statusType: CpStatusType.success,
      statusTitle: Text(context.l10n.transferSuccessTitle),
      statusContent: Text(context.l10n.moneyReceived),
      content: CpContentPadding(
        child: Column(
          children: [
            CpTimeline(
              status: CpTimelineStatus.success,
              items: [
                requestCreated,
                moneyReceived,
              ],
              active: 1,
              animated: false,
            ),
            const Spacer(),
            if (request.payRequest.invoice case final reference?)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _InvoiceWidget(reference: reference),
              ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceWidget extends StatelessWidget {
  const _InvoiceWidget({required this.reference});

  final String reference;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.copyToClipboard(reference),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Color(0xff404040),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.txIconDark.svg(
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.invoiceNumber(reference.toShortAddress()),
                style: const TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.23,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      );
}
