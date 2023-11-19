import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../ramp/kado/widgets/kado_on_ramp_order_details.dart';
import '../../ramp/services/kado_off_ramp_order_service.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OffRampTile extends StatefulWidget {
  const OffRampTile({super.key, required this.activity});

  final OffRampActivity activity;

  @override
  State<OffRampTile> createState() => _OffRampTileState();
}

class _OffRampTileState extends State<OffRampTile> {
  late final _stream = sl<KadoOffRampOrderService>().watch(widget.activity.id);

  @override
  Widget build(BuildContext context) => StreamBuilder<OffRampOrder>(
        stream: _stream,
        builder: (context, snpahost) {
          final order = snpahost.data;

          return CpActivityTile(
            title: order?.amount.let(
                  (amount) => context.l10n.activities_lblSoldToken(
                    amount.format(
                      context.locale,
                      maxDecimals: 2,
                      roundInteger: true,
                    ),
                  ),
                ) ??
                '',
            icon: Assets.icons.paymentIcon.svg(),
            status: order?.status == OffRampOrderStatus.completed
                ? CpActivityTileStatus.success
                : CpActivityTileStatus.inProgress,
            timestamp: context.formatDate(widget.activity.created),
          );
        },
      );
}
