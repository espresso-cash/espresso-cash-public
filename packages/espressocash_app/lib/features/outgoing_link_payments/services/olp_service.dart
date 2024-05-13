import 'package:dfunc/dfunc.dart';

import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../escrow_payments/create_canceled_escrow.dart';
import '../../escrow_payments/create_outgoing_escrow.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@injectable
class OLPService {
  const OLPService(
    this._repository,
    this._createOutgoingEscrow,
    this._createCanceledEscrow,
  );

  final OLPRepository _repository;
  final CreateOutgoingEscrow _createOutgoingEscrow;
  final CreateCanceledEscrow _createCanceledEscrow;

  Future<OutgoingLinkPayment> create({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    final status = await _createTx(
      amount: amount,
      account: account,
    );

    final id = const Uuid().v4();

    final payment = OutgoingLinkPayment(
      id: id,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingLinkPayment> retry(
    OutgoingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = await _createTx(
      amount: payment.amount,
      account: account,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OutgoingLinkPayment> cancel(
    OutgoingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = payment.status;

    final OLPStatus newStatus;
    if (status is OLPStatusTxFailure) {
      newStatus = OLPStatus.canceled(
        txId: null,
        timestamp: DateTime.now(),
      );
    } else {
      final escrow = status.mapOrNull(
        linkReady: (it) => it.escrow,
        cancelTxFailure: (it) => it.escrow,
      );

      if (escrow == null) {
        return payment;
      }

      newStatus = await _createCancelTx(
        escrow: await Ed25519HDKeyPair.fromPrivateKeyBytes(
          privateKey: escrow.bytes,
        ),
        account: account,
      );
    }

    final newPayment = payment.copyWith(status: newStatus);

    await _repository.save(newPayment);

    return newPayment;
  }

  Future<OLPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    try {
      final escrowAccount = await Ed25519HDKeyPair.random();
      final privateKey = await EscrowPrivateKey.fromKeyPair(escrowAccount);

      final rawTx = await _createOutgoingEscrow(
        senderAccount: account.publicKey,
        escrowAccount: escrowAccount.publicKey,
        amount: amount.value,
        commitment: Commitment.confirmed,
      );

      final tx = await rawTx
          .let((it) => it.resign(account))
          .letAsync((it) => it.resign(LocalWallet(escrowAccount)));

      return OLPStatus.txCreated(
        tx,
        escrow: privateKey,
        slot: BigInt.zero,
      ); //TODO remove slot
    } on Exception {
      return const OLPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OLPStatus> _createCancelTx({
    required Ed25519HDKeyPair escrow,
    required ECWallet account,
  }) async {
    final privateKey = await EscrowPrivateKey.fromKeyPair(escrow);

    try {
      final transaction = await _createCanceledEscrow(
        escrowAccount: escrow.publicKey,
        senderAccount: account.publicKey,
        commitment: Commitment.confirmed,
      );
      final tx = await transaction.let((it) => it.resign(account));

      return OLPStatus.cancelTxCreated(
        tx,
        escrow: privateKey,
        slot: BigInt.zero, //TODO remove slot
      );
    } on Exception {
      return OLPStatus.cancelTxFailure(
        escrow: privateKey,
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
