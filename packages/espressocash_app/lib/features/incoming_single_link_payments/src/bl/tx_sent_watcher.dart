import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'islp_payment.dart';
import 'islp_repository.dart';
import 'payment_watcher.dart';

/// Watches for [ISLPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<IncomingSingleLinkPayment> createJob(
    IncomingSingleLinkPayment payment,
  ) =>
      _ISLPTxSentJob(payment, _sender);

  @override
  Stream<IList<IncomingSingleLinkPayment>> watchPayments(
    ISLPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ISLPTxSentJob extends CancelableJob<IncomingSingleLinkPayment> {
  _ISLPTxSentJob(this.payment, this.sender);

  final IncomingSingleLinkPayment payment;
  final TxSender sender;

  @override
  Future<IncomingSingleLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ISLPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final ISLPStatus? newStatus = tx.map(
      success: (_) => ISLPStatus.success(txId: status.tx.id),
      failure: (tx) => ISLPStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    if (newStatus == null) {
      return null;
    }

    return payment.copyWith(status: newStatus);
  }
}
