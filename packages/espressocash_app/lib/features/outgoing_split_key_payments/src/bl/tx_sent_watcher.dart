import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _OSKPSentJob extends CancelableJob<OutgoingSplitKeyPayment> {
  const _OSKPSentJob(this.payment, this.sender);

  final OutgoingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final OSKPStatus? newStatus = tx.map(
      success: (_) => OSKPStatus.txConfirmed(escrow: status.escrow),
      failure: (tx) => OSKPStatus.txFailure(reason: tx.reason),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
