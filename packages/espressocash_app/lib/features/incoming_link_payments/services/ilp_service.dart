import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../escrow_payments/create_incoming_escrow.dart';
import '../../escrow_payments/escrow_exception.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_confirm.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';

@Singleton(scope: authScope)
class ILPService implements Disposable {
  ILPService(
    this._repository,
    this._createIncomingEscrow,
    this._ecClient,
    this._refreshBalance,
    this._txConfirm,
  );

  final ILPRepository _repository;
  final CreateIncomingEscrow _createIncomingEscrow;
  final EspressoCashClient _ecClient;
  final RefreshBalance _refreshBalance;
  final TxConfirm _txConfirm;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  void _subscribe(String id) {
    _subscriptions[id] = _repository
        .watch(id)
        .whereNotNull()
        .asyncExpand<IncomingLinkPayment?>((payment) {
      switch (payment.status) {
        case ILPStatusTxCreated():
          return _send(payment).asStream();
        case ILPStatusTxSent():
          return _wait(payment).asStream();
        case ILPStatusSuccess():
        case ILPStatusTxFailure():
          _subscriptions.remove(id)?.cancel();

          return null;
      }
    }).listen((payment) => payment?.let(_repository.save));
  }

  Future<IncomingLinkPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    final status = await _createTx(
      escrow: escrow,
      account: account,
    );

    final id = const Uuid().v4();

    final payment = IncomingLinkPayment(
      id: id,
      created: DateTime.now(),
      escrow: await escrow.let(EscrowPrivateKey.fromKeyPair),
      status: status,
    );

    await _repository.save(payment);
    _subscribe(id);

    return payment;
  }

  Future<IncomingLinkPayment> retry(
    IncomingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      escrow: await payment.escrow.keyPair,
      account: account,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);
    _subscribe(payment.id);

    return newPayment;
  }

  Future<ILPStatus> _createTx({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    try {
      final transaction = await _createIncomingEscrow(
        escrowAccount: escrow,
        receiverAccount: account.publicKey,
        commitment: Commitment.confirmed,
      );

      final tx = await transaction.resign(account);

      return ILPStatus.txCreated(tx);
    } on EscrowException {
      return const ILPStatus.txFailure(
        reason: TxFailureReason.escrowFailure,
      );
    } on Exception {
      return const ILPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<IncomingLinkPayment?> _send(IncomingLinkPayment payment) async {
    final status = payment.status;
    if (status is! ILPStatusTxCreated) {
      return payment;
    }

    final tx = status.tx;

    try {
      final signature = await _ecClient
          .submitDurableTx(
            SubmitDurableTxRequestDto(
              tx: tx.encode(),
            ),
          )
          .then((e) => e.signature);

      return payment.copyWith(
        status: ILPStatus.txSent(tx, signature: signature),
      );
    } on Exception {
      return payment.copyWith(
        status: const ILPStatus.txFailure(
          reason: TxFailureReason.creatingFailure,
        ),
      );
    }
  }

  Future<IncomingLinkPayment?> _wait(IncomingLinkPayment payment) async {
    final status = payment.status;

    if (status is! ILPStatusTxSent) {
      return payment;
    }

    await _txConfirm(txId: status.signature);

    int? fee;
    try {
      fee = status.tx.containsAta
          ? await _ecClient.getFees().then((value) => value.escrowPaymentAtaFee)
          : null;
    } on Object {
      fee = null;
    }

    _refreshBalance();

    return payment.copyWith(
      status: ILPStatus.success(
        tx: status.tx,
        fee: fee?.let(
          (fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc),
        ),
      ),
    );
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

extension on SignedTx {
  bool get containsAta => decompileMessage().let(
        (m) => m.instructions
            .any((ix) => ix.programId == AssociatedTokenAccountProgram.id),
      );
}
