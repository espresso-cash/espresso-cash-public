import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'islp_payment.dart';
import 'islp_repository.dart';
import 'payment_watcher.dart';

/// Watches for [ISLPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<IncomingSingleLinkPayment> createJob(
    IncomingSingleLinkPayment payment,
  ) =>
      _Job(payment, _sender);

  @override
  Stream<IList<IncomingSingleLinkPayment>> watchPayments(
    ISLPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _Job extends CancelableJob<IncomingSingleLinkPayment> {
  _Job(this.payment, this.sender);

  final IncomingSingleLinkPayment payment;
  final TxSender sender;

  @override
  Future<IncomingSingleLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ISLPStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final ISLPStatus? newStatus = tx.map(
      sent: (_) => ISLPStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const ISLPStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => ISLPStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    if (newStatus == null) {
      return null;
    }

    return payment.copyWith(status: newStatus);
  }
}
