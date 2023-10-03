import 'package:flutter/widgets.dart';

import '../../../../di.dart';
import '../../data/on_ramp_order_service.dart';
import '../src/services/kado_on_ramp_order_watcher.dart';

export '../../data/on_ramp_order_service.dart' show OnRampOrder;

class KadoOnRampOrderDetails extends StatefulWidget {
  const KadoOnRampOrderDetails({
    super.key,
    required this.orderId,
    required this.builder,
  });

  final String orderId;
  final Widget Function(BuildContext context, OnRampOrder? order) builder;

  @override
  State<KadoOnRampOrderDetails> createState() => _KadoOnRampOrderDetailsState();
}

class _KadoOnRampOrderDetailsState extends State<KadoOnRampOrderDetails> {
  late final KadoOnRampOrderWatcher _watcher;
  late final Stream<OnRampOrder> _stream;

  @override
  void initState() {
    super.initState();
    _watcher = sl<KadoOnRampOrderWatcher>()..watch(widget.orderId);
    _stream = sl<OnRampOrderService>().watch(widget.orderId);
  }

  @override
  void dispose() {
    _watcher.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) => widget.builder(context, snapshot.data),
      );
}
