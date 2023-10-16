import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _OLPCreatedJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPCreatedJob(this.payment, this.sender);

  final OutgoingLinkPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final OLPStatus? newStatus = tx.map(
      sent: (_) => OLPStatus.txSent(
        status.tx,
        escrow: status.escrow,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const OLPStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => OLPStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
