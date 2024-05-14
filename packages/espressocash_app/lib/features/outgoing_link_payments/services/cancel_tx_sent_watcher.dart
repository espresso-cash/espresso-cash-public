import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.cancelTxSent] payments and waits for the tx to be
/// confirmed.
@Singleton(scope: authScope)
class CancelTxSentWatcher extends PaymentWatcher {
  CancelTxSentWatcher(super._repository, super._refreshBalance);

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPCancelTxSentJob(payment);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchCancelTxSent();
}

class _OLPCancelTxSentJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPCancelTxSentJob(this.payment);

  final OutgoingLinkPayment payment;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;

    return status is! OLPStatusCancelTxSent
        ? payment
        : payment.copyWith(
            status: OLPStatus.canceled(
              txId: status.tx.id,
              timestamp: DateTime.now(),
            ),
          );
  }
}
