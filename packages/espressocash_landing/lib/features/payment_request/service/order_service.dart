import 'dart:async';

import 'package:espressocash_common/espressocash_common.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../models/request_model.dart';

typedef PaymentOrder = ({
  PaymentStatus status,
  CryptoAmount fee,
  IncomingPaymentRequest request,
});

enum PaymentStatus {
  txSent,
  txFailure,
  success,
  unfulfilled,
}

@singleton
class IncomingDlnPaymentService implements Disposable {
  IncomingDlnPaymentService();

  final _order = BehaviorSubject<PaymentOrder?>.seeded(null);

  Stream<PaymentOrder?> watch() => _order.stream;

  void create({
    required IncomingPaymentRequest request,
    required CryptoAmount fee,
  }) {
    final order = (
      status: PaymentStatus.txSent,
      fee: fee,
      request: request,
    );

    _order.add(order);
  }

  @override
  void onDispose() {
    _order.close();
  }
}
