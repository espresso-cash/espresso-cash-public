import 'dart:async';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../../transactions/models/tx_results.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OLPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@Singleton(scope: authScope)
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._ecClient, super._refreshBalance);

  final EspressoCashClient _ecClient;

  @override
  CancelableJob<OutgoingLinkPayment> createJob(
    OutgoingLinkPayment payment,
  ) =>
      _OLPCreatedJob(payment, _ecClient);

  @override
  Stream<IList<OutgoingLinkPayment>> watchPayments(
    OLPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _OLPCreatedJob extends CancelableJob<OutgoingLinkPayment> {
  const _OLPCreatedJob(this.payment, this.client);

  final OutgoingLinkPayment payment;
  final EspressoCashClient client;

  @override
  Future<OutgoingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! OLPStatusTxCreated) {
      return payment;
    }

    final tx = status.tx;

    printLongString(tx.encode());

    try {
      // await client.submitDurableTx(
      //   SubmitDurableTxRequestDto(
      //     tx: tx.encode(),
      //   ),
      // );

      return payment.copyWith(
        status: OLPStatus.txSent(
          tx,
          escrow: status.escrow,
        ),
      );
    } on Exception catch (ex) {
      print(ex);

      return payment.copyWith(
        status: const OLPStatus.txFailure(
          reason: TxFailureReason.creatingFailure, //TODO
        ),
      );
    }

    // final tx = await sender.send(status.tx, minContextSlot: BigInt.zero);

    // final OLPStatus? newStatus = tx.map(
    //   sent: (_) => OLPStatus.txSent(
    //     status.tx,
    //     escrow: status.escrow,
    //   ),
    //   invalidBlockhash: (_) => const OLPStatus.txFailure(
    //     reason: TxFailureReason.invalidBlockhashSending,
    //   ),
    //   failure: (it) => OLPStatus.txFailure(reason: it.reason),
    //   networkError: (_) => null,
    // );

    // return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}

/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}
