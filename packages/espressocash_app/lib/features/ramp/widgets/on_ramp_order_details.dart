import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../services/on_ramp_order_service.dart';

export '../services/on_ramp_order_service.dart' show OnRampOrder;

typedef OnRampOrderDetailsBuilder = Widget Function(BuildContext context, OnRampOrder? order);

class OnRampOrderDetails extends StatefulWidget {
  const OnRampOrderDetails({super.key, required this.orderId, required this.builder});

  final String orderId;
  final OnRampOrderDetailsBuilder builder;

  @override
  State<OnRampOrderDetails> createState() => _OnRampOrderDetailsState();
}

class _OnRampOrderDetailsState extends State<OnRampOrderDetails> {
  late final Stream<OnRampOrder> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<OnRampOrderService>().watch(widget.orderId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: _stream,
    builder: (context, snapshot) => widget.builder(context, snapshot.data),
  );
}
