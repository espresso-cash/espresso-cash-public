import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';
import '../widgets/request_success.dart';
import '../widgets/share_request.dart';

class PaymentRequestScreen extends StatefulWidget {
  const PaymentRequestScreen({
    super.key,
    required this.id,
  });

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => PaymentRequestScreen(id: id),
        ),
      );

  final String id;

  @override
  State<PaymentRequestScreen> createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  late final Stream<PaymentRequest> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<PaymentRequestRepository>().watchById(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaymentRequest>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) return const LoadingIndicator();

          final isSuccess = data.state == PaymentRequestState.completed;

          return isSuccess
              ? RequestSuccess(request: data)
              : ShareRequestPayment(request: data);
        },
      );
}
