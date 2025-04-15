import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../payment_request/data/watch_payment_request.dart';
import '../../payment_request/models/payment_request.dart';
import '../../payment_request/screens/payment_request_screen.dart';
import '../../payment_request/widgets/formatted_amount.dart';
import 'activity_tile.dart';

class PaymentRequestTile extends StatefulWidget {
  const PaymentRequestTile({super.key, required this.id, this.showIcon = true});

  final String id;
  final bool showIcon;

  @override
  State<PaymentRequestTile> createState() => _PaymentRequestTileState();
}

class _PaymentRequestTileState extends State<PaymentRequestTile> {
  late Stream<(PaymentRequest, String)> _stream;

  @override
  void initState() {
    super.initState();
    _stream = watchPaymentRequest(widget.id).asyncMap((p) async {
      if (!mounted) return (p, '');

      return (p, await p.formattedAmount(DeviceLocale.localeOf(context)));
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<(PaymentRequest, String)>(
    stream: _stream,
    builder: (context, snapshot) {
      final data = snapshot.data;

      return (data == null)
          ? SizedBox.shrink(key: ValueKey(widget.id))
          : CpActivityTile(
            key: ValueKey(widget.id),
            title: context.l10n.paymentRequestTitle,
            icon: Assets.icons.paymentIcon.svg(),
            timestamp: context.formatDate(data.$1.created),
            incomingAmount: data.$2,
            status: switch (data.$1.state) {
              PaymentRequestState.initial => CpActivityTileStatus.inProgress,
              PaymentRequestState.completed => CpActivityTileStatus.success,
              PaymentRequestState.error => CpActivityTileStatus.failure,
            },
            onTap: () => PaymentRequestScreen.push(context, id: data.$1.id),
            showIcon: widget.showIcon,
          );
    },
  );
}
