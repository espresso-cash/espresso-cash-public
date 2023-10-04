import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OutgoingDlnPaymentStatus.txCreated] orders and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends OutgoingDlnPaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment) =>
      _OrderTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _OrderTxCreatedJob extends CancelableJob<OutgoingDlnPayment> {
  const _OrderTxCreatedJob(this.payment, this.sender);

  final OutgoingDlnPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingDlnPayment?> process() async {
    final status = payment.status;
    if (status is! OutgoingDlnPaymentStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final OutgoingDlnPaymentStatus? newStatus = tx.map(
      sent: (_) => OutgoingDlnPaymentStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => OutgoingDlnPaymentStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
