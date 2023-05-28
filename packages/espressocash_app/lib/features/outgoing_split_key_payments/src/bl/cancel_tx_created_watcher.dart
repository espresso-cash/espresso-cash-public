import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.cancelTxCreated] payments and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class CancelTxCreatedWatcher extends PaymentWatcher {
  CancelTxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPCancelTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchCancelTxCreated();
}

class _OSKPCancelTxCreatedJob extends CancelableJob<OutgoingSplitKeyPayment> {
  const _OSKPCancelTxCreatedJob(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusCancelTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final OSKPStatus? newStatus = tx.map(
      sent: (_) => OSKPStatus.cancelTxSent(
        status.tx,
        escrow: status.escrow,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => OSKPStatus.cancelTxFailure(
        reason: TxFailureReason.invalidBlockhashSending,
        escrow: status.escrow,
      ),
      failure: (it) => OSKPStatus.cancelTxFailure(
        reason: it.reason,
        escrow: status.escrow,
      ),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
