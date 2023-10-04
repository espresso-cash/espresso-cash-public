import 'dart:async';

import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

import '../../../core/cancelable_job.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';

abstract class OutgoingDlnPaymentWatcher {
  OutgoingDlnPaymentWatcher(this._repository);

  final OutgoingDlnPaymentRepository _repository;

  StreamSubscription<void>? _repoSubscription;
  final Map<String, CancelableOperation<void>> _operations = {};

  @protected
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  );

  @protected
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment);

  void call({required VoidCallback onBalanceAffected}) {
    _repoSubscription =
        watchOrders(_repository).distinct().listen((orders) async {
      final keys = orders.map((e) => e.id).toSet();
      for (final key in _operations.keys) {
        if (!keys.contains(key)) {
          await _operations[key]?.cancel();
        }
      }

      for (final order in orders) {
        final job = _operations[order.id];
        if (job != null) return;

        _operations[order.id] = createJob(order).call().then((newOrder) async {
          if (order != newOrder) {
            if (newOrder.status.affectsBalance) {
              onBalanceAffected();
            }
            await _repository.save(newOrder);
          }
          _operations.remove(order.id);
        });
      }
    });
  }

  @mustCallSuper
  void dispose() {
    _repoSubscription?.cancel();
    for (final subscription in _operations.values) {
      subscription.cancel();
    }
  }
}

extension on OutgoingDlnPaymentStatus {
  bool get affectsBalance => this.map(
        txCreated: F,
        txSent: F,
        success: F,
        txFailure: F,
        fulfilled: T,
        cancelled: F,
      );
}
