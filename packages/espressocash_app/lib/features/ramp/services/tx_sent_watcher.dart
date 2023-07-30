import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../../core/cancelable_job.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ORPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OffRampPayment> createJob(OffRampPayment payment) =>
      _ORPTxSentJob(payment, _sender, RampFlutter());

  @override
  Stream<IList<OffRampPayment>> watchPayments(ORPRepository repository) =>
      repository.watchTxSent();
}

class _ORPTxSentJob extends CancelableJob<OffRampPayment> {
  const _ORPTxSentJob(this.payment, this.sender, this.ramp);

  final OffRampPayment payment;
  final TxSender sender;
  final RampFlutter ramp;

  @override
  Future<OffRampPayment?> process() async {
    final status = payment.status;
    if (status is! ORPStatusTxSent) return payment;

    final tx = await sender.wait(status.tx, minContextSlot: BigInt.zero);

    final ORPStatus? newStatus = tx.map(
      success: (_) => ORPStatus.success(tx: status.tx),
      failure: (tx) => ORPStatus.txFailure(status.tx, reason: tx.reason),
      networkError: (_) => null,
    );

    if (newStatus == null) return null;

    if (newStatus is ORPStatusSuccess) {
      await ramp.sendCrypto(newStatus.tx.id);
    }

    return payment.copyWith(status: newStatus);
  }
}
