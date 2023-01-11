import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../cancel_payment/cancel_payment.dart';
import '../../../outgoing_tip_payments/models/outgoing_tip_payment.dart';
import '../activity.dart';
import 'styles.dart';

class OTTile extends StatelessWidget {
  const OTTile({super.key, required this.activity});

  final OTActivity activity;

  @override
  Widget build(BuildContext context) {
    final escrow = activity.data.escrow;

    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              activity.data.status.maybeMap(
                orElse: () => 'Tip via QR Cod',
                canceled: (_) => 'Tip canceled',
              ),
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
            style: titleStyle,
          )
        ],
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.formatDate(activity.created),
            style: subtitleStyle,
          ),
          if (escrow != null)
            CpButton(
              text: context.l10n.cancel,
              size: CpButtonSize.micro,
              onPressed: () => context.cancelPayment(activity.id, escrow),
            ),
        ],
      ),
      leading: Assets.icons.outgoing.svg(),
      onTap: () => context.router.navigate(OutgoingTipRoute(id: activity.id)),
    );
  }
}

extension on OutgoingTipPayment {
  Ed25519HDKeyPair? get escrow => status.mapOrNull(
        linkReady: (it) => it.escrow,
        txCreated: (it) => it.escrow,
        txSent: (it) => it.escrow,
        txConfirmed: (it) => it.escrow,
        txSendFailure: (it) => it.escrow,
        txWaitFailure: (it) => it.escrow,
        txLinksFailure: (it) => it.escrow,
      );
}
