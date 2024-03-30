import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../utils/cancelable_job.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ILPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(super._repository, this._sender, this._ecClient);

  final TxSender _sender;
  final EspressoCashClient _ecClient;

  @override
  CancelableJob<IncomingLinkPayment> createJob(
    IncomingLinkPayment payment,
  ) =>
      _ILPTxSentJob(payment, _sender, _ecClient);

  @override
  Stream<IList<IncomingLinkPayment>> watchPayments(
    ILPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ILPTxSentJob extends CancelableJob<IncomingLinkPayment> {
  const _ILPTxSentJob(this.payment, this.sender, this._ecClient);

  final IncomingLinkPayment payment;
  final TxSender sender;
  final EspressoCashClient _ecClient;

  @override
  Future<IncomingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ILPStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'IncomingLinkPayment',
    );

    final newStatus = await tx.map(
      success: (_) async {
        try {
          final fee = status.tx.containsAta
              ? await _ecClient
                  .getFees()
                  .then((value) => value.escrowPaymentAtaFee)
              : null;

          return ILPStatus.success(
            tx: status.tx,
            fee: fee?.let(
              (fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc),
            ),
          );
        } on Object {
          return null;
        }
      },
      failure: (_) async => const ILPStatus.txFailure(
        reason: TxFailureReason.escrowFailure,
      ),
      networkError: (_) async {
        await Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}

extension SignedTxExt on SignedTx {
  bool get containsAta => decompileMessage().let(
        (m) => m.instructions
            .any((ix) => ix.programId == AssociatedTokenAccountProgram.id),
      );
}
