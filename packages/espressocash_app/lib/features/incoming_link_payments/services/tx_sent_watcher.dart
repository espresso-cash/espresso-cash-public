import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../utils/cancelable_job.dart';
import '../../accounts/auth_scope.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ILPStatus.txSent] payments and waits for the tx to be
/// confirmed.
@Singleton(scope: authScope)
class TxSentWatcher extends PaymentWatcher {
  TxSentWatcher(
    super._repository,
    this._ecClient,
    this._refreshBalance,
  );

  final EspressoCashClient _ecClient;
  final RefreshBalance _refreshBalance;

  @postConstruct
  void init() => call(onBalanceAffected: _refreshBalance.call);

  @override
  CancelableJob<IncomingLinkPayment> createJob(
    IncomingLinkPayment payment,
  ) =>
      _ILPTxSentJob(payment, _ecClient);

  @override
  Stream<IList<IncomingLinkPayment>> watchPayments(
    ILPRepository repository,
  ) =>
      repository.watchTxSent();
}

class _ILPTxSentJob extends CancelableJob<IncomingLinkPayment> {
  const _ILPTxSentJob(this.payment, this._ecClient);

  final IncomingLinkPayment payment;
  final EspressoCashClient _ecClient;

  @override
  Future<IncomingLinkPayment?> process() async {
    final status = payment.status;
    if (status is! ILPStatusTxSent) {
      return payment;
    }

    int? fee;
    try {
      fee = status.tx.containsAta
          ? await _ecClient.getFees().then((value) => value.escrowPaymentAtaFee)
          : null;
    } on Object {
      fee = null;
    }

    return payment.copyWith(
      status: ILPStatus.success(
        tx: status.tx,
        fee: fee?.let(
          (fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc),
        ),
      ),
    );
  }
}

extension SignedTxExt on SignedTx {
  bool get containsAta => decompileMessage().let(
        (m) => m.instructions
            .any((ix) => ix.programId == AssociatedTokenAccountProgram.id),
      );
}
