import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';

import '../../../core/amount.dart';
import '../../../core/cancelable_job.dart';
import '../../../core/link_payments.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.txConfirmed] payments and generates the links.
@injectable
class TxConfirmedWatcher extends PaymentWatcher {
  TxConfirmedWatcher(super._repository);

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPConfirmedJob(payment);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchTxConfirmed();
}

class _OLPConfirmedJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPConfirmedJob(this.payment);

  final OutgoingLinkPayment payment;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusTxConfirmed) {
      return payment;
    }

    final token = payment.amount.token;

    final privateKey = status.escrow.bytes.lock;
    final key = base58encode(privateKey.toList());

    final link = LinkPayments(
      key: key,
      token: token.publicKey,
    ).toShareableLink();

    final newStatus = OLPStatus.linkReady(
      link: link,
      escrow: status.escrow,
    );

    return payment.copyWith(
      status: newStatus,
      linksGeneratedAt: DateTime.now(),
    );
  }
}
