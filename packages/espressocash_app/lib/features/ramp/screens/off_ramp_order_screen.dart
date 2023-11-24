import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../kado/services/off_ramp_order_watcher.dart';
import '../models/ramp_partner.dart';
import '../scalex/services/scalex_off_ramp_order_watcher.dart';
import '../services/off_ramp_order_service.dart';
import '../src/models/ramp_watcher.dart';

@RoutePage()
class OffRampOrderScreen extends StatefulWidget {
  const OffRampOrderScreen({super.key, required this.orderId});

  final String orderId;

  static const route = OffRampOrderRoute.new;

  @override
  State<OffRampOrderScreen> createState() => _OffRampOrderScreenState();
}

class _OffRampOrderScreenState extends State<OffRampOrderScreen> {
  late final Stream<OffRampOrder> _stream;
  RampWatcher? _watcher;

  @override
  void initState() {
    super.initState();
    _stream = sl<OffRampOrderService>().watch(widget.orderId);

    _initWatcher();
  }

  Future<void> _initWatcher() async {
    if (_watcher != null) return;

    final onRamp = await _stream.first;

    _watcher = switch (onRamp.partner) {
      RampPartner.kado => sl<KadoOffRampOrderWatcher>(),
      RampPartner.scalex => sl<ScalexOffRampOrderWatcher>(),
      RampPartner.rampNetwork ||
      RampPartner.coinflow ||
      RampPartner.guardarian =>
        throw ArgumentError('Not implemented'),
    }
      ..watch(widget.orderId);
  }

  @override
  void dispose() {
    _watcher?.close();
    super.dispose();
  }

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
                        sl<OffRampOrderService>().retry(widget.orderId);
                      },
                    ),
                  if (order?.status == OffRampOrderStatus.depositTxRequired)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: 'Create deposit tx',
                      onPressed: () {
                        sl<OffRampOrderService>().retry(widget.orderId);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
}
