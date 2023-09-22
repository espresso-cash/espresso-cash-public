import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ILPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<IncomingLinkPayment> createJob(
    IncomingLinkPayment payment,
  ) =>
      _ILPTxSentJob(payment, _sender);

  @override
  Stream<IList<IncomingLinkPayment>> watchPayments(
    ILPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ILPTxSentJob extends CancelableJob<IncomingLinkPayment> {
  const _ILPTxSentJob(this.payment, this.sender);

  final IncomingLinkPayment payment;
  final TxSender sender;

  @override
  Future<IncomingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ILPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final newStatus = tx.map(
      success: (_) => ILPStatus.success(txId: status.tx.id),
      failure: (_) => const ILPStatus.txFailure(
        reason: TxFailureReason.escrowFailure,
      ),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
