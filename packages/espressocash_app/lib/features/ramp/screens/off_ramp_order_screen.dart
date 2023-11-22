import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../services/kado_off_ramp_order_service.dart';

@RoutePage()
class OffRampOrderScreen extends StatefulWidget {
  const OffRampOrderScreen({super.key, required this.orderId});

  final String orderId;

  static const route = OffRampOrderRoute.new;

  @override
  State<OffRampOrderScreen> createState() => _OffRampOrderScreenState();
}

class _OffRampOrderScreenState extends State<OffRampOrderScreen> {
  late final _stream = sl<KadoOffRampOrderService>().watch(widget.orderId);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          final order = snapshot.data;

          return StatusScreen(
            statusType: order?.status == OffRampOrderStatus.completed
                ? CpStatusType.success
                : order?.status == OffRampOrderStatus.depositError
                    ? CpStatusType.error
                    : CpStatusType.info,
            statusContent: Text(order?.status.name ?? ''),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  if (order?.status == OffRampOrderStatus.depositError)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: context.l10n.retry,
                      onPressed: () {
                        sl<KadoOffRampOrderService>().retry(widget.orderId);
                      },
                    ),
                  if (order?.status == OffRampOrderStatus.depositTxRequired)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: 'Create deposit tx',
                      onPressed: () {
                        sl<KadoOffRampOrderService>().retry(widget.orderId);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
}
