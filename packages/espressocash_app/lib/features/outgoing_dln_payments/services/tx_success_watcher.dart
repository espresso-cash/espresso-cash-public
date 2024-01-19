import 'dart:async';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import '../../../core/cancelable_job.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OutgoingDlnPaymentStatus.success] orders and waits for the tx to be
/// fulfilled.
@injectable
class TxSuccessWatcher extends OutgoingDlnPaymentWatcher {
  TxSuccessWatcher(super._repository, this._client);

  final CryptopleaseClient _client;

  @override
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment) =>
      _OrderTxSentJob(payment, _client);

  @override
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  ) =>
      repository.watchTxSuccess();
}

class _OrderTxSentJob extends CancelableJob<OutgoingDlnPayment> {
  const _OrderTxSentJob(this.payment, this.client);

  final OutgoingDlnPayment payment;
  final CryptopleaseClient client;

  @override
  Future<OutgoingDlnPayment?> process() async {
    final status = payment.status;

    if (status is! OutgoingDlnPaymentStatusSuccess) {
      return payment;
    }

    final orderStatus = await client
        .fetchDlnStatus(OrderStatusDlnRequestDto(orderId: status.orderId));
    final isFulfilled = orderStatus.status == DlnOrderStatus.fulfilled;

    if (isFulfilled) {
      return payment.copyWith(
        status: OutgoingDlnPaymentStatus.fulfilled(
          status.tx,
          orderId: status.orderId,
        ),
      );
    }

    final isStale = DateTime.now().difference(payment.created).inMinutes >
        _minutesBeforeStale;

    return isStale
        ? payment.copyWith(
            status: OutgoingDlnPaymentStatus.unfulfilled(
              status.tx,
              orderId: status.orderId,
            ),
          )
        : null;
  }
}

const _minutesBeforeStale = 2;
