import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.cancelTxSent] payments and waits for the tx to be
/// confirmed.
@Singleton(scope: authScope)
class CancelTxSentWatcher extends PaymentWatcher {
  CancelTxSentWatcher(
    super._repository,
    this._sender,
    super._refreshBalance,
    this._analyticsManager,
  );

  final TxSender _sender;
  final AnalyticsManager _analyticsManager;

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPCancelTxSentJob(payment, _sender, _analyticsManager);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchCancelTxSent();
}

class _OLPCancelTxSentJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPCancelTxSentJob(this.payment, this.sender, this._analyticsManager);

  final OutgoingLinkPayment payment;
  final TxSender sender;
  final AnalyticsManager _analyticsManager;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusCancelTxSent) {
      return payment;
    }

    final tx = await sender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingLinkPaymentCancelation',
    );

    final OLPStatus? newStatus = tx.map(
      success: (_) => OLPStatus.canceled(
        txId: status.tx.id,
        timestamp: DateTime.now(),
      ),
      failure: (tx) => OLPStatus.cancelTxFailure(
        reason: tx.reason,
        escrow: status.escrow,
      ),
      networkError: (_) => null,
    );

    if (newStatus is OLPStatusCanceled) {
      _analyticsManager.singleLinkCanceled(amount: payment.amount.decimal);
    }

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
