import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.recoveredCancelTxSent] payments and waits for the tx to be
/// confirmed.
@injectable
class RecoverCancelTxSentWatcher extends PaymentWatcher {
  RecoverCancelTxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPRecoverCancelTxSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchRecoverCancelTxSent();
}

class _OLPRecoverCancelTxSentJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPRecoverCancelTxSentJob(this.payment, this.sender);

  final OutgoingLinkPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusRecoveredCancelTxSent) return payment;

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final OLPStatus? newStatus = tx.map(
      success: (_) => OLPStatus.canceled(
        txId: status.tx.id,
        timestamp: DateTime.now(),
      ),
      failure: (tx) => OLPStatus.recoveredCancelTxFailure(
        reason: tx.reason,
        escrowPubKey: status.escrowPubKey,
      ),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
