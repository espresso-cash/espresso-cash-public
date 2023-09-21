import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';

import '../../../core/amount.dart';
import '../../../core/cancelable_job.dart';
import '../../../core/link_payments.dart';
import '../data/repository.dart';
import '../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OSKPStatus.txConfirmed] payments and generates the links.
@injectable
class TxConfirmedWatcher extends PaymentWatcher {
  TxConfirmedWatcher(super._repository);

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPConfirmedJob(payment);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchTxConfirmed();
}

class _OSKPConfirmedJob extends CancelableJob<OutgoingSplitKeyPayment> {
  const _OSKPConfirmedJob(this.payment);

  final OutgoingSplitKeyPayment payment;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusTxConfirmed) {
      return payment;
    }

    final token = payment.amount.token;

    final privateKey = status.escrow.bytes.lock;
    final key = base58encode(privateKey.toList());

    final link = LinkPayments(
      key: key,
      token: token.publicKey,
    ).toShareableLink();

    final newStatus = OSKPStatus.linksReady(
      link: link,
      escrow: status.escrow,
    );

    return payment.copyWith(
      status: newStatus,
      linksGeneratedAt: DateTime.now(),
    );
  }
}
