import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@Singleton(scope: authScope)
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(
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
      _OLPSentJob(payment, _sender, _analyticsManager);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _OLPSentJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPSentJob(this.payment, this.sender, this._analyticsManager);

  final OutgoingLinkPayment payment;
  final TxSender sender;
  final AnalyticsManager _analyticsManager;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingLinkPayment',
    );

    final OLPStatus? newStatus = tx.map(
      success: (_) => OLPStatus.txConfirmed(escrow: status.escrow),
      failure: (tx) => OLPStatus.txFailure(reason: tx.reason),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    if (newStatus is OLPStatusTxConfirmed) {
      _analyticsManager.singleLinkCreated(amount: payment.amount.decimal);
    }

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
