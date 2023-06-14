import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'incoming_split_key_payment.dart';
import 'iskp_repository.dart';
import 'payment_watcher.dart';

/// Watches for [ISKPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<IncomingSplitKeyPayment> createJob(
    IncomingSplitKeyPayment payment,
  ) =>
      _ISKPTxSentJob(payment, _sender);

  @override
  Stream<IList<IncomingSplitKeyPayment>> watchPayments(
    ISKPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ISKPTxSentJob extends CancelableJob<IncomingSplitKeyPayment> {
  const _ISKPTxSentJob(this.payment, this.sender);

  final IncomingSplitKeyPayment payment;
  final TxSender sender;

  @override
  Future<IncomingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! ISKPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final newStatus = tx.map(
      success: (_) => ISKPStatus.success(txId: status.tx.id),
      failure: (_) => const ISKPStatus.txFailure(
        reason: TxFailureReason.escrowFailure,
      ),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
