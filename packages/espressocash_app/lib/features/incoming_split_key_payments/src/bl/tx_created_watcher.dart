import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'incoming_split_key_payment.dart';
import 'iskp_repository.dart';
import 'payment_watcher.dart';

/// Watches for [ISKPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<IncomingSplitKeyPayment> createJob(
    IncomingSplitKeyPayment payment,
  ) =>
      _ISKPTxCreatedJob(payment, _sender);

  @override
  Stream<IList<IncomingSplitKeyPayment>> watchPayments(
    ISKPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _ISKPTxCreatedJob extends CancelableJob<IncomingSplitKeyPayment> {
  const _ISKPTxCreatedJob(this.payment, this.sender);

  final IncomingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<IncomingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! ISKPStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final ISKPStatus? newStatus = tx.map(
      sent: (_) => ISKPStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const ISKPStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => ISKPStatus.txFailure(reason: it.reason),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));

        return null;
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
