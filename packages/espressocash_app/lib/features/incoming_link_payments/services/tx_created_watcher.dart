import 'dart:async';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../../balances/services/refresh_balance.dart';
import '../../transactions/models/tx_results.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ILPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@Singleton(scope: authScope)
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._ecClient, this._refreshBalance);

  final EspressoCashClient _ecClient;
  final RefreshBalance _refreshBalance;

  @postConstruct
  void init() => call(onBalanceAffected: _refreshBalance.call);

  @override
  CancelableJob<IncomingLinkPayment> createJob(
    IncomingLinkPayment payment,
  ) =>
      _ILPTxCreatedJob(payment, _ecClient);

  @override
  Stream<IList<IncomingLinkPayment>> watchPayments(
    ILPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _ILPTxCreatedJob extends CancelableJob<IncomingLinkPayment> {
  const _ILPTxCreatedJob(this.payment, this.client);

  final IncomingLinkPayment payment;
  final EspressoCashClient client;

  @override
  Future<IncomingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ILPStatusTxCreated) {
      return payment;
    }

    final tx = status.tx;

    try {
      await client.submitDurableTx(
        SubmitDurableTxRequestDto(
          tx: tx.encode(),
        ),
      );

      return payment.copyWith(
        status: ILPStatus.txSent(tx),
      );
    } on Exception catch (ex) {
      return payment.copyWith(
        status: const ILPStatus.txFailure(
          reason: TxFailureReason.creatingFailure, //TODO
        ),
      );
    }

    // final tx = await sender.send(status.tx, minContextSlot: status.slot);

    // final ILPStatus? newStatus = tx.map(
    //   sent: (_) => ILPStatus.txSent(
    //     status.tx,
    //     slot: status.slot,
    //   ),
    //   invalidBlockhash: (_) => const ILPStatus.txFailure(
    //     reason: TxFailureReason.invalidBlockhashSending,
    //   ),
    //   failure: (it) => ILPStatus.txFailure(reason: it.reason),
    //   networkError: (_) {
    //     Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
    //   },
    // );

    // return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
