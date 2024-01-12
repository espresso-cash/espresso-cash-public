import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../services/off_ramp_order_service.dart';

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

  @override
  void initState() {
    super.initState();
    _stream = sl<OffRampOrderService>().watch(widget.orderId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) => widget.builder(context, snapshot.data),
      );
}
