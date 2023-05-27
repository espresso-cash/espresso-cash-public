import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_direct_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [ODPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingDirectPayment> createJob(
    OutgoingDirectPayment payment,
  ) =>
      _ODPTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OutgoingDirectPayment>> watchPayments(
    ODPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _ODPTxCreatedJob extends CancelableJob<OutgoingDirectPayment> {
  const _ODPTxCreatedJob(this.payment, this.sender);

  final OutgoingDirectPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingDirectPayment?> process() async {
    final status = payment.status;
    if (status is! ODPStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final ODPStatus? newStatus = tx.map(
      sent: (_) => ODPStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const ODPStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => ODPStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
