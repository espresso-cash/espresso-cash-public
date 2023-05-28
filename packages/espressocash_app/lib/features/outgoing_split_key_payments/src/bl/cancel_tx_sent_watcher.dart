import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.cancelTxSent] payments and waits for the tx to be
/// confirmed.
@injectable
class CancelTxSentWatcher extends PaymentWatcher {
  CancelTxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPCancelTxSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchCancelTxSent();
}

class _OSKPCancelTxSentJob extends CancelableJob<OutgoingSplitKeyPayment> {
  const _OSKPCancelTxSentJob(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusCancelTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final OSKPStatus? newStatus = tx.map(
      success: (_) => OSKPStatus.canceled(
        txId: status.tx.id,
        timestamp: DateTime.now(),
      ),
      failure: (tx) => OSKPStatus.cancelTxFailure(
        reason: tx.reason,
        escrow: status.escrow,
      ),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
