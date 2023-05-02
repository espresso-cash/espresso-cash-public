import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.recoveredCancelTxCreated] payments and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class RecoverCancelTxCreatedWatcher extends PaymentWatcher {
  RecoverCancelTxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPRecoverCancelTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchRecoverCancelTxCreated();
}

class _OSKPRecoverCancelTxCreatedJob
    extends CancelableJob<OutgoingSplitKeyPayment> {
  _OSKPRecoverCancelTxCreatedJob(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusRecoveredCancelTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final OSKPStatus? newStatus = tx.map(
      sent: (_) => OSKPStatus.recoveredCancelTxSent(
        status.tx,
        escrowPubKey: status.escrowPubKey,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => OSKPStatus.recoveredCancelTxFailure(
        reason: TxFailureReason.invalidBlockhashSending,
        escrowPubKey: status.escrowPubKey,
      ),
      failure: (it) => OSKPStatus.recoveredCancelTxFailure(
        reason: it.reason,
        escrowPubKey: status.escrowPubKey,
      ),
      networkError: (_) => null,
    );

    if (newStatus == null) {
      return null;
    }

    return payment.copyWith(status: newStatus);
  }
}
