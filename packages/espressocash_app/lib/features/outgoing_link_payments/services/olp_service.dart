import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../core/amount.dart';
import '../../../core/escrow_private_key.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@injectable
class OLPService {
  const OLPService(this._client, this._repository);

  final CryptopleaseClient _client;
  final OLPRepository _repository;

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

      final dto = CreatePaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrowAccount.address,
        amount: amount.value,
        cluster: apiCluster,
      );

      final CreatePaymentResponseDto response =
          await _client.createPaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account))
          .letAsync((it) => it.resign(LocalWallet(escrowAccount)));

      return OLPStatus.txCreated(tx, escrow: privateKey, slot: response.slot);
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
      final dto = CancelPaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final response = await _client.cancelPaymentEc(dto);
      final transaction = response.transaction;
      final slot = response.slot;
      final tx = await transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account));

      return OLPStatus.cancelTxCreated(
        tx,
        escrow: privateKey,
        slot: slot,
      );
    } on Exception {
      return OLPStatus.cancelTxFailure(
        escrow: privateKey,
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
