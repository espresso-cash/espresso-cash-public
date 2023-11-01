import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../data/on_ramp_order_service.dart';
import '../kado/widgets/kado_on_ramp_order_details.dart';
import '../src/models/on_ramp_watcher.dart';
import '../src/models/ramp_partner.dart';

export '../data/on_ramp_order_service.dart' show OnRampOrder;

class OnRampOrderDetails extends StatefulWidget {
  const OnRampOrderDetails({
    super.key,
    required this.orderId,
    required this.builder,
  });

  final String orderId;
  final Widget Function(BuildContext context, OnRampOrder? order) builder;

  @override
  State<OnRampOrderDetails> createState() => _OnRampOrderDetailsState();
}

class _OnRampOrderDetailsState extends State<OnRampOrderDetails> {
  late final Stream<OnRampOrder> _stream;
  OnRampWatcher? _watcher;

  @override
  void initState() {
    super.initState();
    _stream = sl<OnRampOrderService>().watch(widget.orderId);

    _initWatcher();
  }

  Future<void> _initWatcher() async {
    if (_watcher != null) return;

    final onRamp = await _stream.first;

    if (onRamp.partner == RampPartner.kado) {
      _watcher = sl<KadoOnRampOrderWatcher>()..watch(widget.orderId);
    }
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
