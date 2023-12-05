import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../kado/services/kado_off_ramp_order_watcher.dart';
import '../models/ramp_partner.dart';
import '../scalex/services/scalex_off_ramp_order_watcher.dart';
import '../services/off_ramp_order_service.dart';
import '../src/models/ramp_watcher.dart';

typedef OffRampOrderDetailsBuilder = Widget Function(
  BuildContext context,
  OffRampOrder? order,
);

class OffRampOrderDetails extends StatefulWidget {
  const OffRampOrderDetails({
    super.key,
    required this.orderId,
    required this.builder,
  });

  final String orderId;
  final OffRampOrderDetailsBuilder builder;

  @override
  State<OffRampOrderDetails> createState() => _OffRampOrderDetailsState();
}

class _OffRampOrderDetailsState extends State<OffRampOrderDetails> {
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

    final ramp = await _stream.first;

    _watcher = switch (ramp.partner) {
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
        builder: (context, snapshot) => widget.builder(context, snapshot.data),
      );
}
