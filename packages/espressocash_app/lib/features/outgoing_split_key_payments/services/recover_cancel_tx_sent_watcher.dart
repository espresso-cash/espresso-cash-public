import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OSKPStatus.recoveredCancelTxSent] payments and waits for the tx to be
/// confirmed.
@injectable
class RecoverCancelTxSentWatcher extends PaymentWatcher {
  RecoverCancelTxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPRecoverCancelTxSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchRecoverCancelTxSent();
}

class _OSKPRecoverCancelTxSentJob
    extends CancelableJob<OutgoingSplitKeyPayment> {
  _OSKPRecoverCancelTxSentJob(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusRecoveredCancelTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final OSKPStatus? newStatus = tx.map(
      success: (_) => OSKPStatus.canceled(
        txId: status.tx.id,
        timestamp: DateTime.now(),
      ),
      failure: (tx) => OSKPStatus.recoveredCancelTxFailure(
        reason: tx.reason,
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
