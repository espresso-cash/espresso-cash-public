import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.cancelTxCreated] payments and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class CancelTxCreatedWatcher extends PaymentWatcher {
  CancelTxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPCancelTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchCancelTxCreated();
}

class _OLPCancelTxCreatedJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPCancelTxCreatedJob(this.payment, this.sender);

  final OutgoingLinkPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusCancelTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final OLPStatus? newStatus = tx.map(
      sent: (_) => OLPStatus.cancelTxSent(
        status.tx,
        escrow: status.escrow,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => OLPStatus.cancelTxFailure(
        reason: TxFailureReason.invalidBlockhashSending,
        escrow: status.escrow,
      ),
      failure: (it) => OLPStatus.cancelTxFailure(
        reason: it.reason,
        escrow: status.escrow,
      ),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
