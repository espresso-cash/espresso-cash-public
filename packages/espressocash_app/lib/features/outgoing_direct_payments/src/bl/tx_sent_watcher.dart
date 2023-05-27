import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_direct_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [ODPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OutgoingDirectPayment> createJob(
    OutgoingDirectPayment payment,
  ) =>
      _ODPTxSentJob(payment, _sender);

  @override
  Stream<IList<OutgoingDirectPayment>> watchPayments(
    ODPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ODPTxSentJob extends CancelableJob<OutgoingDirectPayment> {
  const _ODPTxSentJob(this.payment, this.sender);

  final OutgoingDirectPayment payment;
  final TxSender sender;

  @override
  Future<OutgoingDirectPayment?> process() async {
    final status = payment.status;
    if (status is! ODPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: BigInt.zero);

    final ODPStatus? newStatus = tx.map(
      success: (_) => ODPStatus.success(txId: status.tx.id),
      failure: (tx) => ODPStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
