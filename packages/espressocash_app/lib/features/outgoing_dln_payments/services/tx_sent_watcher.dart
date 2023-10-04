import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OutgoingDlnPaymentStatus.txSent] orders and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends OutgoingDlnPaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment) =>
      _OrderTxSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  ) =>
      repository.watchTxSent();
}

class _OrderTxSentJob extends CancelableJob<OutgoingDlnPayment> {
  const _OrderTxSentJob(this.payment, this.sender);

  final OutgoingDlnPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingDlnPayment?> process() async {
    final status = payment.status;
    if (status is! OutgoingDlnPaymentStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final OutgoingDlnPaymentStatus? newStatus = tx.map(
      success: (_) => OutgoingDlnPaymentStatus.success(status.tx),
      failure: (tx) => OutgoingDlnPaymentStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
