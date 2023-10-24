import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:dln_api/dln_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import '../../../core/cancelable_job.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OutgoingDlnPaymentStatus.success] orders and waits for the tx to be
/// fulfilled.
@injectable
class TxSuccessWatcher extends OutgoingDlnPaymentWatcher {
  TxSuccessWatcher(super._repository, this._client);

  final DlnApiClient _client;

  @override
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment) =>
      _OrderTxSentJob(payment, _client);

  @override
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  ) =>
      repository.watchTxSuccess();
}

class _OrderTxSentJob extends CancelableJob<OutgoingDlnPayment> {
  const _OrderTxSentJob(this.payment, this.client);

  final OutgoingDlnPayment payment;
  final DlnApiClient client;

  @override
  Future<OutgoingDlnPayment?> process() async {
    final status = payment.status;

    if (status is! OutgoingDlnPaymentStatusSuccess) {
      return payment;
    }

    final String? orderId = status.orderId ??
        await client
            .getOrderIdByHash(status.tx.id)
            .letAsync((p) => p.orderIds.firstOrNull);

    if (orderId == null) {
      return payment;
    }

    final orderStatus = await client.getStatus(orderId);
    final isFulfilled = orderStatus.status == OrderStatus.fulfilled;

    return isFulfilled
        ? payment.copyWith(
            status: OutgoingDlnPaymentStatus.fulfilled(status.tx),
          )
        : null;
  }
}
